### 不支持清单

#### 变量
  * const map = {if (i is int) i: 'int'}; // Use is and collection if.
  * const set = {if (list is List<int>) ...list}; // ...and a spread.
  * var s = r'In a raw string, not even \n gets special treatment.';  // r修饰符

#### 构造
  * var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
  * int.parse
  * double.parse
  * 列表、Map对象、RegExp、Date、其他基础数据类型及其对应操作
   
#### Function

* bug2
```
bool fun3(int p3) => _nobleGases[p3] != null;

## 输出为以下 缺少 return

function fun3(p3) { 
      _nobleGases.__op_idx__(p3)!=null
    }

```

#### 操作符
* ~/ 不支持
* as 关键字 被舍弃
* is 关键字被舍弃
* expr1 ?? expr2 不支持 （var x= name ?? 'Guest';）
* ?.. 操作不支持  querySelector('#confirm')?..text = 'Confirm' 

#### 条件判断
* switch 中使用 continue   不支持
```
var command = 'CLOSED';
switch (command) {
  case 'CLOSED':
    executeClosed();
    continue nowClosed;
  nowClosed:
  case 'NOW_CLOSED':
    executeNowClosed();
    break;
}
```
#### Class 该功能暂不支持 (可以支持)
* 解析异常 
```
class Point {
  double x = 0;
  double y = 0;
  Point(double x, double y) {
    this.x = x;
    this.y = y;
  }
}
```
* mixins 不支持
* get , set 不支持（技术上可行）
#### @注解 
不支持




