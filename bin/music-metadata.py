#!/usr/bin/env python3
"""
Helper-script to dump music metadata from the linux "playerctl" command into
text-files for use in applications like OBS
"""
from time import sleep
from subprocess import check_output

from dataclasses import dataclass
from os.path import splitext, join
from os import makedirs
import logging
import shutil

LOG = logging.getLogger(__name__)


@dataclass
class Image:
    data: bytes
    extension: str


@dataclass
class Meta:
    title: str
    album: str
    artist: str
    cover: Image

    @staticmethod
    def unknown():
        return Meta(title="-", album="-", artist="-", cover=Image(b"", ".png"))

    def is_unknown(self):
        return self == Meta.unknown()


def call():
    try:
        output = check_output(["playerctl", "metadata"])
    except:
        LOG.error("Unable to fetch metadata (playerctrl metadata failed)")
        return ""
    return output.decode("utf8")


def load_cover(file_url: str) -> bytes:
    if file_url.startswith("file://"):
        try:
            with open(file_url[7:], "rb") as fptr:
                return fptr.read()
        except FileNotFoundError:
            LOG.error("File %r not found", file_url)
            return b""
    else:
        return b""


def parse(data: str) -> Meta:
    if not data:
        return Meta.unknown()
    dictified = {}

    for line in data.splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            _, field, value = line.split(maxsplit=2)
        except:
            LOG.warning(
                "Unable to parse data: did not get the expected 3 fields in "
                "line %r",
                line,
            )
            field = ""
        dictified[field.strip()] = value.strip()
    cover_url = dictified.get("mpris:artUrl", "")
    cover = load_cover(cover_url)
    _, extension = splitext(dictified.get("mpris:artUrl", ".png"))
    return Meta(
        title=dictified.get("xesam:title", "unknown title"),
        album=dictified.get("xesam:album", "unknown album"),
        artist=dictified.get("xesam:artist", "unknown artist"),
        cover=Image(cover, extension),
    )


def write_output(target_folder: str, meta: Meta) -> None:
    makedirs(target_folder, exist_ok=True)
    if meta.cover and meta.cover.extension:
        cover_fn = join(target_folder, f"music-cover{meta.cover.extension}")
        with open(cover_fn, "wb") as fptr:
            fptr.write(meta.cover.data)
    else:
        shutil.copy("obs-resources/generic-album.png", "music-cover.png")
    with open(join(target_folder, "artist.txt"), "w") as fptr:
        fptr.write(meta.artist)
    with open(join(target_folder, "album.txt"), "w") as fptr:
        fptr.write(meta.album)
    with open(join(target_folder, "title.txt"), "w") as fptr:
        fptr.write(meta.title)
    with open(join(target_folder, "nowplaying.txt"), "w") as fptr:
        fptr.write(f"{meta.artist} - {meta.title}")


def write_unknown(target_folder: str) -> None:
    makedirs(target_folder, exist_ok=True)
    cover_fn = join(target_folder, f"music-cover.png")
    shutil.copy("obs-resources/generic-album.png", cover_fn)
    with open(join(target_folder, "artist.txt"), "w") as fptr:
        fptr.write("unknown artist")
    with open(join(target_folder, "album.txt"), "w") as fptr:
        fptr.write("unknown album")
    with open(join(target_folder, "title.txt"), "w") as fptr:
        fptr.write("unknown title")
    with open(join(target_folder, "nowplaying.txt"), "w") as fptr:
        fptr.write(f"unknown artist - unknown title")


def main() -> int:
    old_meta = None
    output_folder = "obs-resources"
    while True:
        data = call()
        meta = parse(data)
        if not meta.is_unknown() and meta != old_meta:
            write_output(output_folder, meta)
            old_meta = meta
            LOG.info("Written meta-data to %r", output_folder)
        elif meta.is_unknown() and meta != old_meta:
            write_unknown(output_folder)
            LOG.info("Unknown metadata")
        sleep(1)


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    try:
        main()
    except KeyboardInterrupt:
        pass
