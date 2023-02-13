import 'package:fair_online/app/themes.dart';
import 'package:flutter/material.dart';

typedef Widget CustomChildBuilder<T>(BuildContext context, T t);

class CustomCodeListView<T> extends StatelessWidget {
  List<T> list = [];
  CustomChildBuilder builder;

  CustomCodeListView({required this.list, required this.builder});

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  Widget _buildList(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return Container(
      child: ListView.separated(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return builder(context, list[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Divider(height: 1, color: theme.divider),
            );
          }),
    );
  }
}
