This is a fork of https://github.com/not-jan/pass-ssh

# pass-ssh

Allows you to start an SSH session from a pass entry.

## Requirements

- [sshpass](https://linux.die.net/man/1/sshpass)
- [pass](https://www.passwordstore.org/) >= 1.7

## Installation

Drop ssh.bash into `/usr/lib/password-store/extensions` (distro specific) or `~/.password-store/.extensions/ssh.bash` and run `chmod +x` on it. Please note that for the latter you will have to manually enable this add-on. Please see [here](https://www.passwordstore.org/#extensions) for instructions on how to do that.

## Usage

1. Create a new entry in pass with the format (sshflags is optional)
   > ```
   > <password>
   > ssh: username@host
   > sshflags: -q -D 1337
   > ```
2. Run `pass ssh <path to entry> <additional parameters>`
3. You will be dropped into the requested ssh shell
