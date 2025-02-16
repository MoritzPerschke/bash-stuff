# Bash scripts for personal use

## install
Uses `ln` to link each `./script.sh` to `$HOME/.local/bin/script` so that they can be used as any other command.

## getlast
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
## archive
Simple archiving script, walks all subdirectories in current dir
    - pulls in every directory which contains a `.git` directory
    - deletes `build` `target` `env` directories

## pinger
As part of my job at the [Innbsrucker Zeitungsarchiv](https://www.uibk.ac.at/iza/), I need to know whenever one of the websites goes down.
This script requires the file `$HOME/.ping_urls.txt`, which should contain one URL per line.
It then uses `curl` to get a status code from each of the urls in turn, and prints it.
