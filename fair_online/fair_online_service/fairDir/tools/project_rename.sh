#!/bin/bash

projectName=${1}
projectDir=${2}
originPackage=${3}
originAppName=${4}
originName=${5}
echo "projectName::$projectName,,,projectDir::$projectDir,,,originPackage::$originPackage,,,originAppName::$originAppName,,,originName::$originName"
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

# modify package and applicationId
if [[ $a =~ $b ]];then
  sed -i "" "s/${originPackage}/com.${projectName}/g" `grep ${originPackage} -rl ${projectDir}/android/*`
else
  sed -i "s/${originPackage}/com.${projectName}/g" `grep ${originPackage} -rl ${projectDir}/android/*`
fi
# modify app name
if [[ $a =~ $b ]];then
  sed -i "" "s/${originAppName}/${projectName}/g" `grep ${originAppName} -rl ${projectDir}/android/app/src/main/AndroidManifest.xml`
else
  sed -i "s/${originAppName}/${projectName}/g" `grep ${originAppName} -rl ${projectDir}/android/app/src/main/AndroidManifest.xml`
fi
# transfer android source
sourcePackage=${originPackage//.//}
echo "sourcePackage::: $sourcePackage"
rootPkgName="android/app/src/main/kotlin"
mkdir ${projectDir}/tmp
mv ${projectDir}/${rootPkgName}/${sourcePackage}/* ${projectDir}/tmp
rm -rf ${projectDir}/${rootPkgName}
mkdir -p ${projectDir}/${rootPkgName}/com/${projectName}
mv ${projectDir}/tmp/* ${projectDir}/${rootPkgName}/com/${projectName}
rm -rf ${projectDir}/tmp
# modify dart originName
if [[ $a =~ $b ]];then
  sed -i "" "s/${originName}/${projectName}/g" `grep ${originName} -rl ${projectDir}/pubspec.yaml`
  sed -i "" "s/${originName}/${projectName}/g" `grep ${originName} -rl ${projectDir}/lib/*`
  sed -i "" "s/${originName}/${projectName}/g" `grep ${originName} -rl ${projectDir}/web/*`
  sed -i "" "s/${originName}/${projectName}/g" `grep ${originName} -rl ${projectDir}/test/*`
else
  sed -i "s/${originName}/${projectName}/g" `grep ${originName} -rl ${projectDir}/pubspec.yaml`
  sed -i "s/${originName}/${projectName}/g" `grep ${originName} -rl ${projectDir}/lib/*`
  sed -i "s/${originName}/${projectName}/g" `grep ${originName} -rl ${projectDir}/web/*`
  sed -i "s/${originName}/${projectName}/g" `grep ${originName} -rl ${projectDir}/test/*`
fi