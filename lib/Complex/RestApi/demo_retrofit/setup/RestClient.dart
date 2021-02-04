import 'package:flutter_app/Complex/RestApi/demo_retrofit/setup/post_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

@RestApi(baseUrl: "http://www.json-generator.com/api/json/get/")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("/ceLGCumWjS?indent=2")
  Future<List<PostModel>> getTasks();
}
