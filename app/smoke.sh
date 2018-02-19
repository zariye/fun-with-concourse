#!/bin/bash

set -e

ls
cd fun-with-concourse/app

npm install
npm build
npm install -g forever

forever start app.js

curl 'http://localhost:3000'
