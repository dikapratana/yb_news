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
    this.onBackPressed, // Fungsi kustom untuk tombol back
    this.canPop =
        true, // Default true, set false jika ingin cegah back hardware
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
  final bool canPop; // Tambahkan ini
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

        // Jika canPop false, jalankan fungsi onBackPressed kustom
        if (onBackPressed != null) {
          onBackPressed!();
        } else {
          // Default fallback jika tidak ada onBackPressed kustom
          Navigator.of(context).maybePop();
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: appbar.isNotNullOrEmpty
            ? AppBarx(
                title: title,
                showBackButton: showBackButton,
                // Samakan logic tombol di AppBar dengan hardware back
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
