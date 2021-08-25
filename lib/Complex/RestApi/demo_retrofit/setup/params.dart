class Params {
  String? isolateId;

  Params({this.isolateId});

  Params.fromJson(dynamic json) {
    isolateId = json["isolateId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["isolateId"] = isolateId;
    return map;
  }

}