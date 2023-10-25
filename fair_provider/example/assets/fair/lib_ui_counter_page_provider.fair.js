GLOBAL['#FairKey#']=(function(__initProps__){const __global__=this;return runCallback(function(__mod__){with(__mod__.imports){function _CounterPageProviderState(){const inner=_CounterPageProviderState.__inner__;if(this==__global__){return new _CounterPageProviderState({__args__:arguments});}else{const args=arguments.length>0?arguments[0].__args__||arguments:[];inner.apply(this,args);_CounterPageProviderState.prototype.ctor.apply(this,args);return this;}}_CounterPageProviderState.__inner__=function inner(){this.title="我是写在js侧的title";this.counterModelJson=`{
    "count":22,
    "testName":"zzzzzz",
    "someModel":{
        "a":"ffffff"
    }
}
      `;this.loginModelJson=`        {
    "account":"qwerty12345",
    "password":"zxcv54321"
}
      `;this.counterModelJson2=`{
    "count":333,
    "testName":"testName的初始值",
    "someModel":{
        "a":"someModel中a的初始值"
    }
}
      `;};_CounterPageProviderState.prototype={onLoad:function onLoad(){const __thiz__=this;with(__thiz__){}},onUnload:function onUnload(){const __thiz__=this;with(__thiz__){}},_incrementCounter:function _incrementCounter(context){const __thiz__=this;const __arg_ctx__={context,};with(__thiz__){with(__arg_ctx__){let counterModel=context.read("CounterModel");counterModel.count++;counterModel.testName="及哦飞机佛IE我房间";counterModel.someModel.a="hahahaha";counterModel.notify();}}},};_CounterPageProviderState.prototype.ctor=function(){};;return _CounterPageProviderState();}},[]);})(convertObjectLiteralToSetOrMap(JSON.parse('#FairProps#')));