#!/usr/bin/env bash

rm -rf ./content web.tar.gz

# ( cd ../../; webdev build -o build )

( cd ../../; pub run build_runner build -o build )

cp -r ../../build/example ./content

rm -rf ./content/packages

cp -r ../../build/packages ./content/packages

tar -czf web.tar.gz content Dockerfile build.sh