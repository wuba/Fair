import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class AppBarTemplate extends StatefulWidget {
  const AppBarTemplate({Key? key}) : super(key: key);

  @override
  State<AppBarTemplate> createState() => _AppBarTemplateState();
}

class _AppBarTemplateState extends State<AppBarTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('AppBar'),
        centerTitle: true,
        toolbarHeight: 55,
        primary: true,
        backgroundColor: Colors.blue,
        toolbarOpacity: 1,
        actions: [],
      ),
    );
  }
}
