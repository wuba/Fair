#!/bin/bash

pageName=${1}
originName=${2}
projectName=${3}
originProjectName=${4}
pageDir=${5}
echo "pageName::$pageName,,,originName::$originName,,,projectName::$projectName,,,originProjectName::$originProjectName,,,pageDir::$pageDir"
a=`uname  -a`
b="Darwin"
c="centos"
d="ubuntu"
if [[ $a =~ $b ]];then
    echo "mac"
elif [[ $a =~ $c ]];then
    echo "centos"
elif [[ $a =~ $d ]];then
    echo "ubuntu"
else
    echo "os:::$a"
fi

if [[ $a =~ $b ]];then
  sed -i "" "s/${originName}/${pageName}/g" `grep ${originName} -rl ${pageDir}*`
  sed -i "" "s/${originProjectName}/${projectName}/g" `grep ${originProjectName} -rl ${pageDir}*`
else
  sed -i "s/${originName}/${pageName}/g" `grep ${originName} -rl ${pageDir}*`
  sed -i "s/${originProjectName}/${projectName}/g" `grep ${originProjectName} -rl ${pageDir}*`
fi