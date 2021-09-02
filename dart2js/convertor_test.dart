/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
import 'convertor.dart';
import 'dart:io' show Platform;
import 'package:path/path.dart' show dirname;

bool compare(String testcaseName, String actual, String expected) {
  if (actual.isEmpty && expected.isEmpty) {
    return true;
  }

  var isNotEqual = (actual.isEmpty && expected.isNotEmpty) ||
    (actual.isNotEmpty && expected.isEmpty);
  if (isNotEqual) {
    print('''$testcaseName Actual: $actual \r\nExpected: $expected''');
    return false;
  }

  var i = 0;
  var j = 0;
  while (i < actual.length && j < expected.length) {
    if (RegExp(r'[\s\r\n]', multiLine: false).hasMatch(actual[i])) {
      i++;
      continue;
    }
    if (RegExp(r'[\s\r\n]', multiLine: false).hasMatch(expected[j])) {
      j++;
      continue;
    }
    if (actual[i] != expected[j]) {
      print('''$testcaseName Actual: $actual \r\nExpected: $expected \r\nat position $i(${actual.substring(i, i+30)}) $j(${expected.substring(j, j+30)})''');
      return false;
    } else {
      i++;
      j++;
    }
  }
  while (i < actual.length) {
    if (RegExp(r'[\s\r\n]', multiLine: false).hasMatch(actual[i])) {
      i++;
      continue;
    } else {
      print('''$testcaseName Actual: $actual \r\nExpected: $expected \r\nat position $i(${actual[i]}) $j()''');
      return false;
    }
  }
  while (j < expected.length) {
    if (RegExp(r'[\s\r\n]', multiLine: false).hasMatch(expected[j])) {
      j++;
      continue;
    } else {
      print('''$testcaseName Actual: $actual \r\nExpected: $expected \r\nat position $i() $j(${expected[j]})''');
      return false;
    }
  }
  return true;
}

bool testcaseFor1() {
  return compare('testcaseFor1', convertFunction('''
    void testFor() {
      String b = '';
      for (int i = 0;  i< 10; i++) {
        if (i % 2 == 0) {
          b += (i * 2).toString();
        } else {
          b += 'str';
        }
      }
    }
    '''), '''
function testFor()  { 
            let b = '';
    
    for (      let i = 0;
     i < 10; i++) {
          if (i % 2 == 0) {
      b += (i * 2).toString();
    }       else {
        b += 'str';
      }
    
    
    }
    
    } 
    ''');
}

bool testcaseFor2() {
  return compare('testcaseFor2', convertFunction('''
    void testFor() {
      String b = '';
      int i = 0;
      for (;i< 10; i++) {
        if (i % 2 == 0) {
          b += (i * 2).toString();
        } else {
          b += 'str';
        }
      }
    }
    '''), '''
    function testFor()  { 
            let b = '';
    
      let i = 0;
    
    for (; i < 10; i++) {
          if (i % 2 == 0) {
      b += (i * 2).toString();
    }       else {
        b += 'str';
      }
    
    
    }
    
    }
    ''');
}

bool testcaseFor3() {
  return compare('testcaseFor3', convertFunction('''
    void testFor() {
      String b = '';
      int i = 0;
      for (;i< 10;) {
        if (i % 2 == 0) {
          b += (i * 2).toString();
        } else {
          b += 'str';
        }
        i++;
      }
    }
    '''), '''
    function testFor()  { 
            let b = '';
    
      let i = 0;
    
    for (; i < 10; ) {
          if (i % 2 == 0) {
      b += (i * 2).toString();
    }       else {
        b += 'str';
      }
    
    
i++;
    }
    
    }
    ''');
}

bool testcaseChainFor1() {
  return compare('testcaseChainFor1', convertFunction('''
    void testFor() {
      String b = '';
      int i = 0;
      for (;i< 10;) 
        for (int j = 0; j < 20; j++) {
          if (i % 2 == 0) {
            b += (i * 2).toString();
          } else {
            b += 'str';
          }
          i++;
        }
    }
    '''), '''
    function testFor()  { 
            let b = '';
    
      let i = 0;
    
    for (; i < 10; ) {
          for (      let j = 0;
     j < 20; j++) {
          if (i % 2 == 0) {
      b += (i * 2).toString();
    }       else {
        b += 'str';
      }
    
    
i++;
    }
    
    }
    
    }
    ''');
}

bool testcaseChainFor2() {
  return compare('testcaseChainFor2', convertFunction('''
    void testFor() {
      String b = '';
      int i = 0;
      for (;i< 10;) 
        for (int j = 0; j < 20; j++) 
          for (int k = 0; k < 30; k++) {
            b += 'iter';
          }
    }
    '''), '''
    function testFor()  { 
            let b = '';
    
      let i = 0;
    
    for (; i < 10; ) {
          for (      let j = 0;
     j < 20; j++) {
          for (      let k = 0;
     k < 30; k++) {
      b += 'iter';
    }
    
    }
    
    }
    
    } 
    ''');
}

bool testcaseIf() {
  return compare('testcaseIf', convertFunction('''
    void testIf() {
      int a = 1;
      String str = '';
      if (a > 10) str += a.toString();
      else {str += 'xx';}
    }
    '''), '''
    function testIf() { 
            let a = 1;
    
      let str = '';
    
    if (a>10) {
      str += a.toString()
    }       else {
        str += 'xx';
      }
    
    
    }
    ''');
}

bool testcaseIf1() {
  return compare('testcaseIf1', convertFunction('''
    void testIf() {
      int a = 1;
      String str = '';
      if (a > 10) {
        str += a.toString();
      }
    }
    '''), '''
    function testIf()  { 
            let a = 1;
    
      let str = '';
    
    if (a > 10) {
      str += a.toString();
    } 
    
    }
    ''');
}

bool testcaseIf2() {
  return compare('testcaseIf2', convertFunction('''
    void testIf() {
      int a = 1;
      String str = '';
      if (a > 10) {
        str += a.toString();
      } else {
        str += 'else';
      }
    }
    '''), '''
    function testIf()  { 
            let a = 1;
    
      let str = '';
    
    if (a > 10) {
      str += a.toString();
    }       else {
        str += 'else';
      }
    
    
    }
    ''');
}

bool testcaseIf3() {
  return compare('testcaseIf3', convertFunction('''
    void testIf() {
      int a = 1;
      String str = '';
      if (a > 10) {
        str += a.toString();
      } else if (a > 20) {
        str += 'else 20';
      } else {
        str += 'else';
      }
    }
    '''), '''
    function testIf()  { 
            let a = 1;
    
      let str = '';
    
    if (a > 10) {
      str += a.toString();
    }       else     if (a > 20) {
      str += 'else 20';
    }       else {
        str += 'else';
      }
    
    
      
    
    } 
    ''');
}

bool testcaseWhile() {
  return compare('testcaseWhile', convertFunction('''
    String testWhile() {
      int a = 1;
      while (a++ < 10) {
        bool d = true;
        d = a > 10;
      }
      return '';
    }
    '''), '''
    function testWhile()  { 
            let a = 1;
    
    while (a++ < 10)     {
            let d = true;
    
d = a > 10;
    }
    
    
    return '';
    
    }
    ''');
}

bool testcaseDoWhile() {
  return compare('testcaseDoWhile', convertFunction('''
    String testWhile() {
      int a = 1;
      do {
        bool d = true;
        d = a > 10;
      } while (a++ < 10 && d);
      return '';
    }
    '''), '''
    function testWhile()  { 
            let a = 1;
    
    do {
            let d = true;
    
d = a > 10;
    } while (a++ < 10 && d);
    
    return '';
    
    }
    ''');
}

