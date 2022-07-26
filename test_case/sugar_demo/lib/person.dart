import 'package:fair/fair.dart';
import 'package:fair/src/render/base_model.dart';

class Person implements BaseModel{
  final String name;
  final int age;
  final int wei;
  const Person({ required this.name, required this.age,required this.wei});


  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = name;
    json['age'] = age;
    return json;
  }
  @override
  static Person from(Map props) {
    var name = props["name"];
    var age = props["age"];
    var wei = props["wei"];
    return Person(name: name, age: age,wei: wei);
  }
}
