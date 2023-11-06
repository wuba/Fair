import 'package:fair_provider/fair_provider.dart';

class ExampleModel extends FairChangeNotifier {
  String? stringField;
  int intField = 1;
  double? doubleField;
  bool boolField = false;
  List? listField;
  ExampleInnerModel? innerModel;
}

class ExampleInnerModel {
  bool? innerBoolField;
}