bool testcaseChainWhile() {
  return compare('testcaseChainWhile', convertFunction('''
    String testWhile() {
      int a = 1;
      int b = 2;
      do {
        bool d = true;
        d = a > 10;
        while (b++ < 20);
      } while (a++ < 10);
      return '';
    }
    '''), '''
    function testWhile()  { 
            let a = 1;
    
      let b = 2;
    
    do {
            let d = true;
    
d = a > 10;
    while (b++ < 20) ;
    
    } while (a++ < 10);
    
    return '';
    
    }
    ''');
}

bool testcaseAsync() {
  return compare('testcaseAsync', convertFunction('''
    void testcaseAsync(FairDynamicCallback callback) async {
      bool status = await Permission.storage.isGranted;
      if(!status) {
        PermissionStatus fp = await Permission.storage.request();
        return callback(fp.isGranted);
      }
      return callback(status);
    }
    '''), '''
    async function testcaseAsync(callback) { 
            let status = await Permission.storage.isGranted;
    
    if (!status) {
            let fp = await Permission.storage.request();
    
    return callback(fp.isGranted);
    
    } 
    
    return callback(status);
    
    }
    ''');
}

bool testcaseArrowFunc1() {
  return compare('testcaseArrowFunc1', convertFunction('''
    void testcaseArrowFunc() {
      callMethodWithCallback((value) => print("_check storage permission"));
    }
    '''), '''
    function testcaseArrowFunc()  { 
          callMethodWithCallback((value)  => print("_check storage permission"));
    
    }
    ''');
}

bool testcaseArrowFunc2() {
  return compare('testcaseArrowFunc2', convertFunction(r'''
    void testcaseArrowFunc2() {
      firstColumnData = _optionalConfigModel.roomNum
        .map((String e) => WheelModel()..title = "$e室")
        .toList();
    }
    '''), r'''
    function testcaseArrowFunc2() { 
      firstColumnData = _optionalConfigModel.roomNum.map((e) => (function() {
      let __target__ = WheelModel();
          __target__.title=`${e}室`;
    
      return __target__;
    })()).toList();
    }
    ''');
}

bool testcaseTemplateString() {
  return compare('testcaseTemplateString', convertFunction('''
      void testcaseTemplateString() {
        String str = \'''template string: \${i + 1}, \${i}, \$j\''';
      }
      '''), r'''
      function testcaseTemplateString()  { 
            let str = `template string: ${i + 1}, ${i}, ${j}`;
    
    }
      ''');
}

bool testcaseTemplateString1() {
  return compare('testcaseTemplateString1', convertFunction('''
      void testcaseTemplateString1() {
        String str = '';
        str = 'template string: \${i + 1}, \${i}, \$j\';
      }
      '''), r'''
      function testcaseTemplateString1()  { 
            let str = '';
    
            str = `template string: ${i + 1}, ${i}, ${j}`;
      }
      ''');
}

bool testcaseAnonymousFunc() {
  return compare('testcaseAnonymousFunc', convertFunction('''
    void testcaseAnonymousFunc() {
      return invoke((a) {
        a++;
      });
    }
    '''), '''
    function testcaseAnonymousFunc()  { 
          return invoke(function dummy(a)  { 
      a++;
      });
    
    }
    ''');
}

bool testcaseAnonymousFunc1() {
  return compare('testcaseAnonymousFunc1', convertFunction('''
    void testcaseAnonymousFunc1() async {
      await RestClient.apiService.submitSpace(data).then((res) {
        if (JumpLoginUtil.goLogin(context, res) && res.status == '0') {
          //开始上传
          sendDataSucceed = true;
        } else {
          Toast.toast(context, msg: '网络异常，提交失败请重试');
        }
      }, onError: (e) {
        Toast.toast(context, msg: '网络异常，提交失败请重试');
      });
    }
    '''), '''
    async function testcaseAnonymousFunc1() { 
      await RestClient.apiService.submitSpace(data).then(function dummy(res)  { 
          if (JumpLoginUtil.goLogin(context,res)&&res.status=='0') {
      sendDataSucceed = true;
    }       else {
            Toast.toast(context,{msg:'网络异常，提交失败请重试'});
    
      }
    
    
    },{onError:function dummy(e)  { 
          Toast.toast(context,{msg:'网络异常，提交失败请重试'});
    
    }});
    }
    ''');
}

bool testcaseAwaitOnField() {
  return compare('testcaseAwait', convertFunction('''
    void testcaseAwait() async {
      await RestClient.apiService.submitSpace(data).promiseObj;
    }
    '''), '''
    async function testcaseAwait() { 
      await RestClient.apiService.submitSpace(data).promiseObj;
    }
    ''');
}

bool testcaseNamedParameters1() {
  return compare('testcaseNamedParameters1', convertFunction('''
    void testcaseNamedParameters1() {
      return instance.invoke(
        param1: 'param1',
        param2: 11,
        param4: a + b,
        param3: (a) {
          a++;
        }
      );
    }
    '''), '''
    function testcaseNamedParameters1()  { 
          return instance.invoke({param1:'param1',param2:11,param4:a + b,param3:function dummy(a)  { 
      a++;
      }});
    
    }
    ''');
}

bool testcaseNamedParameters2() {
  return compare('testcaseNamedParameters2', convertFunction('''
    void testcaseNamedParameters2() {
      return instance.invoke(
        'unnamed1',
        'unnamed2',
        param1: 'param1',
        param2: 11,
        param3: (a) {
          a++;
        }
      );
    }
    '''), '''
    function testcaseNamedParameters2()  { 
          return instance.invoke('unnamed1','unnamed2',{param1:'param1',param2:11,param3:function dummy(a)  { 
      a++;
      }});
    
    }
    ''');
}

bool testcaseFunctionExpression() {
  return compare('testcaseFunctionExpression', convertExpression('''
    (a) {
          a++;
        }
    '''), '''
    function dummy(a)  { 
      a++;
    }
    ''');
}

bool testcaseSimpleExpression() {
  return compare('testcaseSimpleExpression', convertExpression('''
    a+b*3%b
    '''), '''
    a + b * 3 % b
    ''');
}

bool testcaseMapLiteral() {
  return compare('testcaseMapLiteral', convertFunction('''
  void testcaseMapLiteral() {
    FairNet.request(header: {
        "Content-Type": "application/x-www-form-urlencoded"
      });
  }
  '''), '''
  function testcaseMapLiteral() { 
          FairNet.request({header: convertObjectLiteralToSetOrMap({["Content-Type"]: "application/x-www-form-urlencoded",})});
    
    }
  ''');
}

bool testcaseFunctionWithParameter() {
  return compare('testcaseFunctionWithParameter', convertFunction('''
  void testcaseFunctionWithParameter(String id) {
    FairNet.request(header: {
        data: {
          "id": id
        }
      });
  }
  '''), '''
  function testcaseFunctionWithParameter(id) { 
          FairNet.request({header: convertObjectLiteralToSetOrMap({[data]:  convertObjectLiteralToSetOrMap({["id"]: id,}),})});
    
    }
  ''');
}

bool testcaseFunctionWithNamedParameter() {
  return compare('testcaseFunctionWithNamedParameter', convertFunction('''
  void testcaseFunctionWithNamedParameter(String id, {bool flag = true, int val}) {

  }
  '''), '''
  function testcaseFunctionWithNamedParameter(id, {flag = true, val}={})  { 
          
    }
  ''');
}

bool testcaseFunctionWithNamedParameter1() {
  return compare('testcaseFunctionWithNamedParameter1', convertFunction('''
  void testcaseFunctionWithNamedParameter1({bool flag = true, int val}) {

  }
  '''), '''
  function testcaseFunctionWithNamedParameter1({flag = true, val}={})  { 
          
    }
  ''');
}

