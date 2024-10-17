# script-portfolio - Extracting files from a 7-zip archive that have filenames that are too long

## Situation

7-zip is great, and fairly common - it seems to be commonly installed on many Windows systems, and because the 7z algorithm compresses very well, I tend to use it for backup and archival purposes.

So while going through some older archives, I had a need to extract a .7z archive (big one-over 200GB) on a Linux box temporarily--and this archive was created on a Windows system. I used the `7zz` command installed from the Debian repos. 

I ran into a problem during extracting files.

## Problem

About 200 of the files would not extract; `7zz` returned the following error for all of them:

`ERROR: Cannot open output file : errno=36 : Filename too long : {name of file}`

Strange - because 7zip had no issue with me making the archive, and now it's complaining about something it made. Well - I did cross platforms, so my fault I guess.

What to do...

## Solution

### Investigation

My first thought was hoping that `7zz` had some sort of option to rename files as it extracts them.  `7zz` has lots of options; and looking through `7zz -h` and man pages led me to discover that `7zz` does not have any such option.

Some quick Internet searching showed me I'm not the only one to have encountered this. After settling on the search terms "7zip rename on extraction", I found useful information from this StackOverflow post https://stackoverflow.com/questions/53175159/rename-file-when-extracting-using-7-zip-command-line.

> I was searching for a solution myself. Of course, extracting a file to a completely different filename only makes sense if you're only extracting one file.
>   
> What I ended up doing was to extract to standard out (-so) and redirecting the output to the desired name:
> `7z e my-compressed-file.7z -so readme.txt > new-filename.txt`

All right ... not pretty, but that does give us something to work with.

### Plan

I confirmed `7zz`'s ability to extract a single file from an archive, if given the filename.

Looks like what needs to happen is I need to loop through a list of files, calling `7zz` for each file, asking it to extract to `stdout`, while redirecting it to the file I want it to exist as outside of the archive.

Will need to generate a list of files first.

### Implementation

1. To start generating our list of files, I re-extracted the archive, capturing `stderr` to a file - which is where 7zz will output the error messages containing filenames.

`7zz x archive.7z 2> stderr.txt`

2. `stderr.txt` will contain a bunch of lines that look like this:

`ERROR: Cannot open output file : errno=36 : File name too long : /home/you/really_long_filename_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.iso`

The text "ERROR: Cannot open output file : error=36 : File name too long : " is what we don't want - and that text is 66 characters long. So we can `cat` the file through `cut` and tell `cut` to omit the first 66 characters.

`cat stderr.txt | cut -c 66- > filelist.txt`

3. The next steps are too complex to do in a single line, and also I wanted to verify the names and locations were right before making 200 calls to `7zz`,  so I wrote a small script.

The script will loop on each line that is fed to it, expecting a list of filenames like we just generated. For each filename it's given, It will generate a new, length-and-content-compliant filename, and then call 7zz to extract it.

## Conclusion

This worked well, though I still find it crazy that 7-zip will let you create archives and then refuse to extract files. I feel like there should be a "rename-on-extract" option in there somewhere.

