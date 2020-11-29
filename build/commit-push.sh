#!/bin/bash

if [ ! $1 ]; then
	echo "请输入提交信息!"
	exit 1
fi 

cd "$( dirname "$0" )"

# add files
git add --all

# add files is success?
if [ $? -ne 0 ]; then
    echo "git add 出错!"
	exit 1
fi

# git commit

git commit -m "$1"


# git commit is success?
if [ $? -ne 0 ]; then
    echo "git commit 出错!"
	exit 1
fi

# git push
git push


# git push is success?
if [ $? -ne 0 ]; then
    echo "git push 出错!"
	exit 1
fi

echo "git push success"
