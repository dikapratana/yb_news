import 'package:dio/dio.dart';
import 'package:yb_news/app/core/constants/app_api.dart';
import 'package:yb_news/app/presentation/news/models/news_model.dart';

class NewsRepository {
  final Dio _dio = Dio();
  Future<NewsResponse> getNews({
    String? query,
    String? category,
    required int page,
    required int pageSize,
  }) async {
    final response = await _dio.get(
      AppApi.wpiUrl,
      queryParameters: {
        'country': 'us',
        'q': query,
        'page': page,
        'pageSize': pageSize,
        'category': category,
        'apiKey': AppApi.newsApiKey,
      },
    );

    return NewsResponse.fromJson(response.data);
  }

  Future<NewsResponse> getTopNews({
    required int page,
    required int pageSize,
  }) async {
    final res = await _dio.get(
      AppApi.wpiUrl,
      queryParameters: {
        'country': 'us',
        'page': page,
        'pageSize': pageSize,
        'apiKey': AppApi.newsApiKey,
      },
    );

    return NewsResponse.fromJson(res.data);
  }
}
