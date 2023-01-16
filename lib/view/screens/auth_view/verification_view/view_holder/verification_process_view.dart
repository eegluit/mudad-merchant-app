import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/utils/resource/image_resource.dart';

import '/../../model/utils/resource/color_resource.dart';
import '/../../model/utils/resource/dimensions_resource.dart';
import '/../../model/utils/resource/style_resource.dart';
import '/../../view_model/controllers/verification_controller/verification_conroller.dart';

class VerificationProcessWidget extends GetView<VerificationController> {
  const VerificationProcessWidget({Key? key}) : super(key: key);
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
                      ColorResource.mainColor)
                      .copyWith(height: 1.7, letterSpacing: .5),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: DimensionResource.marginSizeExtraLarge+20,
              ),
              Image.asset(controller.isVerified.value ? ImageResource.instance.checkCircleIcon:ImageResource.instance.rejectCircleIcon,height: 190,),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: DimensionResource.marginSizeLarge,
              //     //vertical: DimensionResource.marginSizeExtraSmall
              //   ),
              //   child: Text(
              //     controller.isVerified.value  ? "If you want to purchase items using your credit, we will need some additional information to calcualte your credit score." :"We couldnt capture your face. Watch out for poor lighting and blur",
              //     style: StyleResource.instance
              //         .styleMedium(DimensionResource.fontSizeExtraLarge,
              //         ColorResource.secondColor
              //     )
              //         .copyWith(height: 1.7, letterSpacing: .5),
              //   ),
              // ),
            ],
          );
        }
    );
  }
}