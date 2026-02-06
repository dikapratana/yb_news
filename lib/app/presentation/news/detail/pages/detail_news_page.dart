import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:yb_news/app/core/components/layout/main_layout.dart';
import 'package:yb_news/app/core/components/notfound/notfound.dart';
import 'package:yb_news/app/core/components/typography/app_text.dart';
import 'package:yb_news/app/core/router/route_constants.dart';
import 'package:yb_news/app/core/styles/app_colors.dart';
import 'package:yb_news/app/extentions/space_extention.dart';
import 'package:yb_news/app/presentation/news/detail/pages/detail_news_skeleton.dart';
import 'package:yb_news/app/presentation/news/latest/bloc/news_bloc_bloc.dart';

class DetailNewsPage extends HookWidget {
  final String id;
  const DetailNewsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final decodedTitle = Uri.decodeComponent(id);

    useEffect(() {
      context.read<NewsBlocBloc>().add(
        FetchNewsEvent(query: '"$decodedTitle"', pageSize: 1),
      );
      return null;
    }, [id]);

    return MainLayout(
      showBackButton: true,
      onBackPressed: () => context.pop(),
      appbar: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Icon(Icons.share, size: 20, color: AppColors.neutral2),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Icon(Icons.more_vert, size: 20, color: AppColors.neutral2),
        ),
      ],
      bottomNavigationBar: _buildBottomAction(context),
      child: BlocBuilder<NewsBlocBloc, NewsBlocState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const DetailNewsSkeleton();
          }

          if (state is NewsError) {
            return NotFound(message: state.message);
          }

          if (state is NewsLoaded && state.articles.isNotEmpty) {
            final article = state.articles.first;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            article.source.name,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          AppText(
                            article.publishedAt != null
                                ? '${DateTime.now().difference(article.publishedAt!).inHours}h ago'
                                : 'Recent',
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                  16.h,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      article.urlToImage ??
                          'https://via.placeholder.com/400x250',
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  16.h,
                  AppText(
                    article.source.name,
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                    maxLines: 2,
                  ),
                  8.h,
                  AppText(
                    article.title,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.neutral1,
                    maxLines: 5,
                  ),
                  16.h,
                  AppText(
                    article.content ??
                        article.description ??
                        'No content available.',
                    fontSize: 14,
                    color: AppColors.neutral1,
                    align: TextAlign.justify,
                    maxLines: 1000,
                  ),
                  32.h,
                ],
              ),
            );
          }

          return const NotFound(title: 'News detail not found');
        },
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 1, color: Colors.grey.shade200),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _iconAction(Icons.favorite, '24.5k', Colors.pink.shade400),
                16.w,
                InkWell(
                  onTap: () => context.push(RouteConstant.commentNews),
                  child: _iconAction(
                    Icons.comment_outlined,
                    '1k',
                    AppColors.neutral2,
                  ),
                ),
              ],
            ),
            const Icon(Icons.bookmark_border),
          ],
        ),
      ),
    );
  }

  Widget _iconAction(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        4.w,
        AppText(label),
      ],
    );
  }
}
