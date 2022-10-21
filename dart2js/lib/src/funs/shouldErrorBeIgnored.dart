import 'package:analyzer/error/error.dart';
import 'package:fair_dart2js/src/list_ext.dart';

bool shouldErrorBeIgnored(List<AnalysisError> errors) {
  var ignoredErrors = ['CONTINUE_OUTSIDE_OF_LOOP', 'BREAK_OUTSIDE_OF_LOOP'];
  return errors.firstWhereOrNull((err) => !ignoredErrors.contains(err.errorCode.name), orElse: () => null) == null;
}