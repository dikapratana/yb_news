import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:yb_news/app/presentation/news/models/news_model.dart';
import 'package:yb_news/app/repositories/news/news_repositories.dart';

part 'top_news_event.dart';
part 'top_news_state.dart';

class TopNewsBloc extends Bloc<TopNewsEvent, TopNewsState> {
  final NewsRepository repository;

  TopNewsBloc({required this.repository}) : super(TopNewsInitial()) {
    on<LoadTopNews>(_onLoadTopNews);
    on<LoadMoreTopNews>(_onLoadMoreTopNews);
  }

  Future<void> _onLoadTopNews(
    LoadTopNews event,
    Emitter<TopNewsState> emit,
  ) async {
    emit(TopNewsLoading());

    try {
      final response = await repository.getTopNews(
        page: event.page,
        pageSize: event.pageSize,
      );

      emit(
        TopNewsLoaded(
          articles: response.articles,
          page: event.page,
          pageSize: event.pageSize,
          hasMore: response.articles.length >= event.pageSize,
        ),
      );
    } catch (e) {
      emit(TopNewsError(e.toString()));
    }
  }

  Future<void> _onLoadMoreTopNews(
    LoadMoreTopNews event,
    Emitter<TopNewsState> emit,
  ) async {
    final currentState = state;

    if (currentState is! TopNewsLoaded) return;
    if (!currentState.hasMore) return;

    try {
      final nextPage = currentState.page + 1;

      final response = await repository.getTopNews(
        page: nextPage,
        pageSize: event.pageSize,
      );

      final updatedArticles = [...currentState.articles, ...response.articles];

      emit(
        currentState.copyWith(
          articles: updatedArticles,
          page: nextPage,
          hasMore: response.articles.length >= event.pageSize,
        ),
      );
    } catch (e) {
      emit(TopNewsError(e.toString()));
    }
  }
}
