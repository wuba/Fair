import 'package:fair/fair.dart';

//adapt third-party library
abstract class IFairLibraryAdapter{
  //provide the generated module
  GeneratedModule? provideGeneratedModule();

  //provide fair plugins
  Map<String, IFairPlugin>? provideFairPlugins();

  //provide js plugins
  Map<String, String>? provideJSPlugins();

  //provide dynamic widget builder
  DynamicWidgetBuilderFunction? provideDynamicWidgetBuilder();

  //provide fair delegate
  Map<String, FairDelegateBuilder>? provideFairDelegate();

  //provide fair module
  Map<String, FairModuleBuilder>? provideFairModule();
}
