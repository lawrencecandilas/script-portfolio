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

If you have something holding a bunch of backup or archive files, and you want to generate a CSV listing of them for future reference or database import, this will easily let you do that.

## License

GPLv3.

