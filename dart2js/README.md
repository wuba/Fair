# fair_dart2js

fair_compiler 的配套编译器，用于将 Dart 转为 JS。

### 开发功能记录
* try、catch
    * 不支持 on 函数 例如  on Exception catch (e,s)，此类写法将会抛弃处理，请直接写 catch (e)

### 待开发
#### 原生函数转换
* print
* Exception