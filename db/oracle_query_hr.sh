#!/bin/sh

USERNAME="hr"
PASSWORD="hr"
URL="TSMRDB"
echo "username=$USERNAME"

sqlplus -S ${USERNAME}/${PASSWORD}@${URL}  <<EOF
  SELECT * FROM EMPLOYEES;
  exit;
EOF
