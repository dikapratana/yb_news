part of 'news_bloc_bloc.dart';

@immutable
sealed class NewsBlocState {}

final class NewsInitial extends NewsBlocState {}

final class NewsLoading extends NewsBlocState {}

final class NewsLoaded extends NewsBlocState {
  final List<Article> articles;
  NewsLoaded(this.articles);
}

final class NewsError extends NewsBlocState {
  final String message;
  NewsError(this.message);
}
