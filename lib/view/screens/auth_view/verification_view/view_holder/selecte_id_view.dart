import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/utils/resource/image_resource.dart';

import '../../../../widgets/toast_view/showtoast.dart';
import '/../../model/utils/resource/color_resource.dart';
import '/../../model/utils/resource/dimensions_resource.dart';
import '/../../model/utils/resource/style_resource.dart';
import '/../../view_model/controllers/verification_controller/verification_conroller.dart';

class SelectIdWidget extends GetView<VerificationController> {
  const SelectIdWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
            ()=>Column(
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
                  controller.typeList.length,
                      (index) {
                    var data = controller.typeList.elementAt(index);
                    return GestureDetector(
                      onTap: (){
                        controller.selectedId.value = index;
                        controller.onSelectId();
                        // controller.selectedId.value = index;
                        // controller.openSelfieCamera();
                      },
                      child: Card(
                          margin: const EdgeInsets.only(bottom: DimensionResource.marginSizeExtraLarge),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: DimensionResource.marginSizeLarge,vertical: DimensionResource.marginSizeDefault),
                            child: Row(
                              children: [
                                Container(
                                  height: 33,
                                  width: 33,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color:  ColorResource.secondColor, width: 2.5),
                                      color: controller.selectedId.value == index ? ColorResource.secondColor:ColorResource.white),
                                  child: Center(
                                      child: controller.selectedId.value == index ? Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Image.asset(ImageResource.instance.checkIcon,color: ColorResource.white,),)
                                          : const SizedBox()),
                                ),
                                const SizedBox(
                                  width: DimensionResource.marginSizeDefault,
                                ),
                                Text(data.name??"",style: StyleResource.instance.styleMedium(DimensionResource.fontSizeExtraLarge, ColorResource.secondColor).copyWith(letterSpacing: .6,),)
                              ],
                            ),
                          )
                      ),
                    );
                  }),
            ),
          ],
        )
    );
  }
}