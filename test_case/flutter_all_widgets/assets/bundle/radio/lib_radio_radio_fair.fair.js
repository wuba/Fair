GLOBAL['#FairKey#']=(function(__initProps__){const __global__=this;return runCallback(function(__mod__){with(__mod__.imports){function _FairRadioPageState(){const inner=_FairRadioPageState.__inner__;if(this==__global__){return new _FairRadioPageState({__args__:arguments});}else{const args=arguments.length>0?arguments[0].__args__||arguments:[];inner.apply(this,args);_FairRadioPageState.prototype.ctor.apply(this,args);return this;}}_FairRadioPageState.__inner__=function inner(){this.fairProps=__initProps__;};_FairRadioPageState.prototype={initState:function initState(){const __thiz__=this;with(__thiz__){fairProps=widget.fairProps;}},_onChanged:function _onChanged(value){const __thiz__=this;const __arg_ctx__={value,};with(__thiz__){with(__arg_ctx__){print(`${value}`);}}},_getValue:()=>fairProps.__op_idx__('value');,_getGroupValue:()=>fairProps.__op_idx__('groupValue');,};_FairRadioPageState.prototype.ctor=function(){Object.prototype.ctor.call(this);};;return _FairRadioPageState();}},[]);})(convertObjectLiteralToSetOrMap(JSON.parse('#FairProps#')));