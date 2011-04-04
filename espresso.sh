#!/bin/bash

echo -e "\n##### Stop the server"
thin stop -C config/thin-config.yml
rake tmp:pids:clear

echo -e "\n##### Git pull"
git pull

echo -e "\n##### Database unmigrate"
rake db:migrate VERSION=0

echo -e "\n##### Database migrate"
rake db:migrate

echo -e "\n##### Start the server"
thin start -C config/thin-config.yml

