import 'package:fair_online/models/fair_dsl_model.dart';
import 'package:fair_online/views/fair_dsl_editor/fair_dsl_dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FairDslDashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FairDslDashboardState();
  }
}

class FairDslDashboardState extends State<FairDslDashboard> {
  @override
  void initState() {
    context.read<FairDslModel>().getFairDslList(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FairDslDashboardView(this);
  }
}
