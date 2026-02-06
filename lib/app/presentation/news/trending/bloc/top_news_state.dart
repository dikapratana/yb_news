part of 'top_news_bloc.dart';

@immutable
sealed class TopNewsState {}

class TopNewsInitial extends TopNewsState {}

class TopNewsLoading extends TopNewsState {}

class TopNewsLoaded extends TopNewsState {
  final List<Article> articles;
  final int page;
  final int pageSize;
  final bool hasMore;

  TopNewsLoaded({
    required this.articles,
    required this.page,
    required this.pageSize,
    required this.hasMore,
  });

  TopNewsLoaded copyWith({
    List<Article>? articles,
    int? page,
    int? pageSize,
    bool? hasMore,
  }) {
    return TopNewsLoaded(
      articles: articles ?? this.articles,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class TopNewsError extends TopNewsState {
  final String message;
  TopNewsError(this.message);
}
