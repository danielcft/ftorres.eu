# find -exec

The other day I needed to convert some flac files to apples proprietary format (alac).

I had already written a bash script for this purpose.
The script would recursivelly find all flacs and convert them using ffmpeg.

```
#! /bin/bash
# convert FLAC to ALAC (Apple's proprietary format)
# usage: Copy flacs and this script to a TEMP folder. Run script. Parameters: None.

shopt -s globstar
for flac_filepath in ./**/*.flac; do
    [ -e "$flac_filepath" ] || continue
    alac_filepath=${flac_filepath/flac/m4a}
    ffmpeg -i "$flac_filepath" -c:a alac -c:v copy "$alac_filepath"
done

# after everything went well, use this command to delete flacs
# find . -maxdepth 10 -name "*.flac" -delete
```

All nice and dandy.

 Except that it would not work on the Mac I was using, because it's version of bash is ancient and does not support globstar. 

Okay, time to man up and convert this to good old POSIX script so that I never need to touch it again.
It should:
* Find all .flac files on the current directory and below, recursivelly
* Convert each of those .flac to alac. 

The best I could think of was to use 'find' together with the '-exec' argument + an auxiliary script.

```
#!/bin/sh
find . -name "*.flac" -exec ./f.sh '{}' \;
```

where f.sh is a script in the same directory that takes one file path and performs the conversion 

```
#!/bin/sh
ffmpeg -i "$1" -c:a alac -c:v copy "$(echo "$1" | sed "s/flac/m4a/")" 
```

This works. But I really don't like to have an auxiliary script. I want a single and self contained script!
After some hammering, I arrived at this:

```
find . -name "*.flac" -exec sh -c '
        ffmpeg -i "$1" -c:a alac -c:v copy "$(echo "$1" | sed "s/flac/m4a/")"' sh {} ';'
```

Ugly, but does the job.
