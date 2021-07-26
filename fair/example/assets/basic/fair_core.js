/*
 * 用户的基础js，一般情况不需要改动
 */

let GLOBAL = {};

function invokeJSFunc(parameter) {
    if (parameter === null) {
        return null;
    }
    let map = JSON.parse(parameter);
    if ('method' === map['type']) {
        return _invokeMethod(map);
    } else if ('variable' === map['type']) {
        return _invokeVariable(map);
    }
    return null;
}

function _invokeVariable(par) {
    console.log('_invokeVariable' + JSON.stringify(par));
    let pName = par['pageName'];
    let varMap = par['args'];
    let curPage = GLOBAL[pName];
    let callResult = {
        pageName: pName,
        result: {}
    };
    if (!isNull(varMap) && Object.keys(varMap).length > 0) {
        Object.keys(varMap).forEach(function (varKey) {
            callResult['result'][varKey] = eval('curPage.' + varKey.toString());
        });
        return JSON.stringify(callResult);
    }
    //如果没有传参数，默认返回全部的变量以及结果值
    Object.keys(curPage).forEach(function (key) {
        if (!isFunc(curPage[key])) {
            callResult['result'][key] = eval('curPage.' + key.toString());
        }
    });
    return JSON.stringify(callResult);
}

function _invokeMethod(par) {
    let pageName = par['pageName'];
    let funcName = par['args']['funcName'];
    let args = par['args']['args'];

    if ('getAllJSBindData' === funcName) {
        return getAllJSBindData(par);
    }
    if ('releaseJS' === funcName) {
        return _release(par);
    }
    let mClass = GLOBAL[pageName];
    let methodResult = mClass[funcName].apply(mClass, args);
    let result = {
        pageName: pageName,
        result: {
            result: methodResult
        }
    };
    return JSON.stringify(result);
}

function _getAll(par) {
    let pageName = par['pageName'];
    let mc = GLOBAL[pageName];
    let bind = {};
    if (isNull(mc)) {
        return JSON.stringify(bind);
    }
    let bindFunc = [];
    let bindVariables = {};
    let keys;
    if (!isNull(keys = Object.keys(mc))) {
        for (let i = 0; i < keys.length; i++) {
            let k = keys[i];
            if (!mc.hasOwnProperty(k)) {
                continue;
            }
            if (isFunc(mc[k])) {
                bindFunc.push(k);
            } else {
                bindVariables[k] = mc[k];
            }
        }
    }
    bind['func'] = bindFunc;
    bind['variable'] = bindVariables;
    return bind;
}

//demo 获取所有的变量和绑定的方法
function getAllJSBindData(par) {
    let pageName = par['pageName'];
    let bind = _getAll(par);
    let result = {
        pageName: pageName,
        result: {
            result: bind
        }

    };
    return JSON.stringify(result);
}


function _release(par) {
    let pageName = par['pageName'];
    GLOBAL[pageName] = null;
    return null;
}


function isFunc(name) {
    return typeof name === "function";
}

function isNull(prop) {
    return prop === null || 'undefined' === prop
        || 'undefined' === typeof prop
        || undefined === typeof prop
        || 'null' === prop;
}

function setState(pageName, obj) {
    console.log('JS:setState()_before'+pageName+'-'+obj);
    let p = {};
    p['funcName'] = 'setState';
    p['pageName'] = pageName;
    p['args'] = obj;
    let map = JSON.stringify(p);
    console.log('JS:setState()'+map);
    invokeFlutterCommonChannel(map);
}

const invokeFlutterCommonChannel = (invokeData, callback) => {
    console.log("invokeData" + invokeData)
    jsInvokeFlutterChannel(invokeData, (resultStr) => {
        console.log('resultStr' + resultStr);
        if (callback) {
            callback(resultStr);
        }
    });
};


