import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import 'package:yb_news/app/core/components/card_news/large_card_news.dart';
import 'package:yb_news/app/core/components/card_news/large_card_news_skeleton.dart';
import 'package:yb_news/app/core/components/card_news/small_card_news.dart';
import 'package:yb_news/app/core/components/card_news/small_card_news_skeleton.dart';
import 'package:yb_news/app/core/components/form/text_field/reactive_text_field.dart';
import 'package:yb_news/app/core/components/notfound/notfound.dart';
import 'package:yb_news/app/core/components/typography/app_text.dart';
import 'package:yb_news/app/core/router/route_constants.dart';
import 'package:yb_news/app/core/styles/app_shadow_styles.dart';

import 'package:yb_news/app/core/hooks/use_debounce_search.dart';

import 'package:yb_news/app/extentions/opacity_extention.dart';
import 'package:yb_news/app/extentions/space_extention.dart';

import 'package:yb_news/app/presentation/news/latest/bloc/news_bloc_bloc.dart';
import 'package:yb_news/app/presentation/news/trending/bloc/top_news_bloc.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final search = useDebounceSearch(milliseconds: 500);

    final scrollController = useScrollController();
    final isScrolled = useState(false);

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
          pageSize: 10,
          query: search.value,
          category: selectedCategory.value == 'All'
              ? ''
              : selectedCategory.value,
        ),
      );
    }

    useEffect(() {
      context.read<TopNewsBloc>().add(LoadTopNews(page: 1, pageSize: 1));
      loadNews();
      return null;
    }, []);

    useEffect(() {
      loadNews();
      return null;
    }, [search.value]);

    Future<void> onRefresh(BuildContext context) async {
      context.read<TopNewsBloc>().add(LoadTopNews(page: 1, pageSize: 1));
      loadNews();
      await Future.delayed(const Duration(milliseconds: 300));
    }

    Widget buildCategoryTabs() {
      return SizedBox(
        height: 36,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          separatorBuilder: (_, _) => const SizedBox(width: 20),
          itemBuilder: (context, index) {
            final cat = categories[index];
            final isActive = cat == selectedCategory.value;

            return InkWell(
              onTap: () {
                selectedCategory.value = cat;
                loadNews();
              },
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

    return Column(
      children: [
        16.h,

        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(
              bottom: BorderSide(
                color: isScrolled.value
                    ? Colors.grey.opacityx(0.2)
                    : Colors.transparent,
                width: 1,
              ),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: AppShadowStyles.soft,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.notifications_none),
                  ),
                ],
              ),
              16.h,
              ReactiveTextFieldX(
                formControl: search.control,
                contentPadding: const EdgeInsets.all(10),
                hint: 'Search...',
                prefix: const Icon(Icons.search, size: 18),
                suffix: const Icon(Icons.tune),
              ),
            ],
          ),
        ),

        Expanded(
          child: RefreshIndicator(
            onRefresh: () => onRefresh(context),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    if (search.value.isEmpty) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            'Trending',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          InkWell(
                            onTap: () =>
                                context.push(RouteConstant.newsTrending),
                            child: AppText('See all', fontSize: 14),
                          ),
                        ],
                      ),
                      16.h,
                      BlocBuilder<TopNewsBloc, TopNewsState>(
                        builder: (context, state) {
                          if (state is TopNewsLoading) {
                            return const LargeCardNewsSkeleton();
                          }
                          if (state is TopNewsError) {
                            return NotFound(message: state.message);
                          }
                          if (state is TopNewsLoaded &&
                              state.articles.isEmpty) {
                            return NotFound(title: 'empty data');
                          }
                          if (state is TopNewsLoaded &&
                              state.articles.isNotEmpty) {
                            final article = state.articles.first;

                            return InkWell(
                              onTap: () {
                                final newsId = Uri.encodeComponent(
                                  article.title,
                                );
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
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                      24.h,
                    ],

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          search.value.isNotEmpty
                              ? 'Search News "${search.value}"'
                              : 'Latest',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        if (search.value.isEmpty)
                          InkWell(
                            onTap: () => context.push(RouteConstant.newsLatest),
                            child: AppText('See all', fontSize: 14),
                          ),
                      ],
                    ),

                    12.h,

                    buildCategoryTabs(),

                    16.h,

                    BlocBuilder<NewsBlocBloc, NewsBlocState>(
                      builder: (context, state) {
                        if (state is NewsLoading) {
                          return Column(
                            children: List.generate(10, (index) {
                              return const Padding(
                                padding: EdgeInsets.only(bottom: 16),
                                child: SmallCardNewsSkeleton(),
                              );
                            }),
                          );
                        }

                        if (state is NewsError) {
                          return NotFound(message: state.message);
                        }

                        if (state is NewsLoaded) {
                          if (state.articles.isEmpty &&
                              search.value.isNotEmpty) {
                            return NotFound();
                          }

                          if (state.articles.isEmpty) {
                            return NotFound(title: 'empty data');
                          }

                          return Column(
                            children: List.generate(state.articles.length, (
                              index,
                            ) {
                              final article = state.articles[index];

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: InkWell(
                                  onTap: () {
                                    final newsId = Uri.encodeComponent(
                                      article.title,
                                    );
                                    context.push('/news/detail/$newsId');
                                  },
                                  child: SmallCardNews(
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
                            }),
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
