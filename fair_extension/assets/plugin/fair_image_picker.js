let FairImagePickerCallback = {};
let FairImagePickerId = 1;
class FairImagePicker {

    static photo = 'photo';
    static album = 'album';

    static getImage(req) {
         let selectorId = 'FairImagePickerId' + FairImagePickerId++;
         // 设置回调
         let reqFunc = {};
         if (req.success) {
             reqFunc['success'] = req.success;
         }
         if (req.failure) {
             reqFunc['failure'] = req.failure;
         }
         FairImagePickerCallback[selectorId] = reqFunc;
         let typeP = '';
         if (req.type) {
              typeP = req.type;
         }
         let reqMap = {
             pageName: '#FairKey#',
             funcName: 'invokePlugin',
             'className':'FairImagePicker#getImage',
             args: {
                 callId: selectorId,
                 type: typeP,
             }
         };
         invokeFlutterCommonChannel(JSON.stringify(reqMap), function (resp) {
             //处理dart端返回的请求结果
             let respMap = JSON.parse(resp);
             let respArgs = respMap['args'];
             let respCallId = respArgs['callId'];
             let imagePath = respArgs['imagePath'];
             //处理需要返回的结果值
             let callback = FairImagePickerCallback[respCallId];
             if (callback == null) {
                 return
             }
             let successCallback = callback['success'];
             let failureCallback = callback['failure'];
             if (imagePath != null && successCallback != null) {
                 successCallback(imagePath);
             } else {
                 if (failureCallback != null) {
                     failureCallback('');
                 }
             }
             //移除回调
             FairImagePickerCallback[respCallId] = null;
         });
    }
}