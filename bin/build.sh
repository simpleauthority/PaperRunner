#!/bin/sh

PWD="$(pwd)"
TWD="$(dirname "$0")/.."

cd $TWD

docker-compose build . --no-cache

cd $PWD
