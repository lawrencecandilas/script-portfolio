# script-portfolio - valid_ip library

## What does it do?

`valid_ip` is a small library containing two functions to test if a string is a valid IPv4 address and if the IPv4 address is routable or not.

Note: IPv4 addresses in any form other than n.n.n.n where n is a integer number 0-255 are not recognized as valid by this function.

The code here does nothing on its own; it must be sourced in and called by a script you would write. You can see a test function I commented out once I was satified it was working OK.

## Functions And Arguments

### `is_ipv4_valid {string}`

Returns 1 if `string` is a valid IPv4 address, 0 if it is not.

Note: IPv4 addresses in any form other than n.n.n.n where n is a integer number between 0-255 are not recognized as valid by this function.

The array @IPV4_OCTET will be created and modified by this function and will contain each octet. Invalid IPv4 addresses may still cause this array to be created and/or modified.

### `is_ipv4_nonroutable {string}`

Returns the following:

- 127 if `string` is not a valid IPv4 address.

- 1 if `string` is an IPv4 address that is nonroutable. Non-routable means your ISP will not route it; this applies to the typical IANA private ranges (10.0.0.0/8, 172.16.0.0/12, and 192.168.0.0/16), as well as localhost (127.0.0.0/8), all-ones (255.255.255.255) and all-zeroes (0.0.0.0).

The variable IPV4_TYPE will be modified to one of the following strings if the provided IPv4 is valid:

- Nonroutable: `zero`, `all-ones`, `private`, `localhost`

- Routable: `public`

This function depends on and uses is_ipv4_valid().

The array @IPV4_OCTET will be modified by this function and will contain each octet. 

## Depends on ...

Nothing in this library calls external commands.

## Why would I use this?

My motivation for this was input validation - to make sure IP addresses read from command line arguments or files were valid before using them.

## Code Commentary

Doing anything "programmey" in `bash` typically means fighting with weird syntax, brackets/braces/parentheses everywhere, and other stuff that is taxing on my brain. I fought back with unreasonably long variable names. It should be super clear what is happening.

Overall I wrote this because I'm not an expert at regex and really wanted something I understood and knew worked. Also, I kinda enjoy writing parsing code, it's fun. I feel pretty good about its robustness.

## License

GPLv3.

