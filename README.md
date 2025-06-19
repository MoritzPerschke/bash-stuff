# Bash stuff for personal use

## Customizations
### Aliases
Relevant aliases have a check to only be applied if the relevant tools are availabe

- alias cat to use batcat 
- alias `xclipboard` to place input in system clipboard, use like so: `cat <file> | xlipboard`
- alert: send notification once command is done, use like so: `alert; sleep 10`
- `ll` to output in human readable
- typo fixers and `s` function shorts e.g. `s0`->`s 0`
- git shortcuts e.g. `gs`->`git status`, `gc`->`git commit -m`

### Functions

- `vim`: function to wrap nvim, if given a file opens the file, otherwise opens current dir
- `dezip` and `detar`: extract given archive and delete it

The following things are stolen from DaveEddy(bahamas10)

- `clock`: print current timestamp
- the neat 'cd-stack' utility:
    - `cd` pushes current dir on stack before moving
    - `s` shows the stack of past dirs
    - `b` moves to previous dir
- `commas`: add commas to long numbers
- `field`: gets a field from data
- `gaps`: print gaps in numbers

### Configuration
- set neovim to default editor
- ignore duplicate lines and lines starting with space in history
- Case-insensitive autocomplete
- Couple things from (bash-sensible)[https://github.com/mrzool/bash-sensible/blob/master/sensible.bash]
    - Magic space
    - Timestamps in history
    - Pseudo-`Ctrl-r` for arrow keys
- Custom PS1 Line:
    - Git info only shown when in a git directory
    - Emoji changes on exitcode
    - 24h timestamp
```bash
┌─[moritz@pop-os]─(main ✗)(~/.bash-git)
└─[00:00] (>ᴗ<) $
```

### Git configuration
Not sure if i really want to keep this, but it should make sense on basically all of my devices
- Set name and email
- Color UI
- pull rebase=false
- Use neovim as mergetool, layout: [Local, Merged, Remote]

## Scripts
### install
Uses `ln` to link each `./<scriptname>.sh` to `$HOME/.local/bin/script` so that they can be used as any other command.
Creates a `~/.bashrc.d` directory and symlinks all the config stuff
appends to existing bashrc to source everything in the new dir

### getlast
When doing something in my shell that I then later want to share, for example the setup for a project or homework where I have collaborators, it's really annoying to then later go through my history and copy each command one by one.
I also don't like using `script`, as I often `ls` or `cat` stuff, and those don't need to be in there either.
So with this script, whenever I run a relevant command I can then run `getlast` to append it to a sort of 'condensed history' file.
By default this file is called `shorthist.txt`, but the name can also be specified.
The script also supports a couple options:
```bash
    -s <filename> : Append last command and turn (specified) shorthist file into a shell script with name <filename>
    -S <filename> : Same as above, but does not append anything, just turn the file into a script
    -d            : delete the file
    -h            : help
    
```
### archive
Simple archiving script, walks all subdirectories in current dir
    - pulls in every directory which contains a `.git` directory
    - deletes `build` `target` `env` directories
Written to archive my Uni work at the end of the semester

### pinger
As part of my job at the [Innbsrucker Zeitungsarchiv](https://www.uibk.ac.at/iza/), I need to know whenever one of the websites goes down.
This script requires the file `$HOME/.ping_urls.txt`, which should contain one URL per line.
It then uses `curl` to get a status code from each of the urls in turn, and prints it.


