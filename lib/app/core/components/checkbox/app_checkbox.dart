import 'package:flutter/material.dart';
import 'package:yb_news/app/core/components/typography/app_text.dart';
import 'package:yb_news/app/core/styles/app_colors.dart';
import 'package:yb_news/app/extentions/empty_extention.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.activeColor,
    this.checkColor,
    this.size = 24,
    this.gap = 4,
    this.alignment = CrossAxisAlignment.center,
  });

  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String? label;

  // Style
  final Color? activeColor;
  final Color? checkColor;
  final double size;
  final double gap;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onChanged == null ? null : () => onChanged!(!value),
      borderRadius: BorderRadius.circular(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: alignment,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
              activeColor: activeColor,
              checkColor: checkColor,
            ),
          ),
          SizedBox(width: gap),
          if (label.isNotNullOrEmpty) ...[
            AppText(label!, color: AppColors.neutral2),
          ],
        ],
      ),
    );
  }
}
