//用户自定义拓展，需要在fair_basic_config.json中注册
//会在基础js加载之后加载
let callBack = {};
let callBackId = 0;

let FairNet = function () {
    return {
        requestData: function (resp) {
            let respMap = {};
            respMap = mapOrSetToObject(resp);
            let id = 'FairNet$' + (++callBackId);
            let requestParameter = {};
            requestParameter['className'] = "FairNet#requestData";
            callBack[id] = [respMap['complete'], respMap['error'], respMap['success']];
            respMap['callId'] = id;
            requestParameter['funcName'] = 'invokePlugin';
            requestParameter['pageName'] = respMap['pageName'];
            requestParameter['args'] = respMap;
            let map = JSON.stringify(requestParameter);
            console.log('FairNet请求参数：' + map);
            invokeFlutterCommonChannel(map, (resultStr) => {
                console.log('FairNet请求结果：' + resultStr);
                let responseMap = JSON.parse(resultStr);
                console.log('FairNet请求结果1：' + responseMap);
                let data = responseMap['data']
                responseMap['data'] = data.data;
                let id = responseMap['callId']
                console.log('FairNet请求结果2：' + id);
                //这两个函数用户拓展的
                if (callBack[id] === null) {
                    return;
                }
                let complete = callBack[id][0];
                let error = callBack[id][1];
                let success = callBack[id][2];
                console.log('FairNet请求结果3：' + responseMap['statusCode']);
                if (responseMap['statusCode'] === 200) {
                    if (success != null) {
                        console.log('FairNet请求结果4：' + success);
                        success(convertObjectLiteralToSetOrMap(responseMap));
                    }
                    if (complete != null) {
                        complete(convertObjectLiteralToSetOrMap(responseMap));
                    }
                } else {
                    if (error != null) {
                        error(statusMessage);
                    }
                }
            })
        }
    }
}

