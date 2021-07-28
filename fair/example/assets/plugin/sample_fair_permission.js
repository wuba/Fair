var WBPermissionCallback = {};
var WBPermissionId = 1;
let WBPermission = function () {
    return {
        getPhoto: function (req) {
            //准备需要发送的消息
            let selectorId = 'WBPermissionId' + WBPermissionId++;
            let reqFunc = {};
            Object.keys(req).forEach(function (key) {
                if (typeof key === "function") {
                    reqFunc[key] = reqFunc;
                }
                WBPermissionCallback[selectorId] = reqFunc;
            });


            let reqMap = {
                pageName: req['pageName'],
                funcName: 'invokePlugin',
                args: {
                    callId: selectorId,
                }
            };

            invokeFlutterCommonChannel(JSON.stringify(reqMap), function (resp) {
                //处理dart端返回的请求结果
                let respMap = JSON.parse(resp);
                let respArgs = respMap['args'];
                let respCallId = respArgs['callId'];
                let isGranted = respArgs['Granted'];

                //用户自行处理需要返回的结果值
                let callback = WBPermissionCallback[respCallId];
                if (callback == null) {
                    return
                }
                let GrantedCallback = respArgs['Granted'];
                let RestrictedCallback = respArgs['Restricted'];
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