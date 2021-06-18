package com.wuba.fair

val initDemoJs = """
 /*-------------测试文件---------------*/
var GLOBAL = {}

function test() {
    console.log('Start')
    console.log('获取成员变量： ' + invokeVariable('hello_world'))
    console.log('获取成员变量带参数： ' + invokeVariable('hello_world', '_count'))
    console.log('修改成员变量的值： ' + invokeVariable('hello_world', '_count', 10))
    console.log('获取修改后的成员变量带参数： ' + invokeVariable('hello_world', '_count'))
    console.log('执行add() : ' + invokeMethod('hello_world', 'add', [10, 11, 12]))
    console.log('执行_onTapText() : ' + invokeMethod('hello_world', '_onTapText', [null]))
    console.log('执行evaluateJavaScript(): ' + evaluateJavaScript('hello_world', 'this.data._count % 2 == 0'))
}


HelloWorldPage = function () {
    let _HelloWorldPage = function (obj) {
        return obj
    }
    return _HelloWorldPage({
        data: {
            hello: 10,
            world: 10
        },

        changeNum: function () {
            setData({
                hello: 11,
                world: 12
            })
        }
    })
}

//转换后的js文件
MainPage = function () {
    let _mainPage = function (obj) {
        return obj
    }

    return _mainPage({
        data: {
            _count: 5,
        },
        onLaunch: function (id) {
            _initData(id);
        },
        _initData: function (id) {
            that = this;
            FairNet.request({
                url: "http://op.juhe.cn/onebox/weather/query",
                header: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                method: "POST",
                data: {"cityname": "上海", "key": "1430ec127e097e1113259c5e1be1ba70"},
                complete: function (value) {
                    Console.log(value['log']);
                    that.data._count = value['count'];
                    setData({_count: that.data._count})
                }
            });
        },

        _onTapText: function () {
            this.data._count = this.data._count + 1;
            setData({_count: this.data._count})
        }
    })
}


//创建的js文件,这个名称根据一定规则生成
let hello_world = MainPage()
GLOBAL['hello_world'] = hello_world

Object.defineProperty(hello_world, 'setData', {
    value: function (obj) {
        console.log('setData' + JSON.stringify(obj))
        setState({
            className: 'hello_world',
            data: obj
        });
    },
    writable: true,
})

/*--------------------本地注入js文件---------------------*/
/**
 * JS 基础信息
 */
const FairInfo = {
    FairJsVersion: '1.0.0-alpha'
}

// window[GLOBAL]=GLOBAL


/**
 * 获取指定类的变量，函数名称
 */
function getBindFuncData(className) {
    let mClass = GLOBAL[className]
    let bind = {}

    if (isNull(mClass)) {
        return JSON.stringify(bind)
    }

    let bindFunc = []
    let keys;

    if (isNull(keys = Object.keys(mClass))) {
        let kIndex = 0;
        for (let i = 0; i < keys.length; i++) {
            let k = keys[i]

            if (!mClass.hasOwnProperty(k)) {
                continue
            }

            if (isFunc(mClass[k])) {
                bindFunc[kIndex] = k
                kIndex++
                continue
            }

            bind[k] = mClass[k]
        }
    }
    bind['func'] = bindFunc
    return JSON.stringify(bind)
}

/**
 * 执行类里面的方法
 */
function invokeMethod(className, funcName, parameter) {
    let mClass = GLOBAL[className]
    return mClass[funcName].apply(mClass, parameter)
}

/**
 * 获取成员变量的值
 */
function invokeVariable(className, varName, parameter) {
    let mClass = GLOBAL[className]
    if (isNull(mClass)) {
        return null
    }

    let result = {}
    let data = mClass['data']
    if (!isNull(data) && !isNull(data[varName])) {

        if (!isNull(parameter)) {
            data[varName] = parameter
        }

        result[varName] = data[varName]
        return JSON.stringify(result)
    }

    for (let k in mClass) {
        if (mClass.hasOwnProperty(k)) {
            let v = mClass[k]
            if (!isFunc(v)) {
                result[k] = v
            }
        }
    }
    return JSON.stringify(result)
}

/**
 * 执行某个类里面的js脚本
 */
function evaluateJavaScript(className, js) {
    let obj = GLOBAL[className]
    let b = js.replace('this', 'obj')
    return eval(b)
}


function isNull(prop) {
    return prop === null || 'undefined' === prop
        || 'undefined' === typeof prop
        || undefined === typeof prop
        || 'null' === prop
}

function isArray(p) {
    return p != null && p instanceof Array
}

function isFunc(name) {
    return typeof name === "function"
}



""".trimIndent()
