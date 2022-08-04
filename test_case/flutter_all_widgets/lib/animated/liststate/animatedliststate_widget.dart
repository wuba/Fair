
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairAnimatedListStatePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_FairAnimatedListStatePageState();

}

class _FairAnimatedListStatePageState extends State<FairAnimatedListStatePage>{

  List<int> _list = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void _addItem() {
    final int _index = _list.length;
    _list.insert(_index, _index);
    _listKey.currentState.insertItem(_index);
  }

  void _removeItem() {
    final int _index = _list.length - 1;
    var item = _list[_index].toString();
    _listKey.currentState.removeItem(
        _index, (context, animation) => _buildItem(item, animation));
    _list.removeAt(_index);

  }

  Widget _buildItem(String _item, Animation _animation) {
    return SizeTransition(
      sizeFactor: _animation,
      child: Card(
        child: ListTile(
          title: Text(
            _item,
          ),
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index, Animation animation){
    return _buildItem(_list[index].toString(), animation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter AnimatedListState'),
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _list.length,
        itemBuilder: _itemBuilder,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: _addItem,
            child: Icon(Icons.add),
          ),
          SizedBox(width: 60,),
          FloatingActionButton(
            onPressed: _removeItem,
            child: Icon(Icons.remove),
          )
        ],
      ),
    );
  }

}