import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:yb_news/app/core/components/card_news/large_card_news.dart';
import 'package:yb_news/app/core/components/card_news/large_card_news_skeleton.dart';
import 'package:yb_news/app/core/components/layout/main_layout.dart';
import 'package:yb_news/app/core/components/notfound/notfound.dart';
import 'package:yb_news/app/core/styles/app_colors.dart';
import 'package:yb_news/app/presentation/news/trending/bloc/top_news_bloc.dart';

class TrendingNewsPage extends HookWidget {
  const TrendingNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<TopNewsBloc>().add(LoadTopNews(page: 1));
      return null;
    }, []);

    return MainLayout(
      title: 'Trending',
      showBackButton: true,
      onBackPressed: () => context.pop(),
      appbar: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Icon(Icons.more_vert, size: 20, color: AppColors.neutral2),
        ),
      ],
      isScrollable: false,
      child: BlocBuilder<TopNewsBloc, TopNewsState>(
        builder: (context, state) {
          if (state is TopNewsLoading) {
            return ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: 5,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: const LargeCardNewsSkeleton(),
              ),
            );
          }

          if (state is TopNewsError) {
            return NotFound(message: state.message);
          }

          if (state is TopNewsLoaded) {
            if (state.articles.isEmpty) return const NotFound();

            return RefreshIndicator(
              onRefresh: () async {
                context.read<TopNewsBloc>().add(
                  LoadTopNews(page: 1, pageSize: 20),
                );
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  final article = state.articles[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: InkWell(
                      onTap: () {
                        final newsId = Uri.encodeComponent(article.title);
                        context.push('/news/detail/$newsId');
                      },
                      child: LargeCardNews(
                        title: article.title,
                        imageUrl: article.urlToImage ?? '',
                        category: article.source.name,
                        logoUrl: article.urlToImage ?? '',
                        publisher: article.source.name,
                        timeAgo: article.publishedAt != null
                            ? '${DateTime.now().difference(article.publishedAt!).inHours}h ago'
                            : 'Unknown',
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
