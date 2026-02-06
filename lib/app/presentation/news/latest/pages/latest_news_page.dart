import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:yb_news/app/core/components/card_news/small_card_news.dart';
import 'package:yb_news/app/core/components/card_news/small_card_news_skeleton.dart';
import 'package:yb_news/app/core/components/layout/main_layout.dart';
import 'package:yb_news/app/core/components/notfound/notfound.dart';
import 'package:yb_news/app/core/components/typography/app_text.dart';
import 'package:yb_news/app/core/styles/app_colors.dart';
import 'package:yb_news/app/presentation/news/latest/bloc/news_bloc_bloc.dart';

class LatestNewsPage extends HookWidget {
  const LatestNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      'All',
      'business',
      'entertainment',
      'general',
      'health',
      'science',
      'sports',
      'technology',
    ];

    final selectedCategory = useState('All');

    void loadNews() {
      context.read<NewsBlocBloc>().add(
        FetchNewsEvent(
          page: 1,
          pageSize: 20,
          category: selectedCategory.value == 'All'
              ? ''
              : selectedCategory.value,
        ),
      );
    }

    useEffect(() {
      loadNews();
      return null;
    }, [selectedCategory.value]);

    Widget buildCategoryTabs() {
      return Container(
        height: 36,
        margin: const EdgeInsets.only(bottom: 20),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          separatorBuilder: (_, _) => const SizedBox(width: 20),
          itemBuilder: (context, index) {
            final cat = categories[index];
            final isActive = cat == selectedCategory.value;

            return InkWell(
              onTap: () => selectedCategory.value = cat,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    cat,
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    color: isActive
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 20,
                    height: 3,
                    decoration: BoxDecoration(
                      color: isActive
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    return MainLayout(
      title: 'Latest',
      showBackButton: true,
      onBackPressed: () => context.pop(),
      appbar: true,
      isScrollable: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Icon(Icons.more_vert, size: 20, color: AppColors.neutral2),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            buildCategoryTabs(),

            Expanded(
              child: BlocBuilder<NewsBlocBloc, NewsBlocState>(
                builder: (context, state) {
                  if (state is NewsLoading) {
                    return ListView.separated(
                      itemCount: 10,
                      separatorBuilder: (_, _) => const SizedBox(height: 16),
                      itemBuilder: (context, index) =>
                          const SmallCardNewsSkeleton(),
                    );
                  }

                  if (state is NewsError) {
                    return Center(child: NotFound(message: state.message));
                  }

                  if (state is NewsLoaded) {
                    final articles = state.articles;

                    if (articles.isEmpty) {
                      return const Center(
                        child: NotFound(
                          title: 'No News Found',
                          message: 'Try selecting another category',
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async => loadNews(),
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: articles.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final article = articles[index];
                          return SmallCardNews(
                            title: article.title,
                            imageUrl:
                                article.urlToImage ??
                                'https://placehold.co/600x400',
                            category: article.source.name,
                            logoUrl:
                                article.urlToImage ??
                                'https://placehold.co/600x400',
                            publisher: article.source.name,
                            timeAgo: article.publishedAt != null
                                ? '${DateTime.now().difference(article.publishedAt!).inHours}h ago'
                                : 'Unknown',
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
