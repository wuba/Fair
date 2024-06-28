import 'package:fair_gallery/fair_gallery_routes.dart';
import 'package:flutter/material.dart';

class SourceCodeViewButton extends StatelessWidget {
  const SourceCodeViewButton({super.key, required this.asset});
  final String asset;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.fairSourceCodeViewPage.name,
          arguments: Routes.fairSourceCodeViewPage.d(asset: asset),
        );
      },
      child: Container(
        alignment: Alignment.center,
        color: const Color.fromARGB(1, 255, 255, 255),
        margin: const EdgeInsets.only(right: 12),
        child: const Row(
          children: [
            Icon(Icons.code),
            SizedBox(
              width: 5,
            ),
            Text('Code')
          ],
        ),
      ),
    );
  }
}
