GLOBAL['#FairKey#']=(function(__initProps__){const __global__=this;return runCallback(function(__mod__){with(__mod__.imports){function _FairReorderableListViewPageState(){const inner=_FairReorderableListViewPageState.__inner__;if(this==__global__){return new _FairReorderableListViewPageState({__args__:arguments});}else{const args=arguments.length>0?arguments[0].__args__||arguments:[];inner.apply(this,args);_FairReorderableListViewPageState.prototype.ctor.apply(this,args);return this;}}_FairReorderableListViewPageState.__inner__=function inner(){this.fairProps=__initProps__;this.items=null;};_FairReorderableListViewPageState.prototype={initState:function initState(){const __thiz__=this;with(__thiz__){fairProps=widget.fairProps;}},_getChildren:function _getChildren(){const __thiz__=this;with(__thiz__){return[for(let item in items){Container({key:ValueKey(item),height:100,margin:EdgeInsets.symmetric({horizontal:50,vertical:10}),decoration:BoxDecoration({color:Colors.primaries.__op_idx__(int.parse(item)%Colors.primaries.length),borderRadius:BorderRadius.circular(10)})});}];}},_onReorder:function _onReorder(oldIndex,newIndex){const __thiz__=this;const __arg_ctx__={oldIndex,newIndex,};with(__thiz__){with(__arg_ctx__){if(oldIndex<newIndex){newIndex-=1;}let child=items.removeAt(oldIndex);items.insert(newIndex,child);setState('#FairKey#',function dummy(){});}}},};_FairReorderableListViewPageState.prototype.ctor=function(){Object.prototype.ctor.call(this);};;return _FairReorderableListViewPageState();}},[]);})(convertObjectLiteralToSetOrMap(JSON.parse('#FairProps#')));