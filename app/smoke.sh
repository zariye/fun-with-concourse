#!/bin/bash

set -e

ls
cd fun-with-concourse/app

npm install
npm build
npm install -g forever

forever start app.js

echo 'ip addresses'
ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2

curl http://localhost:3000
