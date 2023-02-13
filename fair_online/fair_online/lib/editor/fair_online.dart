import 'core/dependencies.dart';
import 'core/keys.dart';
import 'services/dartservices.dart';

DartservicesApi get dartServices => deps[DartservicesApi] as DartservicesApi;

Keys get keys => deps[Keys] as Keys;