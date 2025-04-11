import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ServicesLoadingView extends StatelessWidget {
  const ServicesLoadingView({super.key});

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: ui.TextDirection.ltr,
    child: ColoredBox(
      color: Color(0xFF1B3E67),
      child: Center(child: CircularProgressIndicator(color: Colors.white)),
    ),
  );
}
