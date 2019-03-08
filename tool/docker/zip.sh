#!/usr/bin/env bash

rm -rf ./content web.tar.gz

extension=

case "$(uname -s)" in
    Linux*)
      ;;
    Darwin*)
      ;;
    CYGWIN*)
      extension=.bat
      ;;
    MINGW*)
      extension=.bat
      ;;
    *)
      echo Unknown terminal!
      exit -1
esac

# ( cd ../../; webdev${extension} build -o build )
( cd ../../; pub${extension} run build_runner build -o build )

cp -r ../../build/example ./content

rm -rf ./content/packages

cp -r ../../build/packages ./content/packages

tar -czf web.tar.gz content Dockerfile build.sh