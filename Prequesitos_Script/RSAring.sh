#!/bin/bash
echo "$2" > userpass.txt
nmap -n -sn $3 -oG - | awk '/Up$/{print $2}' > ips.txt
 while read LINE; 
do 
last=$(echo $LINE|cut -d"." -f4)
if [ $last = $(echo "1") ]
then
        echo "Es el router"
else
echo "The IP will be configured is: $LINE"
      sshpass -f userpass.txt ssh-copy-id $1@$LINE
fi
done < ips.txt
rm -rf userpass.txt ips.txt
