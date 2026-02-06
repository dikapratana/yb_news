import 'package:flutter/material.dart';
import 'package:yb_news/app/extentions/space_extention.dart';

class LargeCardNewsSkeleton extends StatefulWidget {
  const LargeCardNewsSkeleton({super.key});

  @override
  State<LargeCardNewsSkeleton> createState() => _LargeCardNewsSkeletonState();
}

class _LargeCardNewsSkeletonState extends State<LargeCardNewsSkeleton>
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

  final Color base = Colors.grey.shade300;
  final Color highlight = Colors.grey.shade100;

  Widget box({
    required double width,
    required double height,
    double radius = 8,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        box(width: double.infinity, height: 200, radius: 12),

        const SizedBox(height: 8),

        box(width: 80, height: 14),

        const SizedBox(height: 6),

        box(width: double.infinity, height: 16),

        const SizedBox(height: 6),

        box(width: double.infinity, height: 16),

        10.h,

        Row(
          children: [
            box(width: 20, height: 20, radius: 20),

            const SizedBox(width: 8),

            box(width: 90, height: 14),

            const SizedBox(width: 12),

            box(width: 60, height: 14),

            const Spacer(),

            box(width: 22, height: 22, radius: 20),
          ],
        ),
      ],
    );
  }
}
