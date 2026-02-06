import 'package:flutter/material.dart';
import 'package:yb_news/app/extentions/space_extention.dart';

class SmallCardNewsSkeleton extends StatefulWidget {
  const SmallCardNewsSkeleton({super.key});

  @override
  State<SmallCardNewsSkeleton> createState() => _SmallCardNewsSkeletonState();
}

class _SmallCardNewsSkeletonState extends State<SmallCardNewsSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Color base = Colors.grey.shade300;
  Color highlight = Colors.grey.shade100;

  Widget box({
    required double width,
    required double height,
    double radius = 6,
  }) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, _) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: Color.lerp(base, highlight, controller.value),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // IMAGE
          box(width: 96, height: 96, radius: 8),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CATEGORY
                box(width: 60, height: 12),

                const SizedBox(height: 6),

                // TITLE LINE 1
                box(width: double.infinity, height: 14),

                const SizedBox(height: 6),

                // TITLE LINE 2
                box(width: double.infinity, height: 14),

                10.h,

                Row(
                  children: [
                    // LOGO
                    box(width: 16, height: 16, radius: 20),

                    const SizedBox(width: 6),

                    // PUBLISHER
                    box(width: 80, height: 12),

                    const Spacer(),

                    // TIME
                    box(width: 50, height: 12),

                    const SizedBox(width: 8),

                    // DOT MENU
                    box(width: 18, height: 18, radius: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
