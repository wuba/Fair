let FairChangeNotifierPool = {};

let FairProviderPlugin = class FairProviderPlugin {

    static create(key, initialJson) {
        if (!FairChangeNotifierPool[key]) {
            let fairChangeNotifier
            try {
                fairChangeNotifier = JSON.parse(initialJson);
            } catch (e) {
                fairChangeNotifier = {}
            }
            console.log("miseryy 创建model key = " + key)
            FairChangeNotifierPool[key] = fairChangeNotifier;
            fairChangeNotifier.fairRuntimeTypeKey = key;
            fairChangeNotifier.notify = function () {
                let paramsMap = {};
                paramsMap['fairRuntimeTypeKey'] = this.fairRuntimeTypeKey
                paramsMap['jsonMap'] = JSON.stringify(this)
                let requestParameter = {};
                requestParameter['className'] = "FairProvider#notifyListeners";
                requestParameter['funcName'] = 'invokePlugin';
                requestParameter['args'] = paramsMap;
                requestParameter['pageName'] = '#FairKey#';
                let map = JSON.stringify(requestParameter);
                invokeFlutterCommonChannel(map, (resultStr) => {
                })
            }
            fairChangeNotifier.print = function () {
                console.log("misery " + this.fairRuntimeTypeKey + "👇🏻")
                console.log(this)
            }
        }
    }

    static find(className) {
        //如果FairChangeNotifierPool中有key为className的value，则直接返回value
        //没有则创建FairChangeNotifier并以className为key存入FairChangeNotifierPool
        if (!FairChangeNotifierPool[className]) {
            FairChangeNotifierPool[className] = new FairChangeNotifier(className);
        }
        return FairChangeNotifierPool[className];
    }

    static evaluation(className, evaluation) {
        if (!FairChangeNotifierPool[className]) {
            FairChangeNotifierPool[className] = new FairChangeNotifier(className)
        }
        let fairChangeNotifier = FairChangeNotifierPool[className]
        let temp
        eval("temp = fairChangeNotifier." + evaluation)
        return temp
    }

    static release() {
        //TODO
    }

}

GLOBAL["FairProviderPlugin"] = FairProviderPlugin;

invokeMethodArgsInterceptorManager.use((object) => {
    if (object.hasOwnProperty("id") && object["id"] === "FairContext") {
        object.read = function (name) {
            //从treeModelKeyRecords数组中找到startwith(name)的元素
            return FairChangeNotifierPool[findFirstMatchedElement(this.treeModelKeyRecords, name)];
        }
        return true;
    }
})

function findFirstMatchedElement(treeModelKeyRecords, name) {
    let latestMatchedElement = null;

    for (let i = 0; i < treeModelKeyRecords.length; i++) {
        const element = treeModelKeyRecords[i];

        // 使用正则表达式提取元素中的名称部分
        const match = element.match(/(.+)_(\d+)/);

        if (match && match[1] === name) {
            latestMatchedElement = element;
            break; // 找到匹配项后，结束循环
        }
    }

    return latestMatchedElement;
}