bool testcaseFunctionWithOptionalParameter() {
  return compare('testcaseFunctionWithOptionalParameter', convertFunction('''
  void testcaseFunctionWithOptionalParameter(String id, [bool flag = true, int val]) {

  }
  '''), '''
  function testcaseFunctionWithOptionalParameter(id, flag = true, val)  { 
          
    }
  ''');
}

bool testcaseFunctionWithOptionalParameter1() {
  return compare('testcaseFunctionWithOptionalParameter1', convertFunction('''
  void testcaseFunctionWithOptionalParameter1([bool flag = true, int val]) {

  }
  '''), '''
  function testcaseFunctionWithOptionalParameter1(flag = true, val)  { 
          
    }
  ''');
}

bool testcaseDotdotOperator() {
  return compare('testcaseDotdotOperator', convertFunction('''
  void testcaseDotdotOperator() {
    Commercial()..initRouter(routers)..initUIKit(uikit, _themeData)..initNetwork(network)..initLocation(location)..initPanorama(panorama);
  }
  '''), '''
  function testcaseDotdotOperator()  { 
      (function() {
      let __target__ = Commercial();
          __target__.initRouter(routers);
        __target__.initUIKit(uikit,_themeData);
        __target__.initNetwork(network);
        __target__.initLocation(location);
        __target__.initPanorama(panorama);
    
      return __target__;
    })()
    
    }
  ''');
}

bool testcaseDotdotOperator1() {
  return compare('testcaseDotdotOperator1', convertFunction('''
  void testcaseDotdotOperator1() {
    this..initRouter(routers)..initUIKit(uikit, _themeData)..initNetwork(network);
    this..initRouter(routers)..initUIKit(uikit, _themeData)..initNetwork(network);
  }
  '''), '''
  function testcaseDotdotOperator1()  { 
      (function() {
      let __target__ = this;
          __target__.initRouter(routers);
        __target__.initUIKit(uikit,_themeData);
        __target__.initNetwork(network);
    
      return __target__;
    })()
    
(function() {
      let __target__ = this;
          __target__.initRouter(routers);
        __target__.initUIKit(uikit,_themeData);
        __target__.initNetwork(network);
    
      return __target__;
    })()
    
    }
  ''');
}

bool testcaseExpr1() {
  return compare('testcaseExpr1', convertExpression('''
  (ModalRoute.of(context).settings.arguments is Map)
          ? (ModalRoute.of(context).settings.arguments as Map)[key]
          : null
  '''), '''
  (ModalRoute.of(context).settings.arguments) ? (ModalRoute.of(context).settings.arguments).__op_idx__(key) : null
  ''');
}

bool testcaseExpr2() {
  return compare('testcaseExpr2', convertExpression('''
  (aa && ModalRoute.of(context).settings.arguments is Map) ||
  ((bb > 1) && (ModalRoute.of(context).settings.arguments is Map))
  '''), '''
  (aa&&ModalRoute.of(context).settings.arguments)||((bb>1)&&(ModalRoute.of(context).settings.arguments))
  ''');
}

bool testcaseExpr3() {
  return compare('testcaseExpr3', convertExpression('''
  !(ModalRoute.of(context).settings.arguments is Map)
  '''), '''
  !(ModalRoute.of(context).settings.arguments)
  ''');
}

bool testcaseExpr4() {
  return compare('testcaseExpr4', convertFunction('''
  void testcaseExpr4() {
    if (!(ModalRoute.of(context).settings.arguments is Map)) {

    }
  }
  '''), '''
  function testcaseExpr4() {
    if (!(ModalRoute.of(context).settings.arguments)) {

    }
  }
  ''');
}

bool testcaseExpr5() {
  return compare('testcaseExpr5', convertFunction('''
  void testcaseExpr5() {
    while (!(ModalRoute.of(context).settings.arguments is Map)) {
    }
  }
  '''), '''
  function testcaseExpr5() {
    while (!(ModalRoute.of(context).settings.arguments));
  }
  ''');
}

bool testcaseContinue() {
  return compare('testcaseContinue', convertFunction('''
  void testcaseContinue() {
    for (int i = 0, j = 0; i < model.otherList.length; i++,j++) {
        if (model.otherList[i].chooseIndex == -1) {
          continue;
        }
        result[getChooseFloor(model.otherList[i].chooseIndex)] = true;
      }
    }
  '''), '''
  function testcaseContinue() { 
          for (      let i = 0,j = 0;
     i<model.otherList.length; i++,j++) {
          if (model.otherList.__op_idx__(i).chooseIndex==-1) {
      continue;
    } 
    
result.__op_idxeq__(getChooseFloor(model.otherList.__op_idx__(i).chooseIndex), true);
    }
    
    }
  ''');
}

bool testcaseCascadeFieldAccessAssign() {
  return compare('testcaseCascadeFieldAccessAssign', convertFunction('''
  void testcaseCascadeFieldAccessAssign() {
    for (int i = 0; i < groundFloor.length; i++) {
      WheelModel model = new WheelModel()..title = groundFloor[i];
      groundWheelList.add(model);
    }
  }
  '''), '''
  function testcaseCascadeFieldAccessAssign() { 
          for (      let i = 0;
     i<groundFloor.length; i++) {
            let model = (function() {
      let __target__ = new     WheelModel();
          __target__.title=groundFloor.__op_idx__(i);
    
      return __target__;
    })();
    
    groundWheelList.add(model);
    
    }
    
    }
  ''');
}

bool testcaseDeclare() {
  return compare('testcaseDeclare', convertFunction('''
  void testcaseDeclare() {
    var a = (elem) => foo(complete: (){});
    var b = 1;
    var c = '\$i \${i + 1}';
    var d = this.callMethod(a, b, c: c);
  }
  '''), '''
  function testcaseDeclare()  { 
            let a =       (elem)  => foo({complete:function dummy()  { 
      
    }});
    ;
    
      let b = 1;
    
      let c = `\${i} \${i + 1}`;
    
      let d = this.callMethod(a,b,{c:c});
    
    }
  ''');
}

bool testcaseDeclare1() {
  return compare('testcaseDeclare1', convertFunction('''
  void testcaseDeclare1() {
    var a = (elem) => foo(complete: (){});
    String b;
  }
  '''), '''
  function testcaseDeclare1() { 
            let a =       (elem) => foo({complete:function dummy() { 
      
    }});
    ;
    
      let b;
    
    }
  ''');
}

bool testcaseMethodInvoke() {
  return compare('testcaseMethodInvoke', convertFunction('''
  void testcaseMethodInvoke() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleWheel(
            data,
            "请选择室内楼层",
            initIndex: 0,
          );
        }).then((value) {
      if (value == 0) {
        counterModel.changeHouseFloor(0, 0, false);
      }
      if (value != -1 && value >= 0 && value < data.length) {
        if (value > 0) {
          showDoubleWheel(counterModel);
        }
      }
    });
  }
  '''), '''
  function testcaseMethodInvoke()  { 
          showModalBottomSheet({context:context,isScrollControlled:true,builder:function dummy(context)  { 
          return SingleWheel(data,"请选择室内楼层",{initIndex:0});
    
    }}).then(function dummy(value)  { 
          if (value==0) {
          counterModel.changeHouseFloor(0,0,false);
    
    } 
    
    if (value!=-1&&value>=0&&value<data.length) {
          if (value>0) {
          showDoubleWheel(counterModel);
    
    } 
    
    } 
    
    });
    
    }
  ''');
}

bool testcaseNew() {
  return compare('testcaseNew', convertFunction('''
  void testcaseNew() {
    UploadImage item = new UploadImage(url: image.path, status: 'LOADING');
  }
  '''), '''
  function testcaseNew()  { 
            let item = new     UploadImage({url:image.path,status:'LOADING'});
    
    }
  ''');
}

