import 'package:flutter/material.dart';

class DefaultSeparatedListView extends StatelessWidget {
  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  const DefaultSeparatedListView(
      {super.key, required this.itemCount, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: itemBuilder,
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: itemCount,
    );
  }
}
