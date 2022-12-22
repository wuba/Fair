#!/bin/bash

projectDir=${1}
projectName=${2}
cd "$projectDir"

zip -q -b ./ "$projectName".zip -r * .[^.]* -x "/build/*" -x "/.dart_tool/*" -x "compress_project.sh" -x "*/_MACOSX" -x "*/.DS_Store"
mv "$projectName".zip ../
exit