bool testcaseDeclareList() {
  return compare('testcaseDeclareList', convertFunction('''
  void testcaseDeclareList() {
    var children = <Widget>[
      Container(child: ClipRRect(borderRadius: BorderRadius.circular(4.dp))), 
      Container(child: ClipRRect(borderRadius: BorderRadius.circular(4.dp)))
    ];
  }
  '''), '''
  function testcaseDeclareList() { 
            let children = [Container({child:ClipRRect({borderRadius:BorderRadius.circular(4.dp)})}),Container({child:ClipRRect({borderRadius:BorderRadius.circular(4.dp)})})];
    
    }
  ''');
}

bool testcaseSuper() {
  return compare('testcaseSuper', convertFunctionFromData(MethodDeclarationData('testcaseSuper', '''
  void testcaseSuper() {
    super.initState();
    futureBuilderFuture = _generateData(this);
  }
  ''', false), ClassDeclarationData()..parentClass='Parent'), '''
  function testcaseSuper() { 
            const __thiz__ = this;
      
      
      with (__thiz__) {
        
Parent.prototype.initState.call(this);
futureBuilderFuture = _generateData(this);
      }
      
    
    }
  ''');
}

bool testcaseSwitch() {
  return compare('testcaseSwitch', convertFunction('''
  void testcaseSwitch() {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.active:
      case ConnectionState.waiting:
        {
          return Center(
            child: Theme(
                data: Theme.of(context)
                    .copyWith(accentColor: AJKColors.ajk58PrimaryColor),
                child: CircularProgressIndicator()),
          );
        }
      case ConnectionState.done:
        widget._hasNet = false;
        if (snapshot.hasError)
          return NoNetWorkWidget(onRefresh: () {
            futureBuilderFuture = _generateData(this);
            setState(() {});
          });
        widget._hasNet = true;
        return _createRealWidget(context, snapshot);
      default:
        return Container();
    }
  }
  '''), '''
  function testcaseSwitch() { 
          switch (snapshot.connectionState) {
          case ConnectionState.none:
        case ConnectionState.active:
        case ConnectionState.waiting:
        return Center({child:Theme({data:Theme.of(context).copyWith({accentColor:AJKColors.ajk58PrimaryColor}),child:CircularProgressIndicator()})});
    
        case ConnectionState.done:
    widget._hasNet = false;
    if (snapshot.hasError) {
      return NoNetWorkWidget({onRefresh:function dummy() { 
      futureBuilderFuture = _generateData(this);
    setState(function dummy() { 
      
    });
    
    }})
    } 
    
widget._hasNet = true;
    return _createRealWidget(context,snapshot);
    
    
          default:
          return Container();
    
    
    }
    
    }
  ''');
}

bool testcaseSwitch1() {
  return compare('testcaseSwitch1', convertFunction(r'''
  void testcaseSwitch1() {
    switch (orderDetail.orderStatus) {
      case '1':
        titleTips = '待实勘';
        desc = '上门时间：${orderDetail.serviceTimeSlot ?? ''}';
        break;
      case '2':
      case '3':
        titleTips = '审核中';
        // bottomTips = '审核时间：${getDateString(orderDetail.intelligentTime)}';
        break;
      case '4':
        titleTips = '已取消';
        if (orderDetail.tip != null && orderDetail.tip.length >= 3) {
          desc = orderDetail.tip.substring(3);
        }
        break;
      case '5':
        titleTips = '已完成';
        break;
      case '7':
        titleTips = '已驳回';
        if (orderDetail.tip != null && orderDetail.tip.length >= 3) {
          desc = orderDetail.tip.substring(3);
        }
        break;
      default:
        break;
    }
  }
  '''), r'''
  function testcaseSwitch1() { 
          switch (orderDetail.orderStatus) {
          case '1':
    titleTips = '待实勘';
desc = `上门时间：${orderDetail.serviceTimeSlot ?? ''}`;
break;
        case '2':
        case '3':
    titleTips = '审核中';
break;
        case '4':
    titleTips = '已取消';
    if (orderDetail.tip!=null&&orderDetail.tip.length>=3) {
      desc = orderDetail.tip.substring(3);
    } 
    
break;
        case '5':
    titleTips = '已完成';
break;
        case '7':
    titleTips = '已驳回';
    if (orderDetail.tip!=null&&orderDetail.tip.length>=3) {
      desc = orderDetail.tip.substring(3);
    } 
    
break;
    
          default:
      break;
    
    }
    
    }
  ''');
}

bool testcaseForIn() {
  return compare('testcaseForIn', convertFunction('''
  void testcaseForIn() {
    for (var value in widget.cellData) {
      if (value != null && value.errorTitle != null) {
        conditionMatched = true;
        break;
      }
    }
  }
  '''), '''
  function testcaseForIn() { 
          for (let value in widget.cellData) {
          if (value!=null&&value.errorTitle!=null) {
      conditionMatched = true;
break;
    } 
    
    }
    
    }
  ''');
}

bool testcaseSpreadOperator() {
  return compare('testcaseSpreadOperator', convertFunction('''
  void testcaseSpreadOperator() {
    var a = [1,2,3];
    var b = [...a, 4];
  }
  '''), '''
  function testcaseSpreadOperator() { 
            let a = [1,2,3];
    
      let b = [...a,4];
    
    }
  ''');
}

bool testcaseInnerFunction() {
  return compare('testcaseInnerFunction', convertFunction('''
  void testcaseInnerFunction() {
    String parseId2Value(List<IdValueConfig> idValues, String originId) {
      var idx = idValues.indexWhere((String e) => e.id == originId);
      if (idx != -1) {
        return idValues[idx].value;
      } else {
        return originId;
      }
    }

    Future.wait([loadFeedbackDetail(), loadSpaceBaseData()]).then((values) {
      setState(() {
        _feedbackModel.houseType = parseId2Value(
            _optionalConfigModel.houseType, _feedbackModel.houseType);
      });
    }).catchError((e) {
      onNetworkError();
    });
  }
  '''), '''
  function testcaseInnerFunction() { 
      function parseId2Value(idValues,originId) { 
            let idx = idValues.indexWhere((e) => e.id==originId);
    
    if (idx!=-1) {
          return idValues.__op_idx__(idx).value;
    
    }       else {
            return originId;
    
      }
    
    
    }
    Future.wait([loadFeedbackDetail(),loadSpaceBaseData()]).then(function dummy(values) { 
          setState(function dummy() { 
      _feedbackModel.houseType = parseId2Value(_optionalConfigModel.houseType,_feedbackModel.houseType);
    });
    
    }).catchError(function dummy(e) { 
          onNetworkError();
    
    });
    
    }
  ''');
}

bool testcaseIfExpr() {
  return compare('testcaseIfExpr', convertFunction('''
  void testcaseIfExpr() {
    var isTrue = false;
    var arr = [1, if (isTrue) 1];
  }
  '''), '''
  function testcaseIfExpr() { 
            let isTrue = false;
    
      let arr = (function() {
      let __arr__ = [1,(isTrue) ? 1 : "__if_element_placeholder__"];
      return __arr__.filter(elem => elem !== "__if_element_placeholder__");
    })();
    }
  ''');
}

