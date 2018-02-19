#!/bin/bash

set -e

ls
cd fun-with-concourse/app

npm install
npm build
node app.js &

curl 'http://localhost:3000'
