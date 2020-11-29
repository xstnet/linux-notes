#!/bin/bash

# git pull
# gitbook build

# cd 项目根目录
cd "$( dirname "$0" )"
ROOT_PATH=`git rev-parse --show-toplevel`

cd ROOT_PATH

git pull && gitbook build

