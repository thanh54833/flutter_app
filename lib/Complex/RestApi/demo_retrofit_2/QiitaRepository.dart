import 'package:flutter_app/Complex/RestApi/demo_retrofit_2/setup/QiitaArticle.dart';
import 'package:flutter_app/Complex/RestApi/demo_retrofit_2/setup/QiitaClient.dart';
import 'package:dio/dio.dart';


class QiitaRepository {
  final QiitaClient _client;

  QiitaRepository({QiitaClient client}) : _client = client ?? QiitaClient(Dio());

  Future<List<QiitaArticle>> fetchArticle(
      int page, int perPage, String query) async {
    return await _client
        .fetchItems(page, perPage, query)
        .then((value) => value)
        .catchError((e) {
      return [];
    });
  }
}

