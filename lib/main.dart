import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'model/network_calls/dio_client/get_it_instance.dart';
import 'model/services/auth_service.dart';
import 'model/services/globleService.dart';
import 'model/utils/language/language_manager.dart';
import 'view/widgets/error_show/error_show.dart';
import 'view_model/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mudad Partner",
      builder: kDebugMode ? (BuildContext context, Widget? widget) {
        return responsiveScreen(context, widget);
      } : (BuildContext context, Widget? widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return ErrorMessage(errorDetails: errorDetails);
        };
        return responsiveScreen(context, widget);
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      translations: LanguageManager.instance.translationLocalStrings,
      locale: LanguageManager.instance.enLocale,
      supportedLocales: LanguageManager.instance.supportedLocales,
      getPages: AppPages.routes,
      initialRoute:Get.find<AuthService>().user.value.name!=null?Get.find<AuthService>().user.value.isKyc!=null && Get.find<AuthService>().user.value.isKyc==true?Get.find<AuthService>().user.value.storeRegistered!=null&&Get.find<AuthService>().user.value.storeRegistered==true?Routes.rootView:Routes.storeRegistrationScreen:Routes.verificationScreen:Routes.loginScreen,
      defaultTransition: Transition.circularReveal,
    ));
  });
}

initServices() async {
  Get.log('starting services ...');
  await GetStorage.init();
  await getInit();
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => GlobalService().init());
  Get.log('All services started...');
  return;
}

Widget responsiveScreen(context, widget) {
  return ResponsiveWrapper.builder(
      BouncingScrollWrapper.builder(context, widget!),
      maxWidth: 2400,
      minWidth: 450,
      defaultScale: true,
      breakpoints: [
        const ResponsiveBreakpoint.resize(600, name: MOBILE),
        const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
        const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
        const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
      ],
      background: Container(color: const Color(0xFFF5F5F5)));
}
