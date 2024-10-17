# script-portfolio - disk-report.sh

## What does it do?

`disk-report.sh` uses `lsblk` and `df` to do two things:

1. Generate a simple report of:
- the list of physical storage devices that are present in the system;
- include basic information about each of them (model, size); and
- the free space on those devices.

2. E-mail this report (using `mailx`).

## Arguments

### `disk-report.sh {email-address}`

`email-address` is an email address that should be recognized and relayable by your local system.

Note that if you do not have a working email setup with SMTP and/or POP3/IMAP you may not be able to make much use of this without modification. Linux server installations won't have one unless you set it up.

## Depends on ...

`mailx`, `df`, `wc`, `grep`

## Why would I use this?

I have multiple systems generate this nightly. If a storage device suddenly disappears due to a hardware issue, I'll be able to tell sooner rather than later. This is also a simple way for me to keep up on disk space.

## Code Commentary

This was a great learning exercise about `lsblk` - for example, `lsblk` has numerous columns you can ask it to give you, each which give interesting information about any block device present in the system, and `lsblk` is quite versatile in how it can format the output.

## License

GPLv3.

