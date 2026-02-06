import 'package:flutter/material.dart';
import 'package:yb_news/app/core/components/typography/app_text.dart';
import 'package:yb_news/app/core/styles/app_colors.dart';
import 'package:yb_news/app/extentions/space_extention.dart';

class NotFound extends StatelessWidget {
  const NotFound({
    super.key,
    this.title = 'Data Not Found',
    this.message = '',
    this.image,
    this.icon = Icons.search_off,
    this.actionText,
    this.onAction,
  });

  final String title;
  final String message;

  final Widget? image;

  final IconData icon;

  final String? actionText;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            image ?? Icon(icon, size: 72, color: AppColors.neutral3),

            16.h,

            AppText(
              title,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              align: TextAlign.center,
            ),

            8.h,

            AppText(
              message,
              fontSize: 14,
              color: AppColors.neutral2,
              align: TextAlign.center,
            ),

            if (actionText != null) ...[
              16.h,
              ElevatedButton(onPressed: onAction, child: Text(actionText!)),
            ],
          ],
        ),
      ),
    );
  }
}
