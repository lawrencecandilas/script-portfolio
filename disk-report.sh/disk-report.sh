#/bin/bash

if [[ "$1" == "" ]]; then
 echo "Missing parameter (e-mail address)."
 exit 1
 fi

output() {
 echo -e "$BODY\n" | /usr/bin/mailx -s "$SUBJECT" "$1"
 exit 0
}

LSBLK=`/usr/bin/lsblk -n -l -A -d -o NAME,SIZE,MODEL,SERIAL | /usr/bin/grep -v loop`
if [[ "$?" != "0" ]]; then
 SUBJECT="$HOSTNAME: /usr/bin/lsblk call failed"
 BODY="lsblk reported an error - unable to provide physical storage device information."
 output
 fi

DF=`/usr/bin/df -h | /usr/bin/grep "^/dev" | /usr/bin/grep -v loop`
if [[ "$?" != "0" ]]; then
 DF="df reported an error - unable to provide storage free-space information."
 fi

LSBLK_WC=`echo "$LSBLK" | /usr/bin/wc -l`
SUBJECT="$HOSTNAME: $LSBLK_WC physical storage device(s) present"
BODY="For $HOSTNAME...\nDisks:\n$LSBLK\n\nFree Space:\n$DF"
output