bool testcaseClassDeclareDataBean() {
  return compare('testcaseClassDeclareDataBean', convertClassString(r'''
  class DemoItem extends Object {
    int id;
    String name = '';

    DemoItem({this.id, this.name});

    factory DemoItem.fromJson(Map<String, dynamic> json) => DemoItem(
          id: json['id'] as int,
          name: json['name'] as String,
        );

    Map<String, dynamic> toJson() => <String, dynamic>{
          'id': id,
          'name': name,
        };
  }
  class DemoList extends Object {
    List<DemoItem> list;
    int total;

    DemoList({
      this.list,
      this.total,
    });

    factory DemoList.fromJson(Map<String, dynamic> json) => DemoList(
          list: (json['list'] as List)
              ?.map((e) =>
                  e == null ? null : DemoItem.fromJson(e as Map<String, dynamic>))
              ?.toList(),
          total: json['total'] as int,
        );

    Map<String, dynamic> toJson() => <String, dynamic>{
          'list': list,
          'total': total,
        };
    }
    ''', true), '''
    function DemoItem() {          
                    const inner = DemoItem.__inner__;
          if (this == __global__) {
            return new DemoItem({__args__: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            DemoItem.prototype.ctor.apply(this, args);
            return this;
          }
        
        }
        DemoItem.__inner__ = function inner() {
          Object.__inner__.call(this);
          this.id = null;this.name = '';
        };
        DemoItem.prototype = {
          ctor: function ctor({id,name}={}) { 
            const __thiz__ = this;
      const __arg_ctx__ = {id,name,};
      
      with (__thiz__) {
            with (__arg_ctx__) {
      Object.prototype.ctor.call(__thiz__);
this.id = id;
this.name = name;
    }
    
      }
      
    
    },
                    toJson: function() {
            let res = {};
            res.id = this.id;
res.name = this.name;
            return JSON.stringify(res);
          },
        
        };
        
        
        
                DemoItem.fromJson = function(json) {
            if (typeof json == 'string') {
              json = JSON.parse(json);
            }
            var res = new DemoItem();
            res.id = json.id;
res.name = json.name;
            return res;
          };
        
        inherit(DemoItem, Object);
        
        function DemoList() {          
                    const inner = DemoList.__inner__;
          if (this == __global__) {
            return new DemoList({__args__: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            DemoList.prototype.ctor.apply(this, args);
            return this;
          }
        
        }
        DemoList.__inner__ = function inner() {
          Object.__inner__.call(this);
          this.list = null;this.total = null;
        };
        DemoList.prototype = {
          ctor: function ctor({list,total}={}) { 
            const __thiz__ = this;
      const __arg_ctx__ = {list,total,};
      
      with (__thiz__) {
            with (__arg_ctx__) {
      Object.prototype.ctor.call(__thiz__);
this.list = list;
this.total = total;
    }
    
      }
      
    
    },
                    toJson: function() {
            let res = {};
            res.list = this.list;
res.total = this.total;
            return JSON.stringify(res);
          },
        
        };
        
        
        
                DemoList.fromJson = function(json) {
            if (typeof json == 'string') {
              json = JSON.parse(json);
            }
            var res = new DemoList();
            res.list = json.list;
res.total = json.total;
            return res;
          };
        
        inherit(DemoList, Object);
    ''');
}

bool testcaseClassDeclareFactoryConstructor() {
  UniqueNameGenerator().reset();
  return compare('testcaseClassDeclareFactoryConstructor', convertClassString(r'''
    class E {
      int e;

      E(this.e);

      factory E.ee(int d) => E(d);
      factory E.ee1(String str) => E.ee(int.parse(str));
    }
    '''), '''
    function E() {          
                    const inner = E.__inner__;
          if (this == __global__) {
            return new E({__args__: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            E.prototype.ctor.apply(this, args);
            return this;
          }
        
        }
        E.__inner__ = function inner() {
          
          this.e = null;
        };
        E.prototype = {
          ctor: function ctor(__temp_f_1__) { 
            const __thiz__ = this;
      const __arg_ctx__ = {__temp_f_1__,};
      
            with (__thiz__) {
            with (__arg_ctx__) {
      Object.prototype.ctor.call(__thiz__);
this.e = __temp_f_1__;
    }
    
      }
      
      
    
    },
          
        };
        
        E.ee =       (d) => E(d);
    ;
E.ee1 =       (str) => E.ee(int.parse(str));
    ;
    ''');
}

bool testcaseClassDeclareDelegateConstructor() {
  UniqueNameGenerator().reset();
  return compare('testcaseClassDeclareDelegateConstructor', convertClassString(r'''
    class E {
      int e;

      E(this.e);

      E.ee2(String str) {
        this.e = int.parse(str);
      }
      E.ee3(String str) : this(int.parse(str));
    }
    '''), '''
    function E() {          
                    const inner = E.__inner__;
          if (this == __global__) {
            return new E({__args__: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            E.prototype.ctor.apply(this, args);
            return this;
          }
        
        }
        E.__inner__ = function inner() {
          
          this.e = null;
        };
        E.prototype = {
          ctor: function ctor(__temp_f_1__) { 
            const __thiz__ = this;
      const __arg_ctx__ = {__temp_f_1__,};
      
            with (__thiz__) {
            with (__arg_ctx__) {
      Object.prototype.ctor.call(__thiz__);
this.e = __temp_f_1__;
    }
    
      }
      
      
    
    },
          
        };
        
        E.ee2 = function ctor(str) { 
            const __thiz__ = Object.create(E.prototype);
      const __arg_ctx__ = {str,};
      E.__inner__.call(__thiz__);
            with (__thiz__) {
            with (__arg_ctx__) {
      (function() {Object.prototype.ctor.call(__thiz__);
this.e = int.parse(str);).call(__thiz__);
    }
    
      }
      
      return __thiz__;
    
    };
E.ee3 = function ctor(str) { 
            const __arg_ctx__ = {str,};
          with (__arg_ctx__) {
      return new E(int.parse(str));
    }
    
      
    };
    ''');
}

bool testcaseClassDeclareExtends() {
  UniqueNameGenerator().reset();
  return compare('testcaseClassDeclareExtends', convertClassString(r'''
    class A {
      int a;

      void foo() {
        a = 1;
      }

      String bar() {
        return 'bar';
      }
    }

    class B extends A {
      int b;

      void foo() {
        super.foo();
        a = 2;
        b = 1;
      }
    }
    ''', false), '''
    function A() {          
                    const inner = A.__inner__;
          if (this == __global__) {
            return new A({__args__: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            A.prototype.ctor.apply(this, args);
            return this;
          }
        
        }
        A.__inner__ = function inner() {
          
          this.a = null;
        };
        A.prototype = {
          foo: function foo() { 
            const __thiz__ = this;
      
      
      with (__thiz__) {
        a = 1;
      }
      
    
    },bar: function bar() { 
            const __thiz__ = this;
      
      
      with (__thiz__) {
            return 'bar';
    
      }
      
    
    },
          
        };
                  A.prototype.ctor = function() {
            Object.prototype.ctor.call(this);
          };
        
        
        
        
        
        
        function B() {          
                    const inner = B.__inner__;
          if (this == __global__) {
            return new B({__args__: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            B.prototype.ctor.apply(this, args);
            return this;
          }
        
        }
        B.__inner__ = function inner() {
          A.__inner__.call(this);
          this.b = null;
        };
        B.prototype = {
          foo: function foo() { 
            const __thiz__ = this;
      
      
      with (__thiz__) {
        A.prototype.foo.call(this);
a = 2;
b = 1;
      }
      
    
    },
          
        };
                  B.prototype.ctor = function() {
            A.prototype.ctor.call(this);
          };
        
        
        
        
        inherit(B, A);
    ''');
}

// bool testcaseXx() {
//   return compare('testcaseXx', convertFunction('''
//   void testcaseXx() {
//     print(super.a.b);
//   }
//   '''), '''
  
//   ''');
// }

