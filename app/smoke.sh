#!/bin/bash

set -e

ls
echo 'access folder'
cd fun-with-concourse/app

echo 'start application'
npm install
npm build
node app.js
