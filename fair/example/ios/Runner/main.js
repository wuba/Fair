let GLOBAL = {}

function invokeJSFunc(parameter) {
    if (parameter === null) {
        return null;
    }

    let map = JSON.parse(parameter);

    if ('method' === map['type']) {
        return _invokeMethod(parameter)
    }
    return null

}

function test() {
    let map = {
        "pageName": "hello_world",
        "type": "method",
        "args": {
            "funcName": "getAllJSBindData",
            "args": null
        }
    }

    console.log('all bind data :' + invokeJSFunc(JSON.stringify(map)))
}

function _invokeMethod(parameter) {
    let o = JSON.parse(parameter) let pageName = o['pageName'] let funcName = o['args']['funcName'] let args = o['args']['args'];

    if ('getAllJSBindData' === funcName) {
        return getAllJSBindData(parameter)
    }

    let mClass = GLOBAL[pageName]

    let methodResult = mClass[funcName].apply(mClass, args)

    let result = {
        pageName: pageName,
        result: {
            result: methodResult
        }

    }
    return JSON.stringify(result)
}

//demo 获取所有的变量和绑定的方法
function getAllJSBindData(parameter) {
    let o = JSON.parse(parameter) let pageName = o['pageName'] let mc = GLOBAL[pageName]

    let bind = {}

    if (isNull(mc)) {
        return JSON.stringify(bind)
    }

    let bindFunc = [] let keys;

    if (!isNull(keys = Object.keys(mc))) {
        let kIndex = 0;
        for (let i = 0; i < keys.length; i++) {
            let k = keys[i]

            if (!mc.hasOwnProperty(k)) {
                continue
            }
            if (isFunc(mc[k])) {

                bindFunc[kIndex] = k kIndex++
                continue
            }
            //先只要data里面的变量
            if ('data' === k) {
                bind['variable'] = mc[k]
            }
        }
    }

    bind['func'] = bindFunc let result = {
        pageName: pageName,
        result: {
            result: bind
        }

    }

    return JSON.stringify(result)
}

function isFunc(name) {
    return typeof name === "function"
}

function isNull(prop) {
    return prop === null || 'undefined' === prop || 'undefined' === typeof prop || undefined === typeof prop || 'null' === prop
}
