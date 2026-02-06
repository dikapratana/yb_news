import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yb_news/app/presentation/news/models/news_model.dart';
import 'package:yb_news/app/repositories/news/news_repositories.dart';

part 'news_bloc_event.dart';
part 'news_bloc_state.dart';

class NewsBlocBloc extends Bloc<NewsBlocEvent, NewsBlocState> {
  final NewsRepository repository;

  NewsBlocBloc({required this.repository}) : super(NewsInitial()) {
    on<FetchNewsEvent>((event, emit) async {
      emit(NewsLoading());

      try {
        final news = await repository.getNews(
          query: event.query,
          page: event.page,
          pageSize: event.pageSize,
          category: event.category,
        );

        emit(NewsLoaded(news.articles));
      } catch (e) {
        emit(NewsError(e.toString()));
      }
    });
  }
}
