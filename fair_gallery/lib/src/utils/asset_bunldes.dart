// 由 fair_gallery/bin/build.dart 生成
import 'package:fair_gallery/assets.dart';

final Map<String, String> _bundles = <String, String>{
  'fair://FunctionDomainDemo':
      Assets.assets_fair_lib_src_page_simple_function_domain_fair_bin,
  'fair://ListenableScopeDemo':
      Assets.assets_fair_lib_src_page_simple_listenable_scope_fair_bin,
  'fair://PhotoGalleryItem':
      Assets.assets_fair_lib_src_page_complex_photo_gallery_item_fair_bin,
  'fair://PhotoGalleryPage':
      Assets.assets_fair_lib_src_page_complex_photo_gallery_fair_bin,
  'fair://PhotoGalleryPage1':
      Assets.assets_fair_lib_src_page_complex_photo_gallery1_fair_bin,
  'fair://PhotoSwiper':
      Assets.assets_fair_lib_src_page_complex_photo_swiper_fair_bin,
  'fair://PluginDemo': Assets.assets_fair_lib_src_page_simple_plugin_fair_bin,
  'fair://SugarDemo': Assets.assets_fair_lib_src_page_simple_sugar_fair_bin
};

extension FairBundleE on String {
  String? get fairBundle => _bundles[this];
}
