import 'package:flutter/material.dart';
import 'package:yb_news/app/core/styles/app_colors.dart';

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.style,
    this.color = AppColors.neutral2,
    this.align,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight,
    this.fontSize = 14,
    this.lineThrough = false,
    this.decoration = TextDecoration.none,
  });

  final String text;
  final TextStyle? style;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow overflow;
  final double? fontSize;
  final bool lineThrough;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final base = style ?? Theme.of(context).textTheme.bodyMedium!;

    return Text(
      text,
      style: base.copyWith(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        decoration: lineThrough ? TextDecoration.lineThrough : decoration,
      ),
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
