let WBPermissionCallback = {};
let WBPermissionId = 1;
let WBPermission = function () {
    return {
        requestPermission: function (req) {
            console.log('WBPermission#requestPermission'+req);
            //准备需要发送的消息
            let selectorId = 'WBPermissionId' + WBPermissionId++;
            let reqFunc = {};
            let args=req.get('args');
            for (let [k, v] of args) {
                if (typeof v === "function") {
                    console.log('key'+k);
                    reqFunc[k] = v;
                }
                WBPermissionCallback[selectorId] = reqFunc;
            }


            let reqMap = {
                pageName: req.get('pageName'),
                funcName: 'invokePlugin',
                'className':'WBPermission#requestPermission',
                args: {
                    callId: selectorId,
                }
            };

            invokeFlutterCommonChannel(JSON.stringify(reqMap), function (resp) {
                //处理dart端返回的请求结果
                let respMap = JSON.parse(resp);
                let respArgs = respMap['args'];
                let respCallId = respArgs['callId'];
                let isGranted = respArgs['isGranted'];

                //用户自行处理需要返回的结果值
                let callback = WBPermissionCallback[respCallId];
                if (callback == null) {
                    return
                }
                let GrantedCallback = callback['Granted'];
                let RestrictedCallback = callback['Restricted'];
                if (isGranted && GrantedCallback != null) {
                    GrantedCallback(true);
                } else {
                    if (RestrictedCallback != null) {
                        RestrictedCallback(false);
                    }
                }
                //消费完之后及时移除回调
                WBPermissionCallback[respCallId] = null;
            });
        },

    };
};