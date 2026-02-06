import 'package:flutter/material.dart';
import 'package:yb_news/app/core/components/layout/app_barx.dart';
import 'package:yb_news/app/core/styles/app_shadow_styles.dart';
import 'package:yb_news/app/extentions/empty_extention.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({
    super.key,
    required this.child,
    this.title = '',
    this.showBackButton = false,
    this.onBackPressed,
    this.canPop = true,
    this.actions,
    this.bottomButton,
    this.isScrollable = true,
    this.backgroundColor = Colors.white,
    this.appBarBackgroundColor = Colors.white,
    this.appBarElevation = 0,
    this.bottomNavigationBar,
    this.appbar,
  });

  final Widget child;
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool canPop;
  final List<Widget>? actions;
  final Widget? bottomButton;
  final bool isScrollable;
  final Color backgroundColor;
  final Color appBarBackgroundColor;
  final double appBarElevation;
  final Widget? bottomNavigationBar;

  final bool? appbar;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        if (onBackPressed != null) {
          onBackPressed!();
        } else {
          Navigator.of(context).maybePop();
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: appbar.isNotNullOrEmpty
            ? AppBarx(
                title: title,
                showBackButton: showBackButton,
                onBackPressed:
                    onBackPressed ?? () => Navigator.of(context).maybePop(),
                actions: actions,
                backgroundColor: appBarBackgroundColor,
                elevation: appBarElevation,
              )
            : null,
        body: SafeArea(child: _buildBody(context)),
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (bottomButton.isNotNullOrEmpty) {
      return Column(
        children: [
          Expanded(child: _buildContent(context)),
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              boxShadow: AppShadowStyles.softTop,
              color: Colors.white,
            ),
            child:
                bottomButton ??
                SizedBox(width: double.infinity, child: bottomButton),
          ),
        ],
      );
    }

    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    if (!isScrollable) {
      return child;
    }

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: child,
    );
  }
}
