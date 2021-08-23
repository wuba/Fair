          
        
    require('./bigInt.js')

    function testBigIntExtend(){
        
      console.log(BigInt.from(10000000000000000.23))

      console.log(BigInt.parse('-1'))
      console.log(BigInt.parse('12'))
      console.log(BigInt.tryParse('2.2'));
      console.log(Number('237462836487263478235472364782364827648632784628364'))

      console.log(BigInt.one)

      console.log(BigInt.two)

      console.log(BigInt.zero)
    
    }

    testBigIntExtend();


    

        
       
   