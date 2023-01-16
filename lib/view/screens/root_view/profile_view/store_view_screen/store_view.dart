import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/view/widgets/cachednetworkimagewidget/cachednetworkimagewidget.dart';
import 'package:mudad_merchant/view/widgets/text_field_view/regex/regex.dart';

import '../../../../../model/utils/resource/color_resource.dart';
import '../../../../../model/utils/resource/dimensions_resource.dart';
import '../../../../../model/utils/resource/style_resource.dart';
import '../../../../../view_model/controllers/root_view_controller/profile_view_controller/store_info_controller.dart';
import '../../../../widgets/button_view/common_button.dart';
import '../../../../widgets/text_field_view/common_textfield.dart';
import '../../../../widgets/view_helpers/back_button_bar_ui.dart';
import '../../../base_view/base_view_screen.dart';
import '../../../base_view/main_view_screen.dart';
class StoreInfoScreen extends StatelessWidget {
  const StoreInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BaseView(viewControl: StoreInfoController(), onPageBuilder:(context,controller)=> MainViewScreen(
      isBottomBarAvailable: false,
      header:const BackButtonBarUi(title: "Store Information",),
      body: _buildStoreInfoBody(context,controller),
    ));
  }
}


Widget _buildStoreInfoBody(BuildContext context,StoreInfoController controller){
  return ListView(
    padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
    children: [
      Form(
        key: controller.formKey,
        child: Obx(()=>Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextField(
              label: "Name of Store",
              controller: controller.nameController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              hintText: "Your Name, e.g : John Doe".tr,
              validator: (value) {
                if (value!.isEmpty) {
                  controller.nameError.value = "Please enter your store name.".tr;
                  return "";
                } else if (value.removeAllWhitespace == "") {
                  controller.nameError.value = "Please enter valid store name.".tr;
                  return null;
                } else {
                  controller.nameError.value = "";
                  return null;
                }
              },
              errorText: controller.nameError.value,
            ),
            const SizedBox(height: 30,),
            CommonTextField(
              label: "Address of store",
              suffixIcon: false,
              controller: controller.addressController,
              keyboardType: TextInputType.text,
              hintText: "Enter your store address.".tr,
              validator: (value) {
                if (value!.isEmpty) {
                  controller.addressError.value = "Please enter your store address.".tr;
                  return "";
                } else if (value.removeAllWhitespace == "") {
                  controller.addressError.value = "Please enter valid store address.".tr;
                  return "";
                } else {
                  controller.addressError.value = "";
                  return null;
                }
              },
              errorText: controller.addressError.value,
            ),
            const SizedBox(height: 30,),
            Row(
              children: [
                Expanded(child: CommonTextField(
                  label: "Latitude",
                  controller: controller.latController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  hintText: "00.000000".tr,
                  validator: (value) {
                    if (value!.isEmpty) {
                      controller.latError.value = "Please enter latitude of your store.".tr;
                      return "";
                    } else if (!value.isNumeric()) {
                      controller.latError.value = "Please enter valid latitude of your store.".tr;
                      return null;
                    } else {
                      controller.latError.value = "";
                      return null;
                    }
                  },
                  errorText: controller.latError.value,
                )),
                const SizedBox(width: 30,),
                Expanded(child: CommonTextField(
                  label: "Longitude",
                  controller: controller.lngController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  hintText: "00.000000".tr,
                  validator: (value) {
                    if (value!.isEmpty) {
                      controller.lngError.value = "Please enter longitude of your store.".tr;
                      return "";
                    } else if (!value.isNumeric()) {
                      controller.lngError.value = "Please enter valid longitude of your store.".tr;
                      return null;
                    } else {
                      controller.lngError.value = "";
                      return null;
                    }
                  },
                  errorText: controller.lngError.value,
                )),
              ],
            ),
            const SizedBox(height: 30,),
            Text(
              "Brand Logo",
              style: StyleResource.instance.styleMedium(DimensionResource.fontSizeDoubleExtraLarge, ColorResource.secondColor),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: DimensionResource.marginSizeDefault,),
            Card(elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: DimensionResource.marginSizeExtraLarge+5,vertical: DimensionResource.marginSizeLarge),
                    child: Text("Please Upload logo ",style: StyleResource.instance.styleRegular(DimensionResource.fontSizeDefault-1, ColorResource.black),),
                  ),
                  const Divider(
                    thickness: 1.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: DimensionResource.marginSizeExtraLarge+5,vertical: DimensionResource.marginSizeLarge),
                    child: Row(
                      children: [
                        Text("We will be allowed only",style: StyleResource.instance.styleMedium(DimensionResource.fontSizeDefault-1, ColorResource.black.withOpacity(0.5)),),
                        const Spacer(),
                        containerText(
                            color: ColorResource.greenColor,
                            text: "PNG"
                        ),const SizedBox(width: DimensionResource.marginSizeSmall,),
                        containerText(
                            color: ColorResource.blueColor,
                            text: "JPG"
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: DimensionResource.marginSizeExtraLarge+5),
                    child: DottedBorder(
                      dashPattern: const [8,4],
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      color: ColorResource.blueColor,
                      strokeWidth: 1,
                      child:Container(
                        width: double.infinity,
                        height: Get.height*0.2,
                        decoration: BoxDecoration(
                            color: ColorResource.blueColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)
                        ),

                        child:cachedNetworkImage(controller.storeInfo.value.logo??""),
                      ),
                    ),
                  ),
                  const SizedBox(height: DimensionResource.marginSizeLarge,),
                ],
              ),
            ),
            const SizedBox(height: 40,),
            CommonButton(text: "Update", loading: controller.isLoading.value, onPressed: (){}, color: ColorResource.mainColor),
            const SizedBox(height: 40,),
          ],
        )),
      ),
    ],
  );
}
Container containerText({required Color color,required String text}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: DimensionResource.marginSizeSmall,vertical: DimensionResource.marginSizeExtraSmall),
    decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4)
    ),
    child: Text(text,style: StyleResource.instance.styleMedium(DimensionResource.fontSizeDefault-1, color)),
  );
}