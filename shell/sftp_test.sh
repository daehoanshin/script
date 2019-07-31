#!/bin/bash

date=`date -d "-1 days" "+%Y%m%d"`
user=hotellogc
host=121.252.99.178
secretkey="P@ssw0rd"
encpwd="U2FsdGVkX1+IGRaCDI3ZjJackLpkwMncw9a4xIx3g7Q="
pwd=`echo ${encpwd} | openssl enc -aes-128-cbc -a -d -pass pass:${secretkey}`

expect -c "
spawn sftp ${user}@${host}
expect \"*?assword:*\"
send \"${pwd}\n\"
expect \"sftp>\"
send \"pwd\r\"
send \"mget *${date}*.txt\r\"
send \"exit\r\"
interac
