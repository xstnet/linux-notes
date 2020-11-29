#!/bin/bash

# git pull
# gitbook build

# cd 项目根目录
cd "$( dirname "$0" )"
ROOT_PATH=`git rev-parse --show-toplevel`

cd $ROOT_PATH

echo -e "当前目录: $PWD\n"

git pull 

echo -e "build start"

gitbook build

echo -e "build end"

