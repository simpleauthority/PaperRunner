#!/bin/sh

PWD="$(pwd)"
TWD="$(dirname "$0")/.."

cd $TWD

docker-compose up -d paper

cd $PWD
