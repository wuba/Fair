import 'package:fair_gallery/src/widget/source_code_view_button.dart';
import 'package:flutter/material.dart';

class CommomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommomAppBar({super.key, required this.title, required this.asset});
  final String title;
  final String asset;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        SourceCodeViewButton(
          asset: asset,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
