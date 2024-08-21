# Bash scripts for personal use

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
