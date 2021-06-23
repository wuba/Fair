function Page(uPageName) {
    var __global__ = this;

    class DemoItem {
        constructor(a, b) {
            this.id = a;
            this.name = b;
        }
    }

    class DemoList {
        constructor() {
            this.list = new Array();
            this.list.push(new DemoItem(5 * 2, "58"));
            this.list.push(new DemoItem(5 * 4, "fair"));
            this.total = 2;
        }
    }

    return HelloLogicPage = {
        props: "#(FairProps)",
        data: {
            _count: 10,
            _response: new DemoList(),
        },
        _isCanMod2: function _isCanMod2() {
            return this.data._response.total % 2 == 1;

        },
        onTapText: function onTapText() {
            this.data._count++;
            this.data._response.total = this.data._response.total + 1;
            let map = {
                pageName: uPageName,
                _count: this.data._count
            };
            setData(map);

        },
        _initData: function _initData(id) {
//         FairNet.request({url:"http://op.juhe.cn/onebox/weather/query",header: {"Content-Type" : "application/x-www-form-urlencoded"},method:"POST",data: {"cityname" : "上海", "key" : "1430ec127e097e1113259c5e1be1ba70"},complete:function dummy(value)  {
//     _data.count = value['count'];
//   this.setData({count: that.data._data._count});
//
//   }});

        }, onLaunch: function onLaunch() {

        },
        onDispose: function onDispose() {
            console.log("onDispose");
        }

    };
}


let hello_world = new Page('hello_world');
GLOBAL['hello_world'] = hello_world;


function invokeJSFunc(parameter) {
    if (parameter === null) {
        return null;
    }

    let map = JSON.parse(parameter);

    if ('method' === map['type']) {
        return _invokeMethod(parameter)
    }
    return null;

}

function test() {
    let map = {
        "pageName": "hello_world",
        "type": "method",
        "args": {
            "funcName": "getAllJSBindData",
            "args": null
        }
    };

    console.log('all bind data :' + invokeJSFunc(JSON.stringify(map)));
}


function _invokeMethod(parameter) {
    let o = JSON.parse(parameter);
    let pageName = o['pageName'];
    let funcName = o['args']['funcName'];
    let args = o['args']['args'];

    if ('getAllJSBindData' === funcName) {
        return getAllJSBindData(parameter);
    }

    let mClass = GLOBAL[pageName];
    console.log('mClass' + mClass);
    console.log('args:' + args);

    let methodResult = mClass[funcName].apply(mClass, args);
    console.log('methodResult' + methodResult);
    
    let result = {
        pageName: pageName,
        result: {
            result: methodResult
        }

    };
    return JSON.stringify(result);
}


//demo 获取所有的变量和绑定的方法
function getAllJSBindData(parameter) {
    let o = JSON.parse(parameter);
    let pageName = o['pageName'];
    let mc = GLOBAL[pageName];

    let bind = {};

    if (isNull(mc)) {
        return JSON.stringify(bind);
    }

    let bindFunc = [];
    let keys;

    if (!isNull(keys = Object.keys(mc))) {
        let kIndex = 0;
        for (let i = 0; i < keys.length; i++) {
            let k = keys[i];

            if (!mc.hasOwnProperty(k)) {
                continue
            }
            if (isFunc(mc[k])) {

                bindFunc[kIndex] = k;
                kIndex++;
                continue
            }
            //先只要data里面的变量
            if ('data' === k) {
                bind['variable'] = mc[k];
            }
        }
    }
    bind['func'] = bindFunc;
    let result = {
        pageName: pageName,
        result: {
            result: bind
        }

    };

    return JSON.stringify(result);
}

function isFunc(name) {
    return typeof name === "function";
}

function isNull(prop) {
    return (prop === null || 'undefined' === prop
        || 'undefined' === typeof prop
        || undefined === typeof prop
        || 'null' === prop);
}



