#!/usr/bin/env bash

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

# ( cd ../../; webdev build -o build )

( cd ../../; pub${extension} run build_runner build --low-resources-mode -o build )

cp -r ../../build/example ./content

rm -rf ./content/packages

cp -r ../../build/packages ./content/packages

docker build --tag echannel_web .