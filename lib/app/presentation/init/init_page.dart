import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yb_news/app/core/router/route_constants.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleStartup();
    });
  }

  Future<void> _handleStartup() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      context.go(RouteConstant.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [CircularProgressIndicator()],
        ),
      ),
    );
  }
}
