GLOBAL['#FairKey#']=(function(__initProps__){const __global__=this;return runCallback(function(__mod__){with(__mod__.imports){function _FairCupertinoTabBarState(){const inner=_FairCupertinoTabBarState.__inner__;if(this==__global__){return new _FairCupertinoTabBarState({__args__:arguments});}else{const args=arguments.length>0?arguments[0].__args__||arguments:[];inner.apply(this,args);_FairCupertinoTabBarState.prototype.ctor.apply(this,args);return this;}}_FairCupertinoTabBarState.__inner__=function inner(){this.fairProps=__initProps__;this.tabs=null;};_FairCupertinoTabBarState.prototype={initState:function initState(){const __thiz__=this;with(__thiz__){fairProps=widget.fairProps;}},_getTabList:function _getTabList(){const __thiz__=this;with(__thiz__){return['首页','我的'];}},_getTableItem:function _getTableItem(){const __thiz__=this;with(__thiz__){return Sugar.mapEach(_getTabList(),(index,item)=>BottomNavigationBarItem({icon:Icon(CupertinoIcons.home),label:item})).toList();}},_getTabBarWidget:function _getTabBarWidget(){const __thiz__=this;with(__thiz__){print(fairProps.__op_idx__('tabList'));return CupertinoTabBar({items:_getTableItem()});}},};_FairCupertinoTabBarState.prototype.ctor=function(){Object.prototype.ctor.call(this);};;return _FairCupertinoTabBarState();}},[]);})(convertObjectLiteralToSetOrMap(JSON.parse('#FairProps#')));