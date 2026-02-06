import 'package:flutter/material.dart';
import 'package:yb_news/app/core/components/image/imagex.dart';
import 'package:yb_news/app/core/components/typography/app_text.dart';
import 'package:yb_news/app/core/styles/app_colors.dart';
import 'package:yb_news/app/extentions/space_extention.dart';

class SmallCardNews extends StatelessWidget {
  const SmallCardNews({
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
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ImageX(
                imageUrl: imageUrl,
                width: 96,
                height: 96,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(category, fontSize: 12, color: AppColors.neutral2),
                  const SizedBox(height: 4),
                  AppText(
                    title,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    maxLines: 2,
                    color: AppColors.neutral1,
                  ),
                  8.h,
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 8,
                              backgroundImage: NetworkImage(logoUrl),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: AppText(
                                publisher,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: AppColors.neutral1,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.access_time,
                              size: 12,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            AppText(
                              timeAgo,
                              fontSize: 11,
                              color: AppColors.neutral2,
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      const Icon(Icons.more_horiz, size: 18),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
