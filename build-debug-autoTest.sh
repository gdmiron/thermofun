#!/bin/bash

J=10

while [[ $# > 2 ]]
do
key="$2"

case $key in
    -j)
    J="$3"
    shift
    ;;
    *)

    ;;
esac
shift
done

CMAKE_FILE_DIR=$(pwd)

mkdir -p ../build/debug

cd ../build/debug/

cmake ../../thermofun/ $CMAKE_FILE_DIR -DBUILD_TESTS=ON -DCMAKE_BUILD_TYPE=Debug

make -j$J

cd tests

cd autoTest

./autoTest


