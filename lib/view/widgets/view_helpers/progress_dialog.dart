import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/utils/resource/color_resource.dart';

class ProgressDialog {
  bool isDialogShowing = false;

  ProgressDialog();

  Future<void> showProgressDialog() async {
    isDialogShowing = true;
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              color: ColorResource.mainColor,
              strokeWidth: 2,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> closeProgressDialog() async {
    if (isDialogShowing) {
      Navigator.of(Get.overlayContext!).pop();
    }
  }
}

