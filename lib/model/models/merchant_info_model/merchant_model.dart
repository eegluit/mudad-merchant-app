import 'dart:convert';

MerchantDataModel? merchantDataModelFromJson(String str) => MerchantDataModel.fromJson(json.decode(str));

String merchantDataModelToJson(MerchantDataModel? data) => json.encode(data!.toJson());

class MerchantDataModel {
  MerchantDataModel({
    this.store,
    this.kyc,
  });

  final Store? store;
  final Kyc? kyc;

  factory MerchantDataModel.fromJson(Map<String, dynamic> json) => MerchantDataModel(
    store: Store.fromJson(json["store"]),
    kyc: Kyc.fromJson(json["kyc"]),
  );

  Map<String, dynamic> toJson() => {
    "store": store!.toJson(),
    "kyc": kyc!.toJson(),
  };
}

class Kyc {
  Kyc({
    this.idType,
    this.kycDoc,
    this.selfie,
  });

  final String? idType;
  final String? kycDoc;
  final String? selfie;

  factory Kyc.fromJson(Map<String, dynamic> json) => Kyc(
    idType: json["idType"],
    kycDoc: json["kycDoc"],
    selfie: json["selfie"],
  );

  Map<String, dynamic> toJson() => {
    "idType": idType,
    "kycDoc": kycDoc,
    "selfie": selfie,
  };
}

class Store {
  Store({
    this.userId,
    this.logo,
    this.name,
    this.address,
    this.lat,
    this.long,
    this.isDeleted,
    this.id,
  });

  final String? userId;
  final String? logo;
  final String? name;
  final String? address;
  final String? lat;
  final String? long;
  final bool? isDeleted;
  final String? id;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    userId: json["userId"],
    logo: json["logo"],
    name: json["name"],
    address: json["address"],
    lat: json["lat"],
    long: json["long"],
    isDeleted: json["isDeleted"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "logo": logo,
    "name": name,
    "address": address,
    "lat": lat,
    "long": long,
    "isDeleted": isDeleted,
    "id": id,
  };
}
