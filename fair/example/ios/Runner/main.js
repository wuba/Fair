function isRealNum(val) {
    // isNaN()函数 把空串 空格 以及NUll 按照0来处理 所以先去除，
    if (val === "" || val == null) {
        return false;
    }
    return !isNaN(val);
}

function isNull(obj) {
    return null === obj || undefined === obj || '' === obj;
}

function isFunc(obj) {
    return typeof obj === undefined
}

class LogicPage {
    /*key : 名称  value:对象*/
    map = {};

    add(pageName, v) {
        v['nameId'] = pageName
        this.map[pageName] = v;
    }

    /**
     * 执行具体的函数
     * @param pageName
     * @param funcName
     * @param args
     * @returns {*}
     */
    invokeMethod(pageName, funcName, args) {
        let obj = this.map[pageName]
        if (obj !== null) {
            return obj[funcName]()
        }
        return null
    }

    /**
     * 修改并获取具体的变量
     * @param pageName
     * @param varName
     * @param value
     * @returns {*}
     */
    invokeVariable(pageName, varName, value) {

        let obj = this.map[pageName]
        // let mVar = obj['data']
        let result = {}
        if (isNull(varName)) {
            for (let objKey in obj) {
                if (isFunc(obj[objKey])) {
                    continue
                }
                if ("nameId" !== objKey)
                    result[objKey] = obj[objKey]
            }
            return JSON.stringify(result)
        }

        result[varName] = obj[varName]
        return JSON.stringify(result)

        // if (!isNull(value)) {
        //     obj[varName] = value;
        //     if ("HelloPage" !== objKey)
        //         result[objKey] = obj[objKey]
        //     return value
        // } else {
        //     if ("HelloPage" !== objKey)
        //         result[objKey] = obj[objKey]
        //     return
        // }
    }

    executeJs(pageName, js) {
        let obj = this.map['HelloPage']

        // let b = 'obj._count % 2 == 1'
        let b = js.replace('this', 'obj')

        return eval(b)

    }

    /**
     * 绑定dart侧函数
     * @param pageName
     * @param funcName
     * @param func
     */
    bindFunction(pageName, funcName, func) {
        let obj = this.map[pageName]
        Object.defineProperty(obj, funcName, {
            writable: false,
            value: func
        })
    }

}

let obj = new LogicPage();

function loadData(d) {
    d.setData = function (obj) {
        setState(obj)
    }
    //添加映射对象
    obj.add('HelloPage', d)

}

function invokeMethod(funcName) {
    return obj.invokeMethod('HelloPage', funcName)
}

function invokeVariable(varName, value) {
    return obj.invokeVariable('HelloPage', varName, value)
}

function executeJs(js) {
    console.log('aaaaaaaa')
    return obj.executeJs('HelloPage', js)
}


