import 'dart:convert';

UserDataModel? userDataModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel? data) => json.encode(data!.toJson());

class UserDataModel {
  UserDataModel({
    this.user,
    this.token,
  });

  final User? user;
  final Token? token;

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    user: User.fromJson(json["user"]),
    token: Token.fromJson(json["token"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user!.toJson(),
    "token": token!.toJson(),
  };
}

class Token {
  Token({
    this.access,
    this.refresh,
  });

  final Access? access;
  final Access? refresh;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    access: Access.fromJson(json["access"]),
    refresh: Access.fromJson(json["refresh"]),
  );

  Map<String, dynamic> toJson() => {
    "access": access!.toJson(),
    "refresh": refresh!.toJson(),
  };
}

class Access {
  Access({
    this.token,
    this.expires,
  });

  final String? token;
  final DateTime? expires;

  factory Access.fromJson(Map<String, dynamic> json) => Access(
    token: json["token"],
    expires: DateTime.parse(json["expires"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "expires": expires?.toIso8601String(),
  };
}

class User {
  User({
    this.isDeleted,
    this.role,
    this.isEmailVerified,
    this.name,
    this.email,
    this.id,
    this.isKyc,
    this.mobile,
    this.storeRegistered,
  });

  final bool? isDeleted;
  final String? role;
  final bool? isEmailVerified;
  final String? name;
  final String? email;
  final String? id;
  final String? mobile;
  final bool? isKyc;
  final bool? storeRegistered;

  factory User.fromJson(Map<String, dynamic> json) => User(
    isDeleted: json["isDeleted"],
    role: json["role"],
    isEmailVerified: json["isEmailVerified"],
    name: json["name"],
    email: json["email"],
    id: json["id"],
    isKyc: json["isKyc"],
    mobile: json["mobile"],
    storeRegistered: json["storeRegistered"],
  );

  Map<String, dynamic> toJson() => {
    "isDeleted": isDeleted,
    "role": role,
    "isEmailVerified": isEmailVerified,
    "name": name,
    "email": email,
    "id": id,
    "mobile": mobile,
    "isKyc": isKyc,
    "storeRegistered": storeRegistered,
  };
}
