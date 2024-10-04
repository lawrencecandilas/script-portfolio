# script-portfolio - archive-filelist.sh

## Arguments

`.\archive-filelist.sh {volume_name}`

## Depends on ...

- `find`, `sha224sum`, `/bin/stat`

## What does it do?

Starting at the directory where you invoke the script, `archive-filelist` will recurse through each file in each directory and output a simple CSV list of directories and files to stdout. A CSV header is output first.

Each row will contain the following data:

- volume name, SHA-2 hash, size of file in bytes, file name

The volume name is simply what you specify as the argument to the script - it's totally up to you what this is.

For directories, the string "[Directory]" will appear instead of other data for SHA-2 hash and the file size.

## Why would I use this?

If you have something that has a bunch of files that's intended to be a backup or archive, and you want to have a list of files on this medium handy for future reference, this will easily let you create one.

## License

GPLv3.

