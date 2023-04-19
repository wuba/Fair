class FairNavigator {

    static pushNamed(obj) {
        let paramsMap = {};
        if (obj.routeName) {
            paramsMap['routeName'] = obj.routeName;
        }
        if (obj.arguments) {
            paramsMap['arguments'] = mapOrSetToObject(obj.arguments);
        }
        let requestParameter = {};
        requestParameter['className'] = "FairNavigator#pushNamed";
        requestParameter['funcName'] = 'invokePlugin';
        requestParameter['args'] = paramsMap;
        requestParameter['pageName'] = '#FairKey#';
        let map = JSON.stringify(requestParameter);
        invokeFlutterCommonChannel(map, (resultStr) => {
        })
    }

    static pushFairPath(obj) {
        let paramsMap = {};
        if (obj.fairPath) {
            paramsMap['fairPath'] = obj.fairPath;
        }
        if (obj.fairName) {
            paramsMap['fairName'] = obj.fairName;
        }
        if (obj.arguments) {
            paramsMap['arguments'] = mapOrSetToObject(obj.arguments);
        }
        let requestParameter = {};
        requestParameter['className'] = "FairNavigator#pushFairPath";
        requestParameter['funcName'] = 'invokePlugin';
        requestParameter['args'] = paramsMap;
        requestParameter['pageName'] = '#FairKey#';
        let map = JSON.stringify(requestParameter);
        invokeFlutterCommonChannel(map, (resultStr) => {
        })
    }

    static pop() {
        let paramsMap = {};
        let requestParameter = {};
        requestParameter['className'] = "FairNavigator#pop";
        requestParameter['funcName'] = 'invokePlugin';
        requestParameter['args'] = paramsMap;
        requestParameter['pageName'] = '#FairKey#';
        let map = JSON.stringify(requestParameter);
        invokeFlutterCommonChannel(map, (resultStr) => {
        })
    }


}
