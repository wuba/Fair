GLOBAL['#FairKey#']=(function(__initProps__){const __global__=this;return runCallback(function(__mod__){with(__mod__.imports){function _FairRefreshIndicatorPageState(){const inner=_FairRefreshIndicatorPageState.__inner__;if(this==__global__){return new _FairRefreshIndicatorPageState({__args__:arguments});}else{const args=arguments.length>0?arguments[0].__args__||arguments:[];inner.apply(this,args);_FairRefreshIndicatorPageState.prototype.ctor.apply(this,args);return this;}}_FairRefreshIndicatorPageState.__inner__=function inner(){this.fairProps=__initProps__;this._list=[1,2,3,4,5];};_FairRefreshIndicatorPageState.prototype={initState:function initState(){const __thiz__=this;with(__thiz__){fairProps=widget.fairProps;}},_onRefresh:async function _onRefresh(){const __thiz__=this;with(__thiz__){setState('#FairKey#',function dummy(){_list.add(_list.length+1);});}},};_FairRefreshIndicatorPageState.prototype.ctor=function(){Object.prototype.ctor.call(this);};;return _FairRefreshIndicatorPageState();}},[]);})(convertObjectLiteralToSetOrMap(JSON.parse('#FairProps#')));