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

class Toast {
    static LENGTH_SHORT = "LENGTH_SHORT";
    static LENGTH_LONG = "LENGTH_LONG";
}

class ToastGravity {
    static TOP = "TOP";
    static BOTTOM = "BOTTOM";
    static CENTER = "CENTER";
    static TOP_LEFT = "TOP_LEFT";
    static TOP_RIGHT = "TOP_RIGHT";
    static BOTTOM_LEFT = "BOTTOM_LEFT";
    static BOTTOM_RIGHT = "BOTTOM_RIGHT";
    static CENTER_LEFT = "CENTER_LEFT";
    static CENTER_RIGHT = "CENTER_RIGHT";
    static SNACKBAR = "SNACKBAR";
    static NONE = "NONE";
}

function Color(color){
    return color;
}