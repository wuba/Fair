//用户自定义拓展，需要在fair_basic_config.json中注册
//会在基础js加载之后加载

let callBack = {};

let FairNet = {
    mFairNetId: 0,
    request: function (params) {
        let id = 'FairNet$' + this.mFairNetId++;
        let requestParameter = {};
        params['id'] = id;
        params['className'] = "FairNet#request";
        callBack[id] = [params['complete'], params['error']];
        requestParameter['funcName'] = 'invokePlugin';
        requestParameter['pageName'] = ['pageName'];
        requestParameter['args'] = params;
        let map = JSON.stringify(requestParameter);

        invokeFlutterCommonChannel(map, (resultStr) => {
            console.log("resultStr" + resultStr)
            let responseMap = JSON.parse(resultStr);
            let code = responseMap['statusCode']
            let data = responseMap['data']
            let id = responseMap['id']

            //这两个函数用户拓展的
            if (callBack[id] === null) {
                return;
            }

            let complete = callBack[id][0];
            let error = callBack[id][1];
            let statusMessage = responseMap['statusMessage']

            if (code === 200) {
                if (complete) {
                    complete(data);
                }
            } else {
                if (error) {
                    error(statusMessage);
                }
            }

        })
    }
}
