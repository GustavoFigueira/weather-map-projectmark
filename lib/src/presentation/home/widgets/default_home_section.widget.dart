import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_map/src/presentation/home/widgets/default_home_section_padding.widget.dart';

class DefaultHomeSection extends StatelessWidget {
  const DefaultHomeSection({
    super.key,
    required this.title,
    required this.child,
    this.contentPadding = true,
  });

  final String title;
  final Widget child;
  final bool contentPadding;

  Widget _sectionTitle(BuildContext context) => Text(
    title,
    textAlign: TextAlign.start,
    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
      fontSize: 21,
      fontFamily: GoogleFonts.archivo(fontWeight: FontWeight.w800).fontFamily,
      color: Color(0xFF2D3748),
    ),
  );

  Widget _buildContent(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        contentPadding
            ? _sectionTitle(context)
            : DefaultHomeSectionPadding(child: _sectionTitle(context)),
        const SizedBox(height: 21),
        child,
      ],
    );

  @override
  Widget build(BuildContext context) =>
      contentPadding
          ? DefaultHomeSectionPadding(child: _buildContent(context))
          : _buildContent(context);
}