bool testcaseClassDeclareExtends1() {
  UniqueNameGenerator().reset();
  return compare('testcaseClassDeclareExtends1', convertClassString(r'''
    class A {
      int a;
      int a1;
      int a2;
      int a3;
      int a4;
      int a5;
      int a6;
      int a7;

      A(int a22, this.a, {this.a1 = 1}) {
        this.a2 = a22;
        a3 = 10;
        a4 = 0;
        a5 = 0;
        a6 = 0;
      }

      void foo(int a) {
        this.a = a;
      }

      void bar() {
        print('A.bar $a7');
      }
    }
    class B extends A {
      int b;

      B(this.b) : super(10, 11);

      void foo(int a) {
        super.foo(a);
        print(super.a);
        this.a = 2;
        b = 1;
      }
    }

    class C extends B {
      int c;
      C(int c) : c = c, super(c);
      C.cc(String cc) : this(int.parse(cc));
      
    }

    class D extends C {
      static D _instance;
      int d;
      int d1;

      D._internal(int d) : d = d, super(d) {
        d1 = 10;
      }

      factory D(int d) {
        if (_instance == null) {
          _instance = D._internal(d);
        } else {
          _instance.d = d;
        }
        return _instance;
      }
    }
    ''', false), r'''
    function A() {          
                    const inner = A.__inner__;
          if (this == __global__) {
            return new A({__args__: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            A.prototype.ctor.apply(this, args);
            return this;
          }
        
        }
        A.__inner__ = function inner() {
          
          this.a = null;this.a1 = null;this.a2 = null;this.a3 = null;this.a4 = null;this.a5 = null;this.a6 = null;this.a7 = null;
        };
        A.prototype = {
          ctor: function ctor(a22,__temp_f_1__,{a1=1}={}) { 
            const __thiz__ = this;
      const __arg_ctx__ = {a22,__temp_f_1__,a1,};
      
            with (__thiz__) {
            with (__arg_ctx__) {
      Object.prototype.ctor.call(__thiz__);
this.a = __temp_f_1__;
this.a1 = a1;
this.a2 = a22;
a3 = 10;
a4 = 0;
a5 = 0;
a6 = 0;
    }
    
      }
      
      
    
    },foo: function foo(a) { 
            const __thiz__ = this;
      const __arg_ctx__ = {a,};
      
            with (__thiz__) {
            with (__arg_ctx__) {
      this.a = a;
    }
    
      }
      
      
    
    },bar: function bar() { 
            const __thiz__ = this;
      
      
            with (__thiz__) {
            print(`A.bar ${a7}`);
    
      }
      
      
    
    },
          
        };
        
        
        
        
        
        
        function B() {          
                    const inner = B.__inner__;
          if (this == __global__) {
            return new B({__args__: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            B.prototype.ctor.apply(this, args);
            return this;
          }
        
        }
        B.__inner__ = function inner() {
          A.__inner__.call(this);
          this.b = null;
        };
        B.prototype = {
          ctor: function ctor(__temp_f_2__) { 
            const __thiz__ = this;
      const __arg_ctx__ = {__temp_f_2__,};
      
            with (__thiz__) {
            with (__arg_ctx__) {
      this.b = __temp_f_2__;
A.prototype.ctor.call(__thiz__,10,11);
    }
    
      }
      
      
    
    },foo: function foo(a) { 
            const __thiz__ = this;
      const __arg_ctx__ = {a,};
      
            with (__thiz__) {
            with (__arg_ctx__) {
      A.prototype.foo.call(this,a);
    print(this.a);
    
this.a = 2;
b = 1;
    }
    
      }
      
      
    
    },
          
        };
        
        
        
        
        inherit(B, A);
        
        function C() {          
                    const inner = C.__inner__;
          if (this == __global__) {
            return new C({__args__: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            C.prototype.ctor.apply(this, args);
            return this;
          }
        
        }
        C.__inner__ = function inner() {
          B.__inner__.call(this);
          this.c = null;
        };
        C.prototype = {
          ctor: function ctor(c) { 
            const __thiz__ = this;
      const __arg_ctx__ = {c,};
      
            with (__thiz__) {
            with (__arg_ctx__) {
      this.c = c;
B.prototype.ctor.call(__thiz__,c);
    }
    
      }
      
      
    
    },
          
        };
        
        C.cc = function ctor(cc) { 
            const __arg_ctx__ = {cc,};
          with (__arg_ctx__) {
      return new C(int.parse(cc));
    }
    
      
    };
        
        
        inherit(C, B);
        
        function D() {          
                    return D.__fty__ctor__.apply(D, arguments);
        
        }
        D.__inner__ = function inner() {
          C.__inner__.call(this);
          this.d = null;this.d1 = null;
        };
        D.prototype = {
          
          
        };
                  D.prototype.ctor = function() {
            C.prototype.ctor.call(this);
          };
        
        D._internal = function ctor(d) { 
            const __thiz__ = Object.create(D.prototype);
      const __arg_ctx__ = {d,};
      D.__inner__.call(__thiz__);
            with (__thiz__) {
            with (__arg_ctx__) {
      (function() {this.d = d;
C.prototype.ctor.call(__thiz__,d);
d1 = 10;).call(__thiz__);
    }
    
      }
      
      return __thiz__;
    
    };
D.__fty__ctor__ = function ctor(d) { 
            const __thiz__ = this;
      const __arg_ctx__ = {d,};
      
            with (__thiz__) {
            with (__arg_ctx__) {
          if (_instance==null) {
      _instance = D._internal(d);
    }       else {
        _instance.d = d;
      }
    
    
    return _instance;
    
    }
    
      }
      
      
    
    };
        D._instance = (function() { with (D) { return null; } })();
        
        inherit(D, C);
    ''');
}

bool testcaseStatic() {
  return compare('testcaseStatic', convertClassString(r'''
  class F {
    static int f = 1;
    int ff;

    static void foo() {
      print('f: $f');
    }

    static void add() {
      f++;
    }
    static void add1() async {
      f+=2;
    }
  }
  '''), r'''
  function F() {          
                    const inner = F.__inner__;
          if (this == __global__) {
            return new F({__args__: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            F.prototype.ctor.apply(this, args);
            return this;
          }
        
        }
        F.__inner__ = function inner() {
          
          this.ff = null;
        };
        F.prototype = {
          
          
        };
                  F.prototype.ctor = function() {
            Object.prototype.ctor.call(this);
          };
        
        F.foo = function foo() { 
            const __thiz__ = this;
      
      
      with (__thiz__) {
            print(`f: ${f}`);
    
      }
      
    
    };
F.add = function add() { 
            const __thiz__ = this;
      
      
      with (__thiz__) {
        f++;
      }
      
    
    };
F.add1 = async function add1() { 
            const __thiz__ = this;
      
      
      with (__thiz__) {
        f += 2;
      }
      
    
    };
        F.f = (function() { with (F) { return 1; } })();
  ''');
}

bool testcaseStatic1() {
  return compare('testcaseStatic1', convertClassString(r'''
  class F {
    static int f = 1;
    static int f1 = f + bar();

    static int bar() {
      return 1;
    }
  }
  '''), r'''
  function F() {          
                    const inner = F.__inner__;
          if (this == __global__) {
            return new F({__args__: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            F.prototype.ctor.apply(this, args);
            return this;
          }
        
        }
        F.__inner__ = function inner() {
          
          
        };
        F.prototype = {
          
          
        };
                  F.prototype.ctor = function() {
            Object.prototype.ctor.call(this);
          };
        
        F.bar = function bar() { 
            const __thiz__ = this;
      
      
      with (__thiz__) {
            return 1;
    
      }
      
    
    };
        F.f = (function() { with (F) { return 1; } })();
F.f1 = (function() { with (F) { return f+bar(); } })();
  ''');
}

