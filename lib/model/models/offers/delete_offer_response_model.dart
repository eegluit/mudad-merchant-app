
class DeleteOfferResponseModel {
  String? result;
  int? code;
  String? successMessage;
  String? errorMessage;

  DeleteOfferResponseModel(
      {this.result, this.code, this.successMessage, this.errorMessage});
  DeleteOfferResponseModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    code = json['code'];
    successMessage = json['successMessage'];
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = code;
    map["successMessage"] = successMessage;
    map["errorMessage"] = errorMessage;
    map["result"] = result;
    return map;
  }
}