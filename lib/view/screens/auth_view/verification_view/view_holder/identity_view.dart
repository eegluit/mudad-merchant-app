import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/../../model/utils/resource/color_resource.dart';
import '/../../model/utils/resource/dimensions_resource.dart';
import '/../../model/utils/resource/style_resource.dart';
import '/../../view_model/controllers/verification_controller/verification_conroller.dart';

class IdentityWidget extends GetView<VerificationController> {
  const IdentityWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: DimensionResource.marginSizeLarge,
              vertical: DimensionResource.marginSizeLarge),
          child: Text(
            controller.verifyPageDataList[controller.currentStep.value-1].subTitle,
            style: StyleResource.instance
                .styleMedium(DimensionResource.fontSizeExtraLarge,
                ColorResource.secondColor)
                .copyWith(height: 1.7, letterSpacing: .5),
          ),
        ),
        const SizedBox(
          height: DimensionResource.marginSizeExtraLarge+20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
              controller.verifyIdentityList.length,
                  (index) => Container(
                padding: const EdgeInsets.symmetric(
                  vertical: DimensionResource.marginSizeSmall,horizontal: DimensionResource.marginSizeLarge,),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 35.0,
                      height: 35.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorResource.secondColor,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          '${index + 1}',
                          style: StyleResource.instance.styleMedium(DimensionResource.fontSizeLarge, ColorResource.secondColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: DimensionResource.marginSizeDefault,
                    ),
                    Text(
                      controller.verifyIdentityList.elementAt(index),
                      style: StyleResource.instance.styleMedium(DimensionResource.fontSizeExtraLarge, ColorResource.secondColor),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}