bool testcaseStatic2() {
  return compare('testcaseStatic2', convertClassString(r'''
  class G6 {
    static int g6 = 0;
    int g61;

    int foo() {
      void bar() {
        g6 = 10;
        g61 = 11;
      }
      var xx = (int y) => g6 + y;

      bar();
      return g61 + g6 + xx(20);
    }
  }
  '''), r'''
  function G6() {          
                    const inner = G6.__inner__;
          if (this == __global__) {
            return new G6({__args__: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            G6.prototype.ctor.apply(this, args);
            return this;
          }
        
        }
        G6.__inner__ = function inner() {
          
          this.g61 = null;
        };
        G6.prototype = {
          foo: function foo() { 
            const __thiz__ = this;
      
      
          with(G6) {
            with (__thiz__) {
        function bar() { 
      g6 = 10;
g61 = 11;
    }
      let xx =       (y) => g6+y;
    ;
    
    bar();
    
    return g61+g6+xx(20);
    
      }
      
    }
    
      
    
    },
          
        };
                  G6.prototype.ctor = function() {
            Object.prototype.ctor.call(this);
          };
        
        
        G6.g6 = (function() { with (G6) { return 0; } })();
  ''');
}

bool testcaseMap() {
  return compare('testcaseMap', convertFunction(r'''
  void testcaseMap() {
    String foo({String str}) {return 'foo${str}';}
    var d = 'd';
    var obj = {
      foo(str: 'bar'): {
        'b': {
          foo(str: 'bar1'): {foo(str: 'bar2'),},
          d: 1
        }
      }
    };
    // var obj1 = {'1'};
    obj['foobar']['b'].addAll({
      'd': {'2'}
    });
    obj['foobar']['b']['c'] = {'3'};
    print(obj.keys);
    print(obj.values);
    print(obj.entries);
    print(obj.length);
    print(obj['a']);
  }
  '''), r'''
   function testcaseMap() { 
      function foo({str}={}) { 
          return `foo${str}`;
    
    }
      let d = 'd';
    
      let obj = convertObjectLiteralToSetOrMap({[foo({str:'bar'})]:  convertObjectLiteralToSetOrMap({['b']:  convertObjectLiteralToSetOrMap({[foo({str:'bar1'})]:  convertObjectLiteralToSetOrMap([foo({str:'bar2'}),]),[d]: 1,}),}),});
    
    obj.__op_idx__('foobar').__op_idx__('b').addAll( convertObjectLiteralToSetOrMap({['d']:  convertObjectLiteralToSetOrMap(['2',]),}));
    
obj.__op_idx__('foobar').__op_idx__('b').__op_idxeq__('c',  convertObjectLiteralToSetOrMap(['3',]));
    print(obj.keys);
    
    print(obj.values);
    
    print(obj.entries);
    
    print(obj.length);
    
    print(obj.__op_idx__('a'));
    
    }
  ''');
}

bool testcaseMap1() {
  return compare('testcaseMap1', convertFunction(r'''
  void testcaseMap1() {
      var obj = Map.from({
        'a': 1
      });
      print(obj.keys);
      print(obj.values);
      print(obj.entries);
      print(obj.length);
      print(obj['a']);
  }
  '''), r'''
   function testcaseMap1() { 
            let obj = Map.from( convertObjectLiteralToSetOrMap({['a']: 1,}));
    
    print(obj.keys);
    
    print(obj.values);
    
    print(obj.entries);
    
    print(obj.length);
    
    print(obj.__op_idx__('a'));
    
    }
  ''');
}

bool testcaseList() {
  return compare('testcaseList', convertFunction(r'''
  void testcaseList() {
    var obj = [];
    print(obj.length);
    obj.add('aa');
    print(obj.single);
    obj.addAll(['bb', 'cc', 'dd', 'cc', 'dd']);
    print(obj);
    obj.fillRange(0, 2, 'xx');
    print(obj);
    print(obj.getRange(0, 2));
    print(obj.indexOf('cc', 2));
    print(obj.indexWhere((element) => element == 'dd', 3));
    obj.insert(0, 'ee');
    obj.insertAll(1, ['ff', 'gg', 'hh']);
    print(obj);
    print(obj[2]);
    print(obj.lastIndexOf('dd', obj.length - 2));
    print(obj.lastIndexWhere((element) => element == 'dd'));
    obj.remove('dd');
    print(obj);
    obj.removeAt(2);
    print(obj);
    obj.setRange(0, 2, ['1', '2', '3', '4']);
    print(obj);
    obj.clear();
    print(obj);
  }
  '''), r'''
   function testcaseList() { 
            let obj = [];
    
    print(obj.length);
    
    obj.add('aa');
    
    print(obj.single);
    
    obj.addAll(['bb','cc','dd','cc','dd']);
    
    print(obj);
    
    obj.fillRange(0,2,'xx');
    
    print(obj);
    
    print(obj.getRange(0,2));
    
    print(obj.indexOf('cc',2));
    
    print(obj.indexWhere((element) => element=='dd',3));
    
    obj.insert(0,'ee');
    
    obj.insertAll(1,['ff','gg','hh']);
    
    print(obj);
    
    print(obj.__op_idx__(2));
    
    print(obj.lastIndexOf('dd',obj.length-2));
    
    print(obj.lastIndexWhere((element) => element=='dd'));
    
    obj.remove('dd');
    
    print(obj);
    
    obj.removeAt(2);
    
    print(obj);
    
    obj.setRange(0,2,['1','2','3','4']);
    
    print(obj);
    
    obj.clear();
    
    print(obj);
    
    }
  ''');
}

bool testcaseUseDefaultConstructor() {
  return compare('testcaseUseDefaultConstructor', convertClassString(r'''
  class G1 {
    int g1;

    G1() {
      g1 = 10;
    }
  }

  class G2 extends G1 {
    int g2;

    G2() {
      g2 = g1;
    }
  }

  class G3 extends G2 {
    int g3;

    G3(int xx) : g3 = xx;
  }
  '''), '''
  function G1() {          
                    const inner = G1.__inner__;
          if (this == __global__) {
            return new G1({__args__: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            G1.prototype.ctor.apply(this, args);
            return this;
          }
        
        }
        G1.__inner__ = function inner() {
          
          this.g1 = null;
        };
        G1.prototype = {
          ctor: function ctor() { 
            const __thiz__ = this;
      
      
      with (__thiz__) {
        Object.prototype.ctor.call(__thiz__);
g1 = 10;
      }
      
    
    },
          
        };
        
        
        
        
        
        
        function G2() {          
                    const inner = G2.__inner__;
          if (this == __global__) {
            return new G2({__args__: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            G2.prototype.ctor.apply(this, args);
            return this;
          }
        
        }
        G2.__inner__ = function inner() {
          G1.__inner__.call(this);
          this.g2 = null;
        };
        G2.prototype = {
          ctor: function ctor() { 
            const __thiz__ = this;
      
      
      with (__thiz__) {
        G1.prototype.ctor.call(__thiz__);
g2 = g1;
      }
      
    
    },
          
        };
        
        
        
        
        inherit(G2, G1);
        
        function G3() {          
                    const inner = G3.__inner__;
          if (this == __global__) {
            return new G3({__args__: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            G3.prototype.ctor.apply(this, args);
            return this;
          }
        
        }
        G3.__inner__ = function inner() {
          G2.__inner__.call(this);
          this.g3 = null;
        };
        G3.prototype = {
          ctor: function ctor(xx) { 
            const __thiz__ = this;
      const __arg_ctx__ = {xx,};
      
      with (__thiz__) {
            with (__arg_ctx__) {
      G2.prototype.ctor.call(__thiz__);
this.g3 = xx;
    }
    
      }
      
    
    },
          
        };
        
        
        
        
        inherit(G3, G2);
  ''');
}

