let FairPermissionCallback = {};
let FairPermissionId = 1;
const FairPermission = {
    permissionPhoto: "Permission_Photo",
    permissionPhone: "Permission_Phone",
    permissionAudio: "permissionAudio",
    requestPermission: function (req) {
        let selectorId = 'FairPermissionId' + FairPermissionId++;
        // 设置回调
        let reqFunc = {};
        if (req.granted) {
            reqFunc['granted'] = req.granted;
        }
        if (req.restricted) {
            reqFunc['restricted'] = req.restricted;
        }
        FairPermissionCallback[selectorId] = reqFunc;
        let typeP = '';
        if (req.type) {
            typeP = req.type;
        }
        let reqMap = {
            pageName: '#FairKey#',
            funcName: 'invokePlugin',
            'className': 'FairPermission#requestPermission',
            args: {
                callId: selectorId,
                type: typeP
            }
        };
        invokeFlutterCommonChannel(JSON.stringify(reqMap), function (resp) {
            //处理dart端返回的请求结果
            let respMap = JSON.parse(resp);
            let respArgs = respMap['args'];
            let respCallId = respArgs['callId'];
            let isGranted = respArgs['isGranted'];
            //处理需要返回的结果值
            let callback = FairPermissionCallback[respCallId];
            if (callback == null) {
                return
            }
            let grantedCallback = callback['granted'];
            let restrictedCallback = callback['restricted'];
            if (isGranted && grantedCallback != null) {
                grantedCallback();
            } else {
                if (restrictedCallback != null) {
                    restrictedCallback();
                }
            }
            //移除回调
            FairPermissionCallback[respCallId] = null;
        });
    }
}