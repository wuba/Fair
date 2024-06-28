import 'package:extended_image/extended_image.dart';
import 'package:fair/fair.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:photo_manager/photo_manager.dart';

mixin PhotoPlugin implements FairCommonPluginMixin {
  Future<dynamic> savePhoto(dynamic map) => request(
        map,
        (dynamic requestMap) async {
          final url = requestMap['url'];
          var name = path.basenameWithoutExtension(url);

          final String title =
              '${name.isNotEmpty ? name : DateTime.now().millisecondsSinceEpoch}.jpg';
          final Uint8List? data =
              await getNetworkImageData(url, useCache: true);
          final AssetEntity? imageEntity = await PhotoManager.editor.saveImage(
            data!,
            title: title,
          );
          return {'success': imageEntity != null};
        },
      );
}
