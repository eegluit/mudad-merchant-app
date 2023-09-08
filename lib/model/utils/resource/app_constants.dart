class AppConstants {
  static AppConstants? _instance;
  static AppConstants get instance => _instance ??= AppConstants._init();
  AppConstants._init();

  ///Mobil Language
  String get mobileLanguage => "en_Us";

  ///default theme
  String get defaultTheme => "light";

  /// base url
  String get baseUrl => 'http://44.203.153.253:3000/v1/';

  String get baseUrlUpdated => 'https://madadoffer.azurewebsites.net/api/';

  /// auth
  String get authUrl => '${baseUrl}auth/';
  String get registerUrl => '${authUrl}register';
  String get loginUrl => '${authUrl}login';
  String get otpVerifyUrl => '${authUrl}verify-otp';
  String get resendOtpUrl => '${authUrl}resend-otp';

  /// kyc
  String get kycUrl => '${baseUrl}kyc/';
  String get verifyIdentityUrl => '${kycUrl}add-id-type';
  String get uploadIdProofUrl => '${kycUrl}upload-document';
  String get selfieUploadUrl => '${kycUrl}upload-selfie';

  /// kyc
  String get storeUrl => '${baseUrl}stores/';
  String get storeRegistrationUrl => '${storeUrl}register';

  /// user data
  String get userUrl => '${baseUrl}users/';
  String get userProfileUrl => '${userUrl}get-user-personal-info';
  String get getMerchantInfoUrl => '${userUrl}get-merchant-info';
  String get updateUserPersonalInfoUrl => '${userUrl}update-user-personal-info';

  // Offer
  String get createOffer => '${baseUrlUpdated}Offer/';
  String get getOffer => '${baseUrlUpdated}offer/';
}
