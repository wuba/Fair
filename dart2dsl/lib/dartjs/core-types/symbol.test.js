          
   

     function testSymbolExtend(){
        // 报错 symbol为原始类型而非对象
        // console.log( new Symbol())

        // var lib = Symbol("Foo");
        // var clsToSearch = Symbol("Foo");
        // console.log(lib == clsToSearch)

        // var obj = {'a': 1};
        // obj[Symbol('b')] = 2;
        // obj[Symbol('b')] = 3;
        // console.log(obj);

        // console.log(sym1); // Symbol("name")

        // var sym2 = #titan;
        // print(sym2); // Symbol("titan")
        // console.log(Symbol.aa())
        // console.log( Symbol("_bb").toString())
        console.log(Symbol('Foo'))
        console.log(Symbol.empty)
        console.log(Symbol.unaryMinus)
        console.log(Symbol('name') == Symbol('name') ) //true 原js false
        console.log( Symbol("_bb").toString())
        console.log(Symbol('name').toString() == Symbol('name').toString()); //true 原js true
        console.log(Symbol('#name') == Symbol('name')); //true

        // console.log(NativeSymbol('name') == NativeSymbol('name'))
        // console.log(Symbol('222'))
        // console.log('ahahhahahh')
        // console.log(Symbol.prototype)

    }

    testSymbolExtend();

    
       
   