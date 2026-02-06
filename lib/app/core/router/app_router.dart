import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yb_news/app/core/components/layout/home_layout.dart';
import 'package:yb_news/app/core/router/route_constants.dart';
import 'package:yb_news/app/presentation/auth/forgot_password/pages/forgot_password_page.dart';
import 'package:yb_news/app/presentation/auth/login/pages/login_page.dart';
import 'package:yb_news/app/presentation/auth/otp/pages/otp_page.dart';
import 'package:yb_news/app/presentation/auth/register/pages/register_page.dart';
import 'package:yb_news/app/presentation/auth/reset_password/pages/reset_password.dart';
import 'package:yb_news/app/presentation/development/under_development.dart';
import 'package:yb_news/app/presentation/home/pages/home_page.dart';
import 'package:yb_news/app/presentation/init/init_page.dart';
import 'package:yb_news/app/presentation/news/comments/pages/comment_page.dart';
import 'package:yb_news/app/presentation/news/detail/pages/detail_news_page.dart';
import 'package:yb_news/app/presentation/news/latest/bloc/news_bloc_bloc.dart';
import 'package:yb_news/app/presentation/news/latest/pages/latest_news_page.dart';
import 'package:yb_news/app/presentation/news/trending/bloc/top_news_bloc.dart';
import 'package:yb_news/app/presentation/news/trending/pages/trending_news_page.dart';
import 'package:yb_news/app/repositories/news/news_repositories.dart';

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

CustomTransitionPage slidePageBuilder({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeInOut)),
        ),
        child: child,
      );
    },
  );
}

CustomTransitionPage fadePageBuilder({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

final goRouter = GoRouter(
  initialLocation: RouteConstant.splash,
  routes: [
    GoRoute(
      path: RouteConstant.splash,
      pageBuilder: (context, state) =>
          slidePageBuilder(state: state, child: const InitPage()),
    ),
    GoRoute(
      path: RouteConstant.login,
      pageBuilder: (context, state) =>
          slidePageBuilder(state: state, child: const LoginPage()),
    ),
    GoRoute(
      path: RouteConstant.register,
      pageBuilder: (context, state) =>
          slidePageBuilder(state: state, child: const RegisterPage()),
    ),
    GoRoute(
      path: RouteConstant.forgotPassword,
      pageBuilder: (context, state) =>
          slidePageBuilder(state: state, child: const ForgotPasswordPage()),
    ),
    GoRoute(
      path: RouteConstant.otpVerification,
      pageBuilder: (context, state) =>
          slidePageBuilder(state: state, child: const OtpPage()),
    ),
    GoRoute(
      path: RouteConstant.resetPassword,
      pageBuilder: (context, state) =>
          slidePageBuilder(state: state, child: const ResetPasswordPage()),
    ),

    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return HomeLayout(child: child);
      },
      routes: [
        GoRoute(
          path: RouteConstant.home,
          pageBuilder: (context, state) => fadePageBuilder(
            state: state,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      NewsBlocBloc(repository: NewsRepository())
                        ..add(FetchNewsEvent()),
                ),
                BlocProvider(
                  create: (context) =>
                      TopNewsBloc(repository: NewsRepository())
                        ..add(LoadTopNews()),
                ),
              ],
              child: const HomePage(),
            ),
          ),
        ),
        GoRoute(
          path: '/explore',
          pageBuilder: (context, state) => fadePageBuilder(
            state: state,
            child: const UnderDevelopmentPage(),
          ),
        ),
        GoRoute(
          path: '/bookmark',
          pageBuilder: (context, state) => fadePageBuilder(
            state: state,
            child: const UnderDevelopmentPage(),
          ),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) => fadePageBuilder(
            state: state,
            child: const UnderDevelopmentPage(),
          ),
        ),

        GoRoute(
          path: RouteConstant.newsTrending,
          pageBuilder: (context, state) => slidePageBuilder(
            state: state,
            child: BlocProvider(
              create: (context) =>
                  TopNewsBloc(repository: NewsRepository())..add(LoadTopNews()),
              child: const TrendingNewsPage(),
            ),
          ),
        ),
        GoRoute(
          path: RouteConstant.newsLatest,
          pageBuilder: (context, state) => slidePageBuilder(
            state: state,
            child: BlocProvider(
              create: (context) =>
                  NewsBlocBloc(repository: NewsRepository())
                    ..add(FetchNewsEvent()),
              child: const LatestNewsPage(),
            ),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '${RouteConstant.detailNews}/:id', // Tambahkan /:id
      pageBuilder: (context, state) {
        // Ambil parameter id dari URL
        final id = state.pathParameters['id'] ?? '';

        return slidePageBuilder(
          state: state,
          child: BlocProvider(
            create: (context) =>
                NewsBlocBloc(repository: NewsRepository())
                  ..add(FetchNewsEvent()),
            child: DetailNewsPage(id: id),
          ), // Kirim ID ke constructor page
        );
      },
    ),
    GoRoute(
      path: RouteConstant.commentNews,
      pageBuilder: (context, state) =>
          slidePageBuilder(state: state, child: CommentPage()),
    ),
  ],
);
