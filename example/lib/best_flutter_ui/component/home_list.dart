import 'package:example/best_flutter_ui/app_theme.dart';
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class HomeListView extends StatelessWidget {
  const HomeListView({Key? key,required this.imagePath,required this.callBack}) : super(key: key);

  @FairWell('imagePath')
  final String imagePath;
  @FairWell('callBack')
  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Image.asset(imagePath, fit: BoxFit.cover),
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: AppTheme.greyWithOpacity,
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                onTap: callBack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
