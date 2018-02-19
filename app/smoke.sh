#!/bin/bash

set -e

ls
cd fun-with-concourse/app

npm install
npm build
npm install -g forever

forever start app.js

echo 'ip addresses'

curl http://10.254.0.14:3000
