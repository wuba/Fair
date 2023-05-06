#文件合并先后顺序
fileArr=(duration.js iterable.js date.js list.js map.js set.js number.js regex.js string.js symbol.js)
echo "开始合并..."
readPath=$(pwd)/
# echo $readPath
if [ ! -f ${readPath}core.js ];then
echo "检测当前目录是否存在合并文件..."
else
echo "存在..."
rm -f ${readPath}core.js
fi 

# ls *.js | grep -v .test.js |

for item in ${fileArr[*]}
do  
    # echo $readPath${item}
    echo ";(function(){ " >> ${readPath}core.js
    cat $readPath${item} >> ${readPath}core.js
    echo "})()" >> ${readPath}core.js

done 
wait
 sed -i '' "/require(/d" ${readPath}core.js
echo "合并完成..."
