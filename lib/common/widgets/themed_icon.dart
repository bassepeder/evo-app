import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThemedIcon extends StatelessWidget {
  final String svgData;
  final double width;
  final double height;
  final BoxFit fit;

  const ThemedIcon({
    super.key,
    required this.svgData,
    this.width = 24,
    this.height = 24,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).iconTheme.color; // Adapt to the theme

    return SvgPicture.string(
      svgData,
      width: 24,
      height: height,
      fit: fit,
      colorFilter: ColorFilter.mode(
        themeColor ?? Colors.black, // Default color if theme color is null
        BlendMode.srcIn,
      ),
    );
  }
}
