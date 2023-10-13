import 'package:flutter/material.dart';

class DefaultListTile extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String? trailingText;
  final String? trailingTextTitle;
  final void Function()? onTap;
  const DefaultListTile({
    super.key,
    required this.title,
    this.subTitle,
    this.trailingText,
    this.trailingTextTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subTitle ?? ''),
      trailing: trailingTextTitle == null
          ? Text(trailingText ?? '')
          : Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(trailingTextTitle ?? '', textScaleFactor: .8),
                Text(trailingText ?? '')
              ],
            ),
      style: ListTileStyle.list,
      onTap: onTap,
    );
  }
}
