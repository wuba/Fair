class DemoList extends Object {
  List<DemoItem> list;
  int total;

  DemoList({
    this.list,
    this.total,
  });

  factory DemoList.fromJson(Map<String, dynamic> json) => DemoList(
        list: (json['list'] as List)
            ?.map((e) =>
                e == null ? null : DemoItem.fromJson(e as Map<String, dynamic>))
            ?.toList(),
        total: json['total'] as int,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'list': list,
        'total': total,
      };
}

class DemoItem extends Object {
  String id;
  String name = '';
  String type = '';

  DemoItem({this.id, this.name, this.type});

  factory DemoItem.fromJson(Map<String, dynamic> json) => DemoItem(
        id: json['id'] as String,
        name: json['name'] as String,
        type: json['type'] as String,
      );

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'id': String, 'name': name, 'type': type};
}
