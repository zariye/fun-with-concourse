#!/bin/bash

set -e

echo 'ip addresses'
MY_ADDRESS=`hostname --ip-address`

curl http://${MY_ADDRESS}:3000
