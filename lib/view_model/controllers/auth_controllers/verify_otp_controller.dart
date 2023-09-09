import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_document_reader_api/document_reader.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/view_model/routes/app_pages.dart';

import '../../../model/models/user_model/user_model.dart';
import '../../../model/network_calls/api_helper/provider_helper/auth_provider.dart';

import '../../../model/network_calls/dio_client/get_it_instance.dart';
import '../../../model/services/auth_service.dart';
import '../../../view/widgets/log_print/log_print_condition.dart';
import '../../../view/widgets/toast_view/showtoast.dart';

class VerifyOtpController extends GetxController {
  Map<String, dynamic> backData = {};
  AuthProvider authProvider = getIt();
  Rx<TextEditingController> otpController = TextEditingController().obs;

  Timer? timer;
  RxInt start = 30.obs;
  var isLoading = false.obs;
  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      backData = Get.arguments;
    }
    logPrint("Initializing...");
    ByteData byteData = await rootBundle.load("assets/regula.license");

    DocumentReader.initializeReader({
      "license": base64.encode(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)),
      "delayedNNLoad": true
    }).then((s) {
      log(s);
      //isInitialise.value = true;
    }).catchError((Object error) async {
      logPrint((error as PlatformException).message ?? "");
      logPrint("error rer ${(error as PlatformException).message ?? ""}");
    });
    startTimer();
    super.onInit();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  VoidCallback get startTimer => () {
        logPrint("start time");
        const oneSec = Duration(seconds: 1);
        timer = Timer.periodic(
          oneSec,
          (Timer timer) {
            if (start.value == 0) {
              timer.cancel();
            } else {
              start--;
            }
          },
        );
      };
  VoidCallback get resendOtp => () async {
        if (start.value == 0) {
          start.value = 30;
          try {
            await authProvider.resendOtpTap(onError: (errorMessage) {
              logPrint("errorMessage=> $errorMessage");
              toastShow(massage: errorMessage, error: true);
              isLoading.value = false;
            }, onSuccess: (message, data) async {
              startTimer();
              otpController.value.clear();
              toastShow(
                  massage: "Otp has been sent on your email", error: false);
            });
          } catch (e) {
            logPrint("this is login try error ${e.toString()}");
            toastShow(massage: "Something want wrong here.", error: true);
          }
        }
      };

  VoidCallback get checkOtp => () async {
        if (otpController.value.text.isEmpty) {
          toastShow(massage: "please enter otp", error: true);
        } else if (otpController.value.text.length != 4) {
          toastShow(massage: "please enter valid otp", error: true);
        } else {
          if (isLoading.value == false) {
            isLoading.value = true;
            try {
              Map<String, String> otpData = {
                "otp": otpController.value.text,
              };
              await authProvider.otpVerifyTap(otpData, onError: (errorMessage) {
                logPrint("errorMessage=> $errorMessage");
                toastShow(
                    massage: errorMessage ?? "Please check your otp.",
                    error: true);
                isLoading.value = false;
              }, onSuccess: (message, data) async {
                try {
                  UserDataModel userDataModel = UserDataModel.fromJson(data!);
                  logPrint("data=>$data ${userDataModel.user} ");
                  await Get.find<AuthService>().saveUser(data["user"]);
                  await Get.find<AuthService>()
                      .saveUserToken(userDataModel.token!.access!.token ?? "");
                  await Get.find<AuthService>()
                      .saveUserId(userDataModel.user?.id ?? "");
                  toastShow(
                      massage: "You are login successfully", error: false);
                  Get.find<AuthService>().user.value.isKyc != null &&
                          Get.find<AuthService>().user.value.isKyc == true
                      ? Get.find<AuthService>().user.value.storeRegistered !=
                                  null &&
                              Get.find<AuthService>()
                                      .user
                                      .value
                                      .storeRegistered ==
                                  true
                          ? Get.offAllNamed(Routes.rootView)
                          : Get.offAllNamed(Routes.storeRegistrationScreen)
                      : Get.offAllNamed(Routes.verificationScreen);
                  isLoading.value = false;
                } catch (e) {
                  logPrint(e.toString());
                  toastShow(massage: e.toString(), error: true);
                  isLoading.value = false;
                }
              });
            } catch (e) {
              logPrint("this is verify try error ${e.toString()}");
              toastShow(massage: "Something want wrong here.", error: true);
              isLoading.value = false;
            }
          }
        }
      };
}
