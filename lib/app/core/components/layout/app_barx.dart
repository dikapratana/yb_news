import 'package:flutter/material.dart';
import 'package:yb_news/app/core/components/typography/app_text.dart';
import 'package:yb_news/app/core/styles/app_colors.dart';
import 'package:yb_news/app/extentions/empty_extention.dart';

class AppBarx extends StatelessWidget implements PreferredSizeWidget {
  const AppBarx({
    super.key,
    required this.title,
    required this.showBackButton,
    this.onBackPressed,
    this.actions,
    this.backgroundColor = Colors.white,
    this.elevation = 0,
  });

  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final Color backgroundColor;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      leadingWidth: 56,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? InkWell(
              onTap: onBackPressed,
              child: Icon(Icons.arrow_back, color: AppColors.neutral2),
            )
          : null,
      title: title.isNotNullOrEmpty
          ? AppText(
              title,
              color: AppColors.neutral1,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            )
          : null,
      centerTitle: true,
      actions: actions,
      scrolledUnderElevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
