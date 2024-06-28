import 'package:fair/fair.dart';
import 'package:fair_gallery/src/generated_module/app.bindings.dart';
import 'package:fair_gallery/src/generated_module/flutter.bindings.dart';
import 'package:fair_gallery/src/generated_module/packages.bindings.dart';
import 'package:fair_gallery/src/utils/text/my_extended_text_selection_controls.dart';
import 'package:fair_gallery/src/utils/text/my_special_text_span_builder.dart';

class FairAppGeneratedModule extends GeneratedModule {
  @override
  Map<String, dynamic> components() {
    return <String, dynamic>{
      ...appComponents,
      ...packagesComponents,
      ...flutterComponents,
      'MySpecialTextSpanBuilder': (props) => MySpecialTextSpanBuilder(),
      'MyTextSelectionControls': (props) => MyTextSelectionControls(),

      // add your cases here.
    };
  }

  /// true means it's a widget.
  @override
  Map<String, bool> mapping() {
    return <String, bool>{
      ...appMapping,
      ...packagesMapping,
      ...flutterMapping,
      'MySpecialTextSpanBuilder': false,
      'MyTextSelectionControls': false,

      // remember add your cases here too.
    };
  }
}
