#!/bin/sh

PWD="$(pwd)"
TWD="$(dirname "$0")/.."

cd $TWD

docker-compose stop paper

cd $PWD

