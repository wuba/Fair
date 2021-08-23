          
        
    require('./string.js')

    function testStringExtend(){
    
        // 返回索引处的ascii
        console.log( 'nihao'.codeUnitAt(0) );
        // 依次对比指定索引字段在ascii中字符串值比较大小 0相等 1大于 -1小于
        console.log( '121'.compareTo('13'));


        // 是否包含
        console.log('nihao'.contains('hao'));

        // 传入长度，从左侧填充空格
        console.log('nihao'.padLeft(10));

        // 传入长度，从右侧填充空格
        console.log('nihao'.padRight(7));

        // 用方法返回值替换指定字符串
        // console.log('nihao'.replaceAllMapped('ni', (Match) => 'wo'))
 
        // 替换第一个
        console.log('nihaoni'.replaceFirst('ni', 'wo'))
        // 替换第一个，可传function
        console.log('nihaoni'.replaceFirstMapped('ni', (Match) => 'wo'))

        // 指定起始位置替换
        console.log('nihaoni'.replaceRange(5,7,'women'))

        // 查询指定字符，用onMatch的返回值替换“，”用onNonMatch的返回值替换其他
        console.log('nihaoni'.splitMapJoin(',',(Match)=>"a",(nonMatch)=>"b"));

        console.log('abc'.codeUnits)
        

        console.log('12'.isEmpty)
    }

    testStringExtend();

        
       
   