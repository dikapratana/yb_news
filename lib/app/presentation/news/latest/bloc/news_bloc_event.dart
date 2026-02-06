part of 'news_bloc_bloc.dart';

@immutable
sealed class NewsBlocEvent {}

final class FetchNewsEvent extends NewsBlocEvent {
  final String query;
  final int page;
  final int pageSize;
  final String category;

  FetchNewsEvent({
    this.query = '',
    this.page = 1,
    this.pageSize = 10,
    this.category = '',
  });
}
