require('./list');

function pre() {
    global.print = console.log.bind(console);
}

function run() {
    let obj = [];
    obj.addAll([2, 3, 4, 5, 6, 7]);
    
    print(obj.followedBy([8, 9 ,10]));
    print(obj.where(e => e %2));
    print([[1,2],[3,4]].expand(e=>e));
    print(obj.contains(4));
    print(obj.fold(3, (a, b) => a + b));
    print(obj.any(e => e == 6));
    print(obj.toList());
    print(obj.take(3));
    print(obj.takeWhile(e => e < 5));
    print(obj.skip(3));
    print(obj.skipWhile(e => e < 4));
    let obj1 = [10];
    print(obj1.single);
    print(obj.firstWhere(e => e == 4));
    print(obj.firstWhere(e => e > 400, { orElse:() => -1}));
    print(obj.lastWhere(e => e < 7, { orElse: () => -1 }));
    print(obj.lastWhere(e => e > 70, { orElse: () => -1 }));
    print(obj.singleWhere(e => e == 6));
    print(obj.singleWhere(e => e > 0, { orElse: () => -1 }));
    print(obj.elementAt(3));
    print(obj.isEmpty);
    print(obj.isNotEmpty);
}

pre();
run();