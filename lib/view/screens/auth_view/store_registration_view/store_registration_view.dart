import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/utils/resource/image_resource.dart';
import 'package:mudad_merchant/view/widgets/button_view/common_button.dart';
import 'package:mudad_merchant/view/widgets/text_field_view/regex/regex.dart';
import '../../../../model/utils/resource/color_resource.dart';
import '../../../../model/utils/resource/dimensions_resource.dart';
import '../../../../model/utils/resource/style_resource.dart';
import '../../../../view_model/controllers/store_registration_controller/store_registration_controller.dart';
import '../../../widgets/text_field_view/common_textfield.dart';
import '../../base_view/base_view_screen.dart';

class StoreRegistrationScreen extends StatelessWidget {
  const StoreRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(viewControl: StoreRegistrationController(), onPageBuilder: (BuildContext context,StoreRegistrationController controller)=>_buildMainView(context,controller));
  }
  _buildMainView(BuildContext context,StoreRegistrationController controller){
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: DimensionResource.marginSizeExtraLarge),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top+DimensionResource.marginSizeExtraLarge+20,),
          Text(
            "Store Registration",
            style: StyleResource.instance.styleExtraBold(
                DimensionResource.fontSizeDoubleOverExtraLarge,
                ColorResource.mainColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: DimensionResource.marginSizeExtraLarge+30,),
          _buildStoreDetailFields(context,controller),
        ],
      ),
    );
  }
  Widget _buildStoreDetailFields(BuildContext context,StoreRegistrationController controller){
    return Form(
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

                      child:controller.selectLogo.value.path != ""? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            children: [
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: Image.file(controller.selectLogo.value,height: 55,fit: BoxFit.cover,)),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(onPressed: (){
                                    controller.selectLogo.value = File("");
                                  }, icon:const Icon(Icons.cancel),color: ColorResource.mainColor,iconSize: 30,)),
                            ],
                          )) :GestureDetector(
                        onTap: controller.openImagePicker,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(ImageResource.instance.vectorIcon,height: 55,),
                            const SizedBox(
                              height: 15,
                            ),
                            Text("Please choose file here",style: StyleResource.instance.styleRegular(DimensionResource.fontSizeDefault-1, ColorResource.black.withOpacity(0.5)),),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("Open Camera",style: StyleResource.instance.styleRegular(DimensionResource.fontSizeDefault-1, ColorResource.black.withOpacity(0.5)),),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: DimensionResource.marginSizeLarge,),
              ],
            ),
          ),
          const SizedBox(height: 40,),
          Obx(()=>CommonButton(text: "Submit", loading: controller.isLoading.value, onPressed: controller.onSubmit, color: ColorResource.mainColor),),
          const SizedBox(height: 40,),
        ],
      )),
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

}