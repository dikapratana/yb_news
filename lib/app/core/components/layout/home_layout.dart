import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:yb_news/app/core/components/layout/main_layout.dart';

import '../../../extentions/space_extention.dart';

import '../typography/app_text.dart';

class HomeLayout extends HookWidget {
  final Widget child;
  const HomeLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;

    final icons = [
      Icons.home_filled,
      Icons.explore,
      Icons.bookmark_border,
      Icons.account_circle_outlined,
    ];

    final labels = ["Home", "Explore", "Bookmark", "Profile"];
    final routes = ["/", "/explore", "/bookmark", "/profile"];

    final primary = Theme.of(context).primaryColor;

    return MainLayout(
      isScrollable: false,
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(width: 3, color: Colors.green.shade800),
            ),
          ),
          padding: const EdgeInsets.only(top: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(icons.length, (index) {
              final bool isSelected = routes[index] == "/"
                  ? location == "/"
                  : location.startsWith(routes[index]);

              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  if (!isSelected) {
                    context.go(routes[index]);
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                        begin: 1.0,
                        end: isSelected ? 1.12 : 1.0,
                      ),
                      duration: const Duration(milliseconds: 180),
                      builder: (context, scale, _) {
                        return Transform.scale(
                          scale: scale,
                          child: Icon(
                            icons[index],
                            size: 22,
                            color: isSelected ? primary : Colors.black54,
                          ),
                        );
                      },
                    ),
                    2.h,
                    AppText(
                      labels[index],
                      fontSize: 12,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                      color: isSelected ? primary : Colors.black54,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
      child: child,
    );
  }
}
