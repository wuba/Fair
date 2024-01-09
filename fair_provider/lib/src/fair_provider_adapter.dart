import 'package:fair/fair.dart';
import 'package:fair_provider/fair_provider.dart';

class FairProviderAdapter implements IFairLibraryAdapter {
  @override
  GeneratedModule provideGeneratedModule() {
    return FairProviderModule();
  }

  @override
  Map<String, FairModuleBuilder> provideFairModule() {
    return {};
  }

  @override
  Map<String, FairDelegateBuilder> provideFairDelegate() {
    return {};
  }

  @override
  DynamicWidgetBuilderFunction provideDynamicWidgetBuilder() {
    return (proxyMirror, page, bound, {bundle}) =>
        ProviderDynamicWidgetBuilder(proxyMirror, page, bound, bundle: bundle);
  }

  @override
  Map<String, String> provideJSPlugins() {
    return {
      'fair_provider':
      'packages/fair_provider/assets/plugin/fair_provider_plugin.js'
    };
  }

  @override
  Map<String, IFairPlugin> provideFairPlugins() {
    return {'FairProvider': FairProvider()};
  }
}
