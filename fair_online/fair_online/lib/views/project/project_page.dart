import 'package:fair_online/models/project_model.dart';
import 'package:fair_online/views/project/project_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  ProjectPageState createState() => ProjectPageState();
}

class ProjectPageState extends State<ProjectPage> {
  @override
  void initState() {
    var model = context.read<ProjectModel>();
    model.initialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ProjectPageView(this);
}
