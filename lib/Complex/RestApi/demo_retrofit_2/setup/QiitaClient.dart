import 'package:retrofit/http.dart';

import 'QiitaArticle.dart';
import 'package:dio/dio.dart';
part 'QiitaClient.g.dart';

@RestApi (baseUrl :  "https://qiita.com/api" )
abstract  class  QiitaClient {
  factory  QiitaClient ( Dio dio, { String baseUrl}) =  _QiitaClient ;

  @GET("/v2/items")
  Future<List<QiitaArticle>> fetchItems(
      @Field("page") int page,
      @Field("per_page") int perPage,
      @Field("query") String query);
}
