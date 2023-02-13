import 'dart:convert';

import 'package:yaml/yaml.dart';

class ConfigFileUtils {

  static Map? getDependencies(String yamlText) {
    Map? yaml = loadYaml(yamlText);
    Map? dependency = yaml?['dependencies'];
    return dependency;
  }




}