class StoreRegisterResponseModel {
  bool? isDeleted;
  String? userId;
  String? logo;
  String? name;
  String? address;
  String? lat;
  String? long;
  String? id;
  String? message;
  int? code;

  StoreRegisterResponseModel({this.isDeleted, this.userId,this.logo, this.name,this.address, this.lat,this.long, this.id, this.code, this.message});

  StoreRegisterResponseModel.fromJson(Map<String, dynamic> json) {
     isDeleted = json["isDeleted"];
    userId = json["userId"];
     logo = json["logo"];
    name = json["name"];
     address = json["address"];
    code = json["lat"];
     message = json["long"];
    code = json["id"];
    message = json["message"];
    code = json["code"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["isDeleted"] = isDeleted;
    map["userId"] = userId;
    map["logo"] = logo;
    map["name"] = name;
    map["address"] = address;
    map["lat"] = code;
    map["long"] = message;
    map["id"] = code;
    map["message"] = message;
    map["code"] = code;
    return map;
  }
}
