#!/bin/bash

# PaperRunner - download the latest Paper build for a given version and run the server all in one script
# Copyright (C) 2020 Jacob Andersen (simpleauthority)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.


# AIO script for downloading the latest Paper jar from the official source and running it.
# This script does NOT offer the capability to download the latest build globally so as to prevent catastrophic issues.
# This script does however offer the capability of downloading the latest build within a specified distinct version so as to remain up to date within a given major.
# Aikar's flags are applied automatically.

# Arguments provided to script via runtime environment variables. All are required:
## VERSION: paper version to download (e.g. 1.14.3, 1.15.2, 1.16.5, 1.17.1)
## BUILD: build (see API) within the VERSION to use; specify "latest" to download the latest build within the VERSION.
## RAM: the RAM to allocate to the server; by convention Xms should equal Xmx so there is only one RAM object. Specify in gigabytes. 10 is the recommended value. Ensure you account for JVM overhead.

# Script begins...
# Do not edit below this line unless you know what you are doing:

if [ -z ${VERSION+x} ]; then
  echo "!! Must specify version! Try VERSION=1.17.1." && exit 1;
fi

if [ -z ${BUILD+x} ]; then
  echo "!! Must specify build number or \"latest\"! Try BUILD=latest." && exit 1;
fi

if [ -z ${RAM+x} ]; then
  echo "!! Must specify RAM in gigabytes. Try RAM=10." && exit 1;
fi

JAR_FILE_NAME=""

function downloadPaper() {
  BUILD_NUM="$BUILD"

  if [ "$BUILD_NUM" = "latest" ]; then
    echo ">> Getting latest Paper build for version $VERSION..."
    BUILD_NUM="$(curl --proto '=https' --tlsv1.2 -sSf https://papermc.io/api/v2/projects/paper/versions/"$VERSION" | jq -r '.builds[-1]')"
  else
    echo ">> Checking requested Paper build $BUILD_NUM is valid for version $VERSION..."
    OK="$(curl --proto '=https' --tlsv1.2 -sSf https://papermc.io/api/v2/projects/paper/versions/"$VERSION" | jq -r '.builds | index('"$BUILD_NUM"')')"

    if [ "$OK" = "null" ]; then
      echo "!! Requested build number $BUILD_NUM is invalid for specified version. Please correct your arguments." && exit 1;
    else
      echo ">> Requested build number $BUILD_NUM is valid"
    fi
  fi

  JAR_FILE_NAME="paper-$VERSION-$BUILD_NUM.jar"

  echo ">> Downloading $JAR_FILE_NAME..."
  curl -sSfLo "$JAR_FILE_NAME" "https://papermc.io/api/v2/projects/paper/versions/$VERSION/builds/$BUILD_NUM/downloads/$JAR_FILE_NAME"

  echo ">> Paper downloaded."
}

function runPaper() {
  if [ -z "$JAR_FILE_NAME" ]; then
    echo "Jar file name is unknown. Please check the above output for errors and report this issue." && exit 1;
  fi

  java -Xms"$RAM"G -Xmx"$RAM"G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar "$JAR_FILE_NAME" nogui
}

echo ">> Checking jar file..."
downloadPaper

echo ">> Running server..."
runPaper

echo ">> Goodbye."
