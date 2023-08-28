import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/utils/resource/image_resource.dart';

import '/../../model/utils/resource/color_resource.dart';
import '/../../model/utils/resource/dimensions_resource.dart';
import '/../../model/utils/resource/style_resource.dart';
import '/../../view_model/controllers/verification_controller/verification_conroller.dart';

class SelfieWidget extends GetView<VerificationController> {
  const SelfieWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
            () {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensionResource.marginSizeLarge,
                  //vertical: DimensionResource.marginSizeExtraSmall
                ),
                child: Text(
                  controller.verifyPageDataList[controller.currentStep.value-1].subTitle,
                  style: StyleResource.instance
                      .styleMedium(DimensionResource.fontSizeExtraLarge,
                      ColorResource.secondColor)
                      .copyWith(height: 1.7, letterSpacing: .5),
                  textAlign: TextAlign.center,
                ),
              ),
              // const SizedBox(
              //   height: DimensionResource.margiLarge,
              // ),
              Container(
                height: Get.height*0.4,
                width: Get.width*0.6,
                margin: const EdgeInsets.only(top: 20, left: 40, right: 40),
                decoration: const BoxDecoration(
                  borderRadius:  BorderRadius.all(Radius.elliptical(170,220)),
                ),
                child: controller.selectSelfie.value.path == ""? ClipRRect(borderRadius: const BorderRadius.all(Radius.elliptical(170,220)),child: Container(color: ColorResource.lineGreyColor,padding:const EdgeInsets.all(10),child: Image.asset(ImageResource.instance.ovalImage))):ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.elliptical(170,220)),
                    child: Image.file(controller.selectSelfie.value,fit: BoxFit.cover,)),
              )
            ],
          );
        }
    );
  }
}