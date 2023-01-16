import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/utils/resource/image_resource.dart';
import 'package:mudad_merchant/view/widgets/button_view/common_button.dart';

import '../../base_view/base_view_screen.dart';
import '/../../model/utils/resource/color_resource.dart';
import '/../../model/utils/resource/dimensions_resource.dart';
import '/../../model/utils/resource/style_resource.dart';
import '/../../view_model/controllers/verification_controller/verification_conroller.dart';

class VerificationScreen extends StatelessWidget {
 const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewControl: VerificationController(),
        onPageBuilder: (BuildContext context, VerificationController controller) => _buildLoginView(context, controller));
  }

  Widget _buildLoginView(BuildContext context, VerificationController controller) {
    return Column(children: [
      Expanded(
          flex: 3,
          child: Obx(
             () {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: DimensionResource.marginSizeDefault),
                    child: StepBar(
                      currentStep: controller.currentStep.value,
                      stepFirstComplete: controller.currentStep.value >= 1,
                      stepSecondComplete: controller.currentStep.value >= 2,
                      stepThirdComplete: controller.currentStep.value >= 3,
                      stepFourthComplete: controller.currentStep.value >= 4,
                    ),
                  ),
                  Text(
                    "${controller.verifyPageDataList[controller.currentStep.value-1].title}${controller.currentStep.value == 4 ? (controller.isVerified.value ? "Complete":"Failed"):""}",
                    style: StyleResource.instance.styleExtraBold(
                        DimensionResource.fontSizeDoubleOverExtraLarge,
                        ColorResource.mainColor),
                    textAlign: TextAlign.center,
                  )
                ],
              );
            }
          )),
      Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: DimensionResource.marginSizeLarge),
            child: Obx(
               () {
                return controller.verifyWidgetList[controller.currentStep.value-1];
              }
            ),
          )),
      Expanded(
          flex: 2,
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensionResource.marginSizeLarge),
          child: Obx(
            () =>Column(
              children: [
                Visibility(
                    visible: controller.currentStep.value == 1 || (controller.currentStep.value == 2 && controller.selectedIdPic.value.path != "") ||  controller.currentStep.value == 3 || controller.currentStep.value == 4 ,
                    child: CommonButton(text:controller.currentStep.value == 1? "Get Started": controller.currentStep.value == 2 ? "Continue" : controller.currentStep.value == 3 ? controller.selectSelfie.value.path !=""? "Next":"Start" : controller.isVerified.value ?"Next":"Try Again", loading: controller.isLoading.value, onPressed: controller.currentStep.value == 1? controller.onVerifyIdentity:controller.currentStep.value == 2?controller.onSelectId:controller.currentStep.value == 3?controller.onTakeSelfie:controller.onVerificationComplete , color: ColorResource.mainColor)),
                const SizedBox(height: 20,),
                Visibility(
                    visible: (controller.currentStep.value == 3 && controller.selectSelfie.value.path != "") ||  (controller.currentStep.value == 4 && !controller.isVerified.value),
                    child: CommonButton(text: controller.currentStep.value == 3 ? "Re-Take":"skip for now", loading: false, onPressed:controller.currentStep.value == 3?controller.openSelfieCamera :controller.onSkipNowButton , color: ColorResource.white,textColor: ColorResource.secondColor,)),
              ],
            )
          ),))
    ]);
  }
}



class StepBar extends StatelessWidget {
  final bool stepFirstComplete;
  final bool stepSecondComplete;
  final bool stepThirdComplete;
  final bool stepFourthComplete;
  final int currentStep;
  const StepBar(
      {Key? key,
      required this.currentStep,
      required this.stepThirdComplete,
      required this.stepSecondComplete,
      required this.stepFirstComplete,
      required this.stepFourthComplete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 10),
      child: Row(
        children: [
          Container(
            height: 33,
            width: 33,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: stepFirstComplete && currentStep >= 1
                        ? ColorResource.mainColor
                        : ColorResource.borderColor,
                    width: 6),
                color: ColorResource.mainColor),
            child: Center(
                child: stepFirstComplete && currentStep > 1
                    ? Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.asset(ImageResource.instance.checkIcon,color: ColorResource.white,),
                      )
                    : Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: stepFirstComplete
                                  ? ColorResource.white
                                  : ColorResource.mainColor,
                              width: 3),
                          color: stepFirstComplete
                              ? ColorResource.mainColor
                              : ColorResource.white,
                        ),
                      )),
          ),
          Expanded(
            child: Divider(
              color: stepSecondComplete
                  ? ColorResource.mainColor
                  : ColorResource.borderColor,
              thickness: 3,
              height: 0,
            ),
          ),
          Container(
            height: 33,
            width: 33,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: stepSecondComplete && currentStep >= 2
                        ? ColorResource.mainColor
                        : ColorResource.borderColor,
                    width: 6),
                color: ColorResource.mainColor),
            child: Center(
                child: stepSecondComplete && currentStep > 2
                    ? Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.asset(ImageResource.instance.checkIcon),
                      )
                    : Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: stepSecondComplete
                                  ? ColorResource.white
                                  : ColorResource.mainColor,
                              width: 3),
                          color: stepSecondComplete
                              ? ColorResource.mainColor
                              : ColorResource.white,
                        ),
                      )),
          ),
          Expanded(
            child: Divider(
              color: stepThirdComplete
                  ? ColorResource.mainColor
                  : ColorResource.borderColor,
              thickness: 2,
              height: 0,
            ),
          ),
          Container(
            height: 33,
            width: 33,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: stepThirdComplete && currentStep >= 3
                        ? ColorResource.mainColor
                        : ColorResource.borderColor,
                    width: 6),
                color: ColorResource.mainColor),
            child: Center(
                child: stepThirdComplete && currentStep > 3
                    ? Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.asset(ImageResource.instance.checkIcon),
                      )
                    : Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: stepThirdComplete
                                  ? ColorResource.white
                                  : ColorResource.mainColor,
                              width: 3),
                          color: stepThirdComplete
                              ? ColorResource.mainColor
                              : ColorResource.white,
                        ),
                      )),
          ),
          Expanded(
            child: Divider(
              color: stepFourthComplete
                  ? ColorResource.mainColor
                  : ColorResource.borderColor,
              thickness: 2,
              height: 0,
            ),
          ),
          Container(
            height: 33,
            width: 33,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: stepFourthComplete && currentStep >= 4
                        ? ColorResource.mainColor
                        : ColorResource.borderColor,
                    width: 6),
                color: ColorResource.mainColor),
            child: Center(
                child: stepFourthComplete && currentStep > 4
                    ? Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.asset(ImageResource.instance.checkIcon),
                      )
                    : Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: stepFourthComplete
                                  ? ColorResource.white
                                  : ColorResource.mainColor,
                              width: 3),
                          color: stepFourthComplete
                              ? ColorResource.mainColor
                              : ColorResource.white,
                        ),
                      )),
          ),
        ],
      ),
    );
  }
}
