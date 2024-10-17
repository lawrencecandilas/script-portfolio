# script-portfolio - disk-report.sh

## What does it do?

`disk-report.sh` uses `lsblk` and `df` to generate a report of physical storage devices and their free space, and will e-mail it to an address provided.

## Functions And Arguments

### `disk-report.sh {email-address}`

`email-address` is an email address recognized and relayable by your local system. If you do not have a working Internet email setup with SMTP and/or POP3/IMAP you may not be able to make much use of this without modification.

## Depends on ...

`mailx`, `df`, `wc`, `grep`

## Why would I use this?

I have multiple systems generate this nightly. If a storage device suddenly disappears due to a hardware issue, I'll be able to tell sooner rather than later. This is also a simple way for me to keep up on disk space.

Sending emails in this fashion will require a working SMTP and IMAP or POP3 server - so something like `postfix`/`exim4` and `dovecot` would need to have been setup and/or working.

## Code Commentary

This was a great learning exercise about `lsblk` - for example, `lsblk` has numerous columns you can ask it to give you, each which give interesting information about any block device present in the system, and `lsblk` is quite versatile in how it can format the output.

## License

GPLv3.

