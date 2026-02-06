import 'package:flutter/material.dart';
import 'package:yb_news/app/core/components/typography/app_text.dart';
import 'package:yb_news/app/extentions/empty_extention.dart';
import 'package:yb_news/app/extentions/opacity_extention.dart';

class AppButton extends StatelessWidget {
  final String? label;
  final VoidCallback? onPressed;

  final bool isLoading;
  final bool disabled;
  final bool isOutline;
  final bool isFullWidth;

  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? shadowColor;

  final double borderRadius;
  final double height;
  final double? width;
  final double elevation;

  final Widget? icon;
  final bool iconRight;
  final EdgeInsetsGeometry? padding;

  const AppButton({
    super.key,
    this.label,
    required this.onPressed,
    this.isLoading = false,
    this.disabled = false,
    this.isOutline = false,
    this.isFullWidth = true,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.shadowColor,
    this.borderRadius = 6,
    this.height = 50,
    this.width,
    this.elevation = 2,
    this.icon,
    this.iconRight = false,
    this.padding,
  });

  bool get _isDisabled => disabled || isLoading || onPressed == null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = backgroundColor ?? theme.primaryColor;
    final contentColor = textColor ?? (isOutline ? primaryColor : Colors.white);

    Widget buttonChild = _buildButton(context, primaryColor, contentColor);

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: isFullWidth
            ? double.infinity
            : width.isNotNullOrEmpty
            ? width!
            : 0,
        minHeight: height,
        maxHeight: height,
      ),
      child: buttonChild,
    );
  }

  Widget _buildButton(
    BuildContext context,
    Color primaryColor,
    Color contentColor,
  ) {
    final theme = Theme.of(context);

    final style = ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return theme.disabledColor.opacityx(0.12);
        }
        return isOutline ? Colors.transparent : primaryColor;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return theme.disabledColor;
        return contentColor;
      }),
      elevation: WidgetStateProperty.all(
        _isDisabled ? 0 : (isOutline ? 0 : elevation),
      ),
      shadowColor: WidgetStateProperty.all(
        shadowColor ?? primaryColor.opacityx(0.5),
      ),
      padding: WidgetStateProperty.all(
        padding ?? const EdgeInsets.symmetric(horizontal: 24),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      side: isOutline
          ? WidgetStateProperty.resolveWith((states) {
              final color = states.contains(WidgetState.disabled)
                  ? theme.disabledColor
                  : (borderColor ?? primaryColor);
              return BorderSide(color: color, width: 1.5);
            })
          : null,
    );

    return ElevatedButton(
      onPressed: _isDisabled ? null : onPressed,
      style: style,
      child: _buildChild(contentColor),
    );
  }

  Widget _buildChild(Color color) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      );
    }

    return Row(
      spacing: 4,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null && !iconRight) ...[icon!],
        if (label.isNotNullOrEmpty) ...[
          AppText(
            label!,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ],

        if (icon != null && iconRight) ...[icon!],
      ],
    );
  }
}
