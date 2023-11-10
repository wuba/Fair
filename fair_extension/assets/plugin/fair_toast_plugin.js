class FairToast {

    static show(obj) {
        let paramsMap = {};
        if (obj.msg) {
            paramsMap['msg'] = obj.msg;
        }
        if (obj.toastLength) {
            paramsMap['toastLength'] = obj.toastLength;
        }
        if (obj.fontSize) {
            paramsMap['fontSize'] = obj.fontSize;
        }
        if (obj.gravity) {
            paramsMap['gravity'] = obj.gravity;
        }
        if (obj.backgroundColor) {
            paramsMap['backgroundColor'] = obj.backgroundColor;
        }
        if (obj.textColor) {
            paramsMap['textColor'] = obj.textColor;
        }
        let requestParameter = {};
        requestParameter['className'] = "FairToast#show";
        requestParameter['funcName'] = 'invokePlugin';
        requestParameter['args'] = paramsMap;
        requestParameter['pageName'] = '#FairKey#';
        let map = JSON.stringify(requestParameter);
        invokeFlutterCommonChannel(map, (resultStr) => {
        })
    }

}

const Toast = {
    LENGTH_SHORT: "LENGTH_SHORT",
    LENGTH_LONG: "LENGTH_LONG",
};

const ToastGravity = {
    TOP: "TOP",
    BOTTOM: "BOTTOM",
    CENTER: "CENTER",
    TOP_LEFT: "TOP_LEFT",
    TOP_RIGHT: "TOP_RIGHT",
    BOTTOM_LEFT: "BOTTOM_LEFT",
    BOTTOM_RIGHT: "BOTTOM_RIGHT",
    CENTER_LEFT: "CENTER_LEFT",
    CENTER_RIGHT: "CENTER_RIGHT",
    SNACKBAR: "SNACKBAR",
    NONE: "NONE",
};

function Color(color){
    return color;
}