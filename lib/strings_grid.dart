import 'package:flutter/material.dart';

class StringsGrid extends StatelessWidget {
  final List<Widget> itemWidgets;

  const StringsGrid({Key? key, required this.itemWidgets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: itemWidgets,
    );
  }
}
