GLOBAL['#FairKey#']=(function(__initProps__){const __global__=this;return runCallback(function(__mod__){with(__mod__.imports){function _FairSimpleDialogPageState(){const inner=_FairSimpleDialogPageState.__inner__;if(this==__global__){return new _FairSimpleDialogPageState({__args__:arguments});}else{const args=arguments.length>0?arguments[0].__args__||arguments:[];inner.apply(this,args);_FairSimpleDialogPageState.prototype.ctor.apply(this,args);return this;}}_FairSimpleDialogPageState.__inner__=function inner(){this.fairProps=__initProps__;};_FairSimpleDialogPageState.prototype={initState:function initState(){const __thiz__=this;with(__thiz__){fairProps=widget.fairProps;}},_getChildren:()=>[Container({height:80,alignment:Alignment.center,child:Text('确认删除吗？')}),Divider({height:1}),FlatButton({child:Text('取消'),onPressed:function dummy(){Navigator.of(context).pop('cancel');}}),Divider({height:1}),FlatButton({child:Text('确认'),onPressed:function dummy(){Navigator.of(context).pop('ok');}})];,};_FairSimpleDialogPageState.prototype.ctor=function(){Object.prototype.ctor.call(this);};;return _FairSimpleDialogPageState();}},[]);})(convertObjectLiteralToSetOrMap(JSON.parse('#FairProps#')));