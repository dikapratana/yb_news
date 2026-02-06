part of 'top_news_bloc.dart';

@immutable
sealed class TopNewsEvent {}

class LoadTopNews extends TopNewsEvent {
  final int page;
  final int pageSize;

  LoadTopNews({this.page = 1, this.pageSize = 50});
}

class LoadMoreTopNews extends TopNewsEvent {
  final int pageSize;

  LoadMoreTopNews({this.pageSize = 10});
}
