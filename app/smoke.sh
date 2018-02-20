#!/bin/bash

set -e

ls

cd /bin/app

npm install -g forever

forever start app.js

MY_ADDRESS=`hostname --ip-address`
sleep 5

curl http://${MY_ADDRESS}:3000
