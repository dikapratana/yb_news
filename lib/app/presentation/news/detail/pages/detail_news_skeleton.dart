import 'package:flutter/material.dart';
import 'package:yb_news/app/extentions/space_extention.dart';

class DetailNewsSkeleton extends StatelessWidget {
  const DetailNewsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Skeleton Header (Source & Time)
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  8.h,
                  Container(
                    width: 80,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ],
          ),
          16.h,
          // Skeleton Image
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          16.h,
          // Skeleton Source Category
          Container(
            width: 100,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          8.h,
          // Skeleton Title
          Container(
            width: double.infinity,
            height: 22,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          6.h,
          Container(
            width: double.infinity,
            height: 22,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          4.h,
          Container(
            width: 200,
            height: 22,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          16.h,
          // Skeleton Content (Body Text)
          ...List.generate(6, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: index == 5 ? 150 : double.infinity,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
