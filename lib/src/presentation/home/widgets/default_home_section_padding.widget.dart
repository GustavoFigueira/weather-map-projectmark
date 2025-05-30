import 'package:flutter/material.dart';
import 'package:weather_map/src/presentation/home/home.view.dart';

class DefaultHomeSectionPadding extends StatelessWidget {
  const DefaultHomeSectionPadding({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: kHomeDefaultSpacing),
    child: child,
  );
}
