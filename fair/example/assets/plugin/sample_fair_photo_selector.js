let FairPhotoSelectorCallback = {};
let FairPhotoSelectorId = 1;
let FairPhotoSelector = function () {
    return {
        getPhoto: function (req) {
            //准备需要发送的消息
            let selectorId = 'FairPhotoSelectorId' + FairPhotoSelectorId++;
            let reqFunc = {};
            let args=req.get('args');
            for (let [k, v] of args) {
                if (typeof v === "function") {
                    console.log('key'+k);
                    reqFunc[k] = v;
                }
                FairPhotoSelectorCallback[selectorId] = reqFunc;
            }
            let reqMap = {
                pageName: req.get('pageName'),
                funcName: 'invokePlugin',
                'className':'FairPhotoSelector#getPhoto',
                args: {
                    callId: selectorId,
                    type: args.get('type'),
                }
            };

            invokeFlutterCommonChannel(JSON.stringify(reqMap), function (resp) {
                //处理dart端返回的请求结果
                let respMap = JSON.parse(resp);
                let respArgs = respMap['args'];
                let respCallId = respArgs['callId'];
                let photoPath = respArgs['photoPath'];
                console.log('photoPath'+respCallId);
                //用户自行处理需要返回的结果值
                let callback = FairPhotoSelectorCallback[respCallId];
                if (callback == null) {
                    return
                }
                console.log('callback'+callback['success']);
                let successCallback = callback['success'];
                let failureCallback = callback['failure'];
                if (photoPath != null && successCallback != null) {
                    console.log('successCallback'+successCallback);
                    successCallback(photoPath);
                } else {
                    console.log('failureCallback'+failureCallback);
                    if (failureCallback != null) {
                        failureCallback('');
                    }
                }
                //消费完之后及时移除回调
                FairPhotoSelectorCallback[respCallId] = null;
            });
        },

    };
};