bool testcaseImport() {
  return compare('testcaseImport', convertWidgetStateFile(dirname(Platform.script.path) + '/__test_data__/page1/page1.dart'), '''
  GLOBAL['#FairPageName#'] = (function(__initProps__) {
      const __global__ = this;
                defineModule(5, function(__mod__) {
            with (__mod__.imports) {
                      function Two() {          
                    const inner = Two.__inner__;
          if (this == __global__) {
            return new Two({__args__: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            Two.prototype.ctor.apply(this, args);
            return this;
          }
        
        }
        Two.__inner__ = function inner() {
          
          
        };
        Two.prototype = {
          
          
        };
                  Two.prototype.ctor = function() {
            Object.prototype.ctor.call(this);
          };
        
        Two.bar = function bar(value) { 
            const __thiz__ = this;
      const __arg_ctx__ = {value,};
      
            with (__thiz__) {
            with (__arg_ctx__) {
          print(value);
    
    }
    
      }
      
      
    
    };
        
        
        
        
            }
            __mod__.exports.Two = Two;
          }, []);
          
          defineModule(3, function(__mod__) {
            with (__mod__.imports) {
                      function Three() {          
                    const inner = Three.__inner__;
          if (this == __global__) {
            return new Three({__args__: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            Three.prototype.ctor.apply(this, args);
            return this;
          }
        
        }
        Three.__inner__ = function inner() {
          
          
        };
        Three.prototype = {
          
          
        };
                  Three.prototype.ctor = function() {
            Object.prototype.ctor.call(this);
          };
        
        Three.bark = function bark(value) { 
            const __thiz__ = this;
      const __arg_ctx__ = {value,};
      
            with (__thiz__) {
            with (__arg_ctx__) {
          print(value);
    
    b.Two.bar(value);
    
    }
    
      }
      
      
    
    };
        
        
        
        
            }
            __mod__.exports.Three = Three;
          }, [[5,'b']]);
          
          defineModule(2, function(__mod__) {
            with (__mod__.imports) {
                      function One() {          
                    const inner = One.__inner__;
          if (this == __global__) {
            return new One({__args__: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            One.prototype.ctor.apply(this, args);
            return this;
          }
        
        }
        One.__inner__ = function inner() {
          
          
        };
        One.prototype = {
          
          
        };
                  One.prototype.ctor = function() {
            Object.prototype.ctor.call(this);
          };
        
        One.foo = function foo(value) { 
            const __thiz__ = this;
      const __arg_ctx__ = {value,};
      
            with (__thiz__) {
            with (__arg_ctx__) {
          c.Two.bar(value);
    
    Three.bark(value);
    
    }
    
      }
      
      
    
    };
        
        
        
        
            }
            __mod__.exports.One = One;
          }, [3,[5,'c']]);
          
          defineModule(1, function(__mod__) {
            with (__mod__.imports) {
                      function CustomFunc() {          
                    const inner = CustomFunc.__inner__;
          if (this == __global__) {
            return new CustomFunc({__args__: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            CustomFunc.prototype.ctor.apply(this, args);
            return this;
          }
        
        }
        CustomFunc.__inner__ = function inner() {
          
          
        };
        CustomFunc.prototype = {
          
          
        };
                  CustomFunc.prototype.ctor = function() {
            Object.prototype.ctor.call(this);
          };
        
        CustomFunc.excute = function excute(value) { 
            const __thiz__ = this;
      const __arg_ctx__ = {value,};
      
            with (__thiz__) {
            with (__arg_ctx__) {
          One.foo(value);
    
    }
    
      }
      
      
    
    };
        
        
        
        
            }
            __mod__.exports.CustomFunc = CustomFunc;
          }, [2]);
          
      return runCallback(function(__mod__) {
        with(__mod__.imports) {
                  function _Page2PageState() {          
                    const inner = _Page2PageState.__inner__;
          if (this == __global__) {
            return new _Page2PageState({__args__: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            _Page2PageState.prototype.ctor.apply(this, args);
            return this;
          }
        
        }
        _Page2PageState.__inner__ = function inner() {
          
          this.fairProps = __initProps__;this._count = null;this._name = null;
        };
        _Page2PageState.prototype = {
          onTapText: function onTapText() { 
            const __thiz__ = this;
      
      
            with (__thiz__) {
        _count = _count+1;
    setState('#FairKey#',function dummy() { 
      
    });
    
      }
      
      
    
    },onLoad: function onLoad() { 
            const __thiz__ = this;
      
      
            with (__thiz__) {
        _name = fairProps.__op_idx__('pageName');
_count = fairProps.__op_idx__('_count');
      }
      
      
    
    },initState: function initState() { 
            const __thiz__ = this;
      
      
            with (__thiz__) {
        
fairProps = widget._props;
    onLoad();
    
      }
      
      
    
    },onCustomFunc: function onCustomFunc() { 
            const __thiz__ = this;
      
      
            with (__thiz__) {
            a.CustomFunc.excute(_count.toString());
    
      }
      
      
    
    },
          
        };
                  _Page2PageState.prototype.ctor = function() {
            Object.prototype.ctor.call(this);
          };
        
        
        
        
        
        ;
          return _Page2PageState();
        }
      }, [[1,'a']]);
    })(convertObjectLiteralToSetOrMap(JSON.parse('#FairProps#')));
  ''');
}

void main() {

  print('Executing testcases...');
  var arr = [
    testcaseFor1,
    testcaseFor2,
    testcaseFor3,
    testcaseChainFor1,
    testcaseChainFor2,
    testcaseIf,
    testcaseIf1,
    testcaseIf2,
    testcaseIf3,
    testcaseWhile,
    testcaseDoWhile,
    testcaseChainWhile,
    testcaseAsync,
    testcaseArrowFunc1,
    testcaseArrowFunc2,
    testcaseTemplateString,
    testcaseTemplateString1,
    testcaseAnonymousFunc,
    testcaseAnonymousFunc1,
    testcaseAwaitOnField,
    testcaseNamedParameters1,
    testcaseNamedParameters2,
    testcaseFunctionExpression,
    testcaseSimpleExpression,
    testcaseMapLiteral,
    testcaseFunctionWithParameter,
    testcaseFunctionWithNamedParameter,
    testcaseFunctionWithNamedParameter1,
    testcaseFunctionWithOptionalParameter,
    testcaseFunctionWithOptionalParameter1,
    testcaseDotdotOperator,
    testcaseDotdotOperator1,
    testcaseExpr1,
    testcaseExpr2,
    testcaseExpr3,
    testcaseExpr4,
    testcaseExpr5,
    testcaseContinue,
    testcaseCascadeFieldAccessAssign,
    testcaseDeclare,
    testcaseDeclare1,
    testcaseMethodInvoke,
    testcaseNew,
    testcaseDeclareList,
    testcaseSuper,
    testcaseSwitch,
    testcaseSwitch1,
    testcaseForIn,
    testcaseSpreadOperator,
    testcaseInnerFunction,
    testcaseIfExpr,
    testcaseClassDeclareDataBean,
    testcaseClassDeclareExtends,
    testcaseClassDeclareExtends1,
    testcaseClassDeclareFactoryConstructor,
    testcaseClassDeclareDelegateConstructor,
    testcaseStatic,
    testcaseStatic1,
    testcaseStatic2,
    testcaseUseDefaultConstructor,
    testcaseMap,
    testcaseMap1,
    testcaseList,
    testcaseImport,
  ];
  var failedCount = 0;
  arr.forEach((func) {
    if (!func.call()) {
      failedCount++;
    }
  });
  if (failedCount > 0) {
    print('''Testcase total ${arr.length}, failed $failedCount''');
  } else {
    print('''Testcase total ${arr.length} successful''');
  }
}