#!/usr/bin/python3
'''
Script to automatically set the tmux status line to a different color when a
ping to 8.8.8.8 fails.

All numeric color codes in this file use the 256-color codes for terminals. See
https://gist.github.com/mgedmin/2762225
'''

from collections import namedtuple
from subprocess import call, PIPE
from time import sleep
import logging
import sys

Color = namedtuple('Color', 'foreground background')
Theme = namedtuple('Theme', 'default session accent highlight')
StatusLine = namedtuple('StatusLine', 'left right main current')

LOG = logging.getLogger(__name__)
COLORS = {
    'online': Theme(
        default=Color(154, 22),
        session=Color(0, 184),
        accent=Color(120, 58),
        highlight=Color(0, 2),
    ),
    'offline': Theme(
        default=Color(226, 52),
        session=Color(0, 172),
        accent=Color(196, 88),
        highlight=Color(16, 196),
    )
}


def colored(text: str, color: Color, reverse: bool = False) -> str:
    '''
    Return *text* surrended by tmux color markup.

    If *reverse* is true, foreground and background is flipped.
    '''
    fg, bg = color
    if reverse:
        fg, bg = bg, fg
    return '#[fg=colour%d]#[bg=colour%d]%s#[default]' % (fg, bg, text)


def transition_symbol(text: str, start_color: int, end_color: int) -> str:
    '''
    Runs :py:func:`.colored` with two custom color values for fore- and
    background. This is sometimes needed for special characters which can be
    used as "transition" symbols to transition from one color to the next.

    How this is used depends largely on the symbol used, so it is necessary to
    specify colors manually.
    '''
    return colored(text, Color(start_color, end_color))


def we_are_online() -> bool:
    '''
    Runs a check which should return True when internet is available, False
    otherwise.
    '''
    ping_status = call(['ping', '-c', '1', '-W', '1', '8.8.8.8'],
                       stdout=PIPE, stderr=PIPE)
    return ping_status == 0


def get_status_items(theme: Theme) -> StatusLine:
    '''
    Prepares and returns a status-line according to a theme.
    '''
    return StatusLine(
        left=[
            colored(' #S ', theme.session),
            transition_symbol('', theme.session.background, theme.default.background),
            ' ',
        ],
        right=[
            transition_symbol('', theme.session.background, theme.default.background),
            colored(' #(date +"%d. %b %Y  %H:%M")', theme.session),
            colored('  ', theme.session),
            colored('#{host_short}', theme.session),
        ],
        main=[
            transition_symbol('', theme.default.background, theme.accent.background),
            colored(' #W ', theme.accent),
            transition_symbol('', theme.accent.background, theme.default.background),
        ],
        current=[
            transition_symbol("", theme.default.background, theme.highlight.background),
            colored(" #W ", theme.highlight),
            transition_symbol("", theme.highlight.background, theme.default.background),
        ]
    )


def set_satus_line(items: StatusLine) -> None:
    '''
    Sets the status-line in tmux
    '''
    call(['tmux', 'set-option', '-g', 'status-left', ''.join(items.left)])
    call(['tmux', 'set-option', '-g', 'status-right', ''.join(items.right)])
    call(['tmux', 'set-option', '-g', 'window-status-format', ''.join(items.main)])
    call(['tmux', 'set-option', '-g', 'window-status-current-format', ''.join(items.current)])


def main() -> None:
    '''
    The main entry-point
    '''

    last_theme = None
    while True:
        theme_name = 'online' if we_are_online() else 'offline'
        theme = COLORS[theme_name]

        if theme != last_theme:
            LOG.info('Switching to %s', theme_name)
            # Set the default status-line color
            call(['tmux', 'set-option', 'status-bg', 'colour%d' % theme.default.background])
            call(['tmux', 'set-option', 'status-fg', 'colour%d' % theme.default.foreground])

            # Set the Theme
            items = get_status_items(theme)
            set_satus_line(items)
            last_theme = theme
        sleep(1)


if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        sys.exit(0)
