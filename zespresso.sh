#!/bin/bash

IP="203.159.76.62"

echo -e "\n##### stop srv"
ssh root@$IP 'srv_stop'

echo -e "\n##### Export current app to srv"
scp -r ../Nuit2010 root@$IP:/srv/www/htdocs/

echo -e "\n##### start srv"
ssh root@$IP 'srv_start'
