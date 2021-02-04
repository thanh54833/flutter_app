import 'params.dart';

class PostModel {
  String jsonrpc;
  String id;
  String method;
  Params params;

  PostModel({this.jsonrpc, this.id, this.method, this.params});

  PostModel.fromJson(dynamic json) {
    jsonrpc = json["jsonrpc"];
    id = json["id"];
    method = json["method"];
    params = json["params"] != null ? Params.fromJson(json["params"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["jsonrpc"] = jsonrpc;
    map["id"] = id;
    map["method"] = method;
    if (params != null) {
      map["params"] = params.toJson();
    }
    return map;
  }
}
