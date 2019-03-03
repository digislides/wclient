#!/usr/bin/env bash

# ( cd ../../; webdev build -o build )

( cd ../../; pub run build_runner build )

cp -r ../../build/example ./content

rm -rf ./content/packages

cp -r ../../build/packages ./content/packages

docker build --tag echannel_web .