class CreateOfferRequestModel {
 
  String couponCode;
  int discount;
  String discountType;
  String validFrom;
  String validTo;
  int NumberOfTime;
  String Description;
  String UserId;

  CreateOfferRequestModel({
    required this.couponCode,
    required this.discount,
    required this.discountType,
    required this.validFrom,
    required this.validTo,
    required this.NumberOfTime,
    required this.Description,
    required this.UserId,
  });

  Map<String, dynamic> toJson() {
    return {
      'couponCode': couponCode,
      'discount': discount,
      'discountType': discountType,
      'validFrom': validFrom,
      'validTo': validTo,
      'NumberOfTime': NumberOfTime,
      'Description': Description,
      'UserId': UserId,
    };
  }
}