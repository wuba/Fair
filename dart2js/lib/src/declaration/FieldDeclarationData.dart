class FieldDeclarationData {
  String? name;
  String? initVal;
  var isStatic = false;
  var isGetter = false;

  FieldDeclarationData(this.name, this.initVal);
}