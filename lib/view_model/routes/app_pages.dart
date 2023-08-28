
import 'package:mudad_merchant/view/screens/auth_view/verify_otp_screen.dart';


import 'package:get/get.dart' ;
import 'package:mudad_merchant/view/screens/auth_view/store_registration_view/store_registration_view.dart';
import 'package:mudad_merchant/view/screens/root_view/home_view/qr_code_screen.dart';

import '../../view/screens/auth_view/forgot_password_screen.dart';
import '../../view/screens/auth_view/login_screen.dart';
import '../../view/screens/auth_view/register_screen.dart';
import '../../view/screens/auth_view/verification_view/verification_view.dart';
import '../../view/screens/root_view/my_offers_view/create_offers_view/create_offers_screen.dart';
import '../../view/screens/root_view/profile_view/change_password_view/change_password_screen.dart';
import '../../view/screens/root_view/profile_view/edit_profile_view/edit_profile_screen.dart';

import '../../view/screens/root_view/profile_view/kyc_view/kyc_screen.dart';
import '../../view/screens/root_view/profile_view/store_view_screen/store_view.dart';
import '../../view/screens/root_view/root_view.dart';
import '../../view/screens/root_view/transaction_view/view_all_transactions/view_all_transaction_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const initial =  Routes.rootView;
  static final routes = [
    /// auth view
    GetPage(name: Routes.loginScreen, page: ()=>LoginScreen()),
    GetPage(name: Routes.forgotPasswordScreen, page: ()=>const ForgotPasswordScreen()),
    GetPage(name: Routes.registerScreen, page: ()=>const RegisterScreen()),
    /// verification view
    GetPage(name: Routes.verificationScreen, page: ()=> const VerificationScreen()),
    GetPage(name: Routes.verifyOtpScreen, page: ()=>const VerifyOtpScreen()),
    ///store registration view
    GetPage(name: Routes.storeRegistrationScreen, page: ()=>const StoreRegistrationScreen()),
    /// root view
    GetPage(name: Routes.rootView, page: ()=>const RootView()),
    /// home view
    GetPage(name: Routes.createOffersScreen, page: ()=>const CreateOffersScreen()),
    GetPage(name: Routes.editProfileScreen, page: ()=>const EditProfileScreen()),
    GetPage(name: Routes.changePassword, page: ()=>const ChangePasswordScreen()),
    GetPage(name: Routes.viewAllTransactionScreen, page: ()=>const ViewAllTransactionScreen()),
    GetPage(name: Routes.kycInfoScreen, page: ()=>const KycInfoScreen()),
    GetPage(name: Routes.storeInfoScreen, page: ()=>const StoreInfoScreen()),
    GetPage(name: Routes.qrCodeScreen , page: ()=>const QrCodeScreen())
  ];
}
