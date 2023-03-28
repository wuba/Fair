//用户自定义拓展，需要在fair_basic_config.json中注册
//会在基础js加载之后加载
let _callBack = {};
let _callBackId = 0;
let fairCommonPluginRequest = function (resp, methodName) {
    let respMap = {};
    respMap = mapOrSetToObject(resp);
    let id = 'FairCommonPlugin$' + (++_callBackId);
    let requestParameter = {};
    // 类名 + 方法名
    requestParameter['className'] = "FairCommonPlugin#" + methodName;
    _callBack[id] = respMap['callback'];
    respMap['callId'] = id;
    // 代码里面有判断 funcName 必填
    requestParameter['funcName'] = 'invokePlugin';
    requestParameter['pageName'] = respMap['pageName'];
    requestParameter['request'] = respMap;
    let map = JSON.stringify(requestParameter);
    console.log('FairCommonPlugin请求参数：' + map);
    invokeFlutterCommonChannel(map, (resultStr) => {
        console.log('FairCommonPlugin请求结果：' + resultStr);
        let responseMap = JSON.parse(resultStr);
        console.log('FairCommonPlugin请求结果1：' + responseMap);
        let id = responseMap['callId']
        let data = responseMap['response'];
        console.log('FairCommonPlugin请求结果2：' + id);
        // 这两个函数用户拓展的
        if (_callBack[id] === null) {
            return;
        }
        let complete = _callBack[id];
        console.log('FairCommonPlugin请求结果3：' + data);
        // 返回的是 map
        if (data === null) {
            complete(null);
        }
        else {
            complete(convertObjectLiteralToSetOrMap(data));
        }
        _callBack[id] = null
    })
}