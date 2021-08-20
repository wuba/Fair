require('./map');

function pre() {
    global.print = console.log.bind(console);
    global.convertObjectLiteralToMap = function(obj) {
        var keys = Object.getOwnPropertyNames(obj);
        var res = new Map();
        keys.forEach(k => res.set(k, obj[k]));
        return res;
    }
}

function run() {
    function printMap(obj) {
        print(obj.keys);
        print(obj.values);
        print(obj.entries);
        print(obj.length);
        print(obj.isEmpty);
        print(obj.isNotEmpty);
    }
    var obj = convertObjectLiteralToMap({});
    obj.addEntries([MapEntry('a', 1), MapEntry('b', 2), MapEntry('c', 3)]);
    printMap(obj);
    obj.addAll(convertObjectLiteralToMap({'d': 4, 'e': 5}));
    printMap(obj);
    print(obj.containsKey('c'));
    print(obj.containsValue(4));

    var obj2 = obj.map((key, value) => MapEntry(`${key}1`, value + 10));
    printMap(obj2);
    
    print(obj.update('b', (value) => value + 100));
    print(obj.update('f', (value) => value + 100, {ifAbsent: () => -1}));
    printMap(obj);
    obj.updateAll((k, v) => k < 'b' ? v + 1000 : v - 1000);
    printMap(obj);

    obj.removeWhere((k, v) => ['a', 'b'].indexOf(k) > -1 && v < 0);
    printMap(obj);

    print(obj.putIfAbsent('a', () => -2));
    printMap(obj);
    print(obj.putIfAbsent('h', () => -2));
    printMap(obj);

    print(obj.remove('c1'));
    print(obj.remove('c'));
    print(obj);

    obj.forEach((k, v) => print(`${k}: ${v}`));

    print(obj.__op_idx__('e'));
    obj.__op_idxeq__('e', 333);
    print(obj.__op_idx__('e'));

    obj.clear();
    printMap(obj);
}

pre();
run();