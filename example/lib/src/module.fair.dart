import 'package:example/src/generated_module/app.bindings.dart';
import 'package:example/src/generated_module/flutter.bindings.dart';
import 'package:example/src/generated_module/packages.bindings.dart';
import 'package:fair/fair.dart';

class FairAppModule extends GeneratedModule {
  @override
  Map<String, dynamic> components() {
    return <String, dynamic>{
      ...appComponents,
      ...packagesComponents,
      ...flutterComponents,
      // add your cases here.
    };
  }

  @override
  Map<String, bool> mapping() {
    return <String, bool>{
      ...appMapping,
      ...packagesMapping,
      ...flutterMapping,
      // remember add your cases here too.
    };
  }
}
