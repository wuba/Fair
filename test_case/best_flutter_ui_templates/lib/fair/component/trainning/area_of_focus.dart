import 'package:fair/fair.dart';
import 'package:flutter/material.dart';


@FairPatch()
class FocusView extends StatefulWidget {
  const FocusView({Key? key}) : super(key: key);

  @override
  _FocusListViewState createState() => _FocusListViewState();
}

class _FocusListViewState extends State<FocusView> {

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 24.0,
            crossAxisSpacing: 24.0,
            childAspectRatio: 1.0,
            children: [
              AspectRatio(
                aspectRatio: 1.5,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  child: Image.network(
                      'https://pic5.58cdn.com.cn/nowater/frs/n_v31ea165ec1cb846ca89a334fde9b78f2d.png',
                      fit: BoxFit.cover),
                ),
              ),
              AspectRatio(
                aspectRatio: 1.5,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  child: Image.network(
                      'https://pic6.58cdn.com.cn/nowater/frs/n_v31ffd5c348ceb41f597bdc2063f4669f6.png',
                      fit: BoxFit.cover),
                ),
              ),
              AspectRatio(
                aspectRatio: 1.5,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  child: Image.network(
                      'https://pic1.58cdn.com.cn/nowater/frs/n_v3069ac48509cf4f728e65bdf91421967c.png',
                      fit: BoxFit.cover),
                ),
              ),
            ],
          )
          ),
    );
  }
}

