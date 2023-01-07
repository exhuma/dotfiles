[//]: # (NOTE: This is a copy of https://gist.github.com/F21/b0e8c62c49dfab267ff1d0c6af39ab84)
[//]: # (Having a local copy prevents link-rot)
[//]: # (------------------------------------------------------------------------)

This is a quick guide of the commands we use to sign someone's GPG key in a virtual key signing party.

*Note: The steps cover only the technical aspects of signing someone's key. Before signing someone's key, you must verify their identity. This is usually done by showing government-issued ID and confirming the key's fingerprint*

The commands will work for both GPG and GPG2.

I use Julian's key for the examples. His key id is `2AD3FAE3`. You should substitute with the appropriate key id when running the commands.

# Signing the key
1. List the keys currently in your keyring: `gpg --list-keys`.

2. I want to sign Julian's key, so I pull it into my keyring: `gpg --recv-keys 2AD3FAE3`. If Julian's key is already in my keyring, it's a good idea to pull it again, so that my keyring is up to date.
    1. If the default keyserver (`keys.gnupg.net`) is not responsive, use the MIT or Ubuntu keyserver: `gpg --keyserver pgp.mit.edu --recv-keys 2AD3FAE3` or `gpg --keyserver keyserver.ubuntu.com --recv-keys 2AD3FAE3`

3. I then sign Julian's key: `gpg --sign-key 2AD3FAE3`. If a GPG agent is not running, you will be prompted for your private key's passphrase.

4. After signing, the key, I will then encrypt the signed key with Julian's public key (you will be asked for your passphrase to sign it as well, so that the receiver can verify that you are the sender):

```
gpg -a --export 2AD3FAE3 | gpg -se -r 2AD3FAE3 > ~/tmp/2AD3FAE3.asc.pgp
```

5. I then email `2AD3FAE3.asc.gpg` to Julian. In this case, I email it to the address in his key (`jhyde@ap.....org`) as the key states that he controls that address.

6. Once Julian receives the encrypted message, he decrypts it and imports it into his keyring:
```
gpg --decrypt 2AD3FAE3.asc.pgp
gpg --import 2AD3FAE3.asc
```

7. He can then send his key with the attached signatures to the various keyservers:
```
gpg --send-keys 2AD3FAE3
gpg --keyserver pgp.mit.edu --send-keys 2AD3FAE3
gpg --keyserver keyserver.ubuntu.com --send-keys 2AD3FAE3
```

8. The keyserver will merge his signature with those available for hiss key. Wait a few moments for the merging to complete and check that everything worked by visiting the following:
```
https://keyserver.ubuntu.com/pks/lookup?search=0xDDB6E9812AD3FAE3&op=vindex
https://pgp.mit.edu/pks/lookup?op=vindex&search=0xDDB6E9812AD3FAE3
https://keyserver.ntzwrk.org/pks/lookup?op=vindex&fingerprint=on&search=0xDDB6E9812AD3FAE3
```

I can see my signature for Julian's key on all those servers, so that means his key was signed correctly.

# Sending the keys directly to the keyservers instead of having the owner upload them (NOT RECOMMENDED!)
**NOTE:**
According to this [blog post](https://carouth.com/blog/2014/05/25/signing-pgp-keys/), pushing the signed key directly to the keyserver is not good practice, because it does not prove ownership of the key. 

After finishing step 3 of the previous instructions:

4. Send the keys to the GNU, MIT and Ubuntu keyservers directly:
```
gpg --send-keys 2AD3FAE3
gpg --keyserver pgp.mit.edu --send-keys 2AD3FAE3
gpg --keyserver keyserver.ubuntu.com --send-keys 2AD3FAE3
```

5. The keyserver will merge our signature with those available for Julian's key. Wait a few moments for the merging to complete and check that everything worked by visiting the following:
```
https://keyserver.ubuntu.com/pks/lookup?search=0xDDB6E9812AD3FAE3&op=vindex
https://pgp.mit.edu/pks/lookup?op=vindex&search=0xDDB6E9812AD3FAE3
https://keyserver.ntzwrk.org/pks/lookup?op=vindex&fingerprint=on&search=0xDDB6E9812AD3FAE3
```

I can see my signature for Julian's key on all those servers, so that means his key was signed correctly.

# Updating your key in the KEYS file
If you are a PMC member, update or add your key to the `KEYS` file at http://www.apache.org/dist/calcite/KEYS.

To generate the appropriate output, run: `gpg --list-sigs 2AD3FAE3 && gpg --armor --export 2AD3FAE3`.

Paste the output into the `KEYS` files and commit it to the SVN repo by following these [instructions](https://www-eu.apache.org/dev/release-signing.html#keys-policy).
