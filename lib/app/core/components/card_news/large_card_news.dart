import 'package:flutter/material.dart';
import 'package:yb_news/app/core/components/image/imagex.dart';
import 'package:yb_news/app/core/components/typography/app_text.dart';
import 'package:yb_news/app/core/styles/app_colors.dart';
import 'package:yb_news/app/extentions/space_extention.dart';

class LargeCardNews extends StatelessWidget {
  const LargeCardNews({
    super.key,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.logoUrl,
    required this.publisher,
    required this.timeAgo,
    this.onTap,
  });

  final String imageUrl;
  final String category;
  final String title;
  final String logoUrl;
  final String publisher;
  final String timeAgo;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ImageX(
              imageUrl: imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          AppText(category, fontSize: 13, color: AppColors.neutral2),
          const SizedBox(height: 4),
          AppText(
            title,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            maxLines: 2,
            color: AppColors.neutral1,
          ),
          8.h,
          Row(
            children: [
              CircleAvatar(radius: 10, backgroundImage: NetworkImage(logoUrl)),
              const SizedBox(width: 8),
              AppText(
                publisher,
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: AppColors.neutral1,
              ),
              const SizedBox(width: 12),
              const Icon(Icons.access_time, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              AppText(timeAgo, fontSize: 12, color: Colors.grey),
              const Spacer(),
              const Icon(Icons.more_horiz, size: 20, color: AppColors.neutral2),
            ],
          ),
        ],
      ),
    );
  }
}
