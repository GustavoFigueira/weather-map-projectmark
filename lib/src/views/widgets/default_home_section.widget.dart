import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_map/src/views/widgets/default_home_section_padding.widget.dart';

class DefaultHomeSection extends StatelessWidget {
  const DefaultHomeSection({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => DefaultHomeSectionPadding(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: 21,
            fontFamily:
                GoogleFonts.archivo(fontWeight: FontWeight.w800).fontFamily,
            color: Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 21),
        child,
      ],
    ),
  );
}
