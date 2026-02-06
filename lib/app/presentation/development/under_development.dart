import 'package:flutter/material.dart';
import 'package:yb_news/app/core/components/layout/main_layout.dart';
import 'package:yb_news/app/core/components/typography/app_text.dart';
import 'package:yb_news/app/extentions/opacity_extention.dart';
import 'package:yb_news/app/extentions/space_extention.dart';

class UnderDevelopmentPage extends StatelessWidget {
  const UnderDevelopmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Under Development',

      appbar: true,
      isScrollable: false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.opacityx(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.construction_rounded,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
              ),

              32.h,

              AppText(
                'Coming Soon!',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),

              12.h,

              AppText(
                'We are currently working hard to bring this feature to you. Stay tuned!',
                fontSize: 14,
                color: Colors.grey,
              ),

              40.h,
            ],
          ),
        ),
      ),
    );
  }
}
