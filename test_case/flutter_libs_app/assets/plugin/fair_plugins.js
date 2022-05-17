//用户自定义拓展，需要在fair_basic_config.json中注册
//会在基础js加载之后加载

let FairPlugin = {
    mFairPluginId: 0,
    call: function (params) {
        let id = 'FairPlugin' + this.mFairPluginId++;
        let requestParameter = {};
        params['id'] = id;
        callBack[id] = [params['complete'], params['error']];
        requestParameter['funcName'] = 'invokePlugin';
        requestParameter['pageName'] = ['pageName'];
        requestParameter['args'] = params;
        let map = JSON.stringify(requestParameter);

        invokeFlutterCommonChannel(map, (resultStr) => {
            console.log("resultStr" + resultStr)
            let responseMap = JSON.parse(resultStr);
            let data = responseMap['data']
            let id = responseMap['id']
            //这两个函数用户拓展的
            if (callBack[id] === null) {
                return;
            }
            let complete = callBack[id][0];
            complete(data);
        });
    }
}
