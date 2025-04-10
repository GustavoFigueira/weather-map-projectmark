import 'package:flutter/material.dart';

class DefaultHomeSectionPadding extends StatelessWidget {
  const DefaultHomeSectionPadding({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: 35), child: child);
}
