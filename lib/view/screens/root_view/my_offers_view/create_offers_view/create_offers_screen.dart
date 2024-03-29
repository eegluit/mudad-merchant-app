import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../model/utils/resource/color_resource.dart';
import '../../../../../model/utils/resource/dimensions_resource.dart';
import '../../../../../model/utils/resource/style_resource.dart';
import '../../../../../view_model/controllers/root_view_controller/my_offers_view_controller/create_offers_controller.dart';
import '../../../../widgets/button_view/common_button.dart';
import '../../../../widgets/date_convter/date_converter.dart';
import '../../../../widgets/text_field_view/common_textfield.dart';
import '../../../../widgets/view_helpers/back_button_bar_ui.dart';
import '../../../base_view/base_view_screen.dart';
import '../../../base_view/main_view_screen.dart';
class CreateOffersScreen extends StatelessWidget {
  const CreateOffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(viewControl: CreateOffersController(), onPageBuilder:(context,controller)=> MainViewScreen(
      isBottomBarAvailable: false,
      header:const BackButtonBarUi(title: "Create Offers",),
      body: _buildCreateOffersBody(context,controller),
    ));
  }

}


Widget _buildCreateOffersBody(BuildContext context ,CreateOffersController controller){
  return ListView(
    padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
    children: [
      CommonTextField(
        label: "Coupon Code",
        controller: controller.couponCodeController,
        keyboardType: TextInputType.name,
        hintText: "Enter your coupon Code.".tr,
        validator: (value) {
          if (value!.isEmpty) {
            controller.couponCodeError.value = "Please enter your coupon code.".tr;
            return "";
          } else if (value.removeAllWhitespace == "") {
            controller.couponCodeError.value = "Please enter valid coupon code.".tr;
            return null;
          } else {
            controller.couponCodeError.value = "";
            return null;
          }
        },
        errorText: controller.couponCodeError.value,
      ),
      const SizedBox(height: 30,),
      Row(
        children: [
          Expanded(
            child: CommonTextField(
              label: "Discount",
              controller: controller.discountController,
              keyboardType: TextInputType.name,
              hintText: "Enter your discount.".tr,
              validator: (value) {
                if (value!.isEmpty) {
                  controller.discountError.value = "Please enter your discount.".tr;
                  return "";
                } else if (value.removeAllWhitespace == "") {
                  controller.discountError.value = "Please enter valid discount.".tr;
                  return "";
                } else {
                  controller.discountError.value = "";
                  return null;
                }
              },
              errorText: controller.discountError.value,
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(child: _buildDiscountTypeRow(context,controller))
        ],
      ),
      const SizedBox(height: 30,),
      Row(
        children: [
          Expanded(
            child: _buildDatePicker(context,"Valid From",controller.validFromDate.value,()async {
              await controller.pickDateFormPicker().then((dateTime){
                if(dateTime!=null){
                  controller.validFromDate.value = dateTime;
                }
              });
            },)
          ),
          const SizedBox(width: 10,),
          Expanded(
              child: _buildDatePicker(context,"Valid To",controller.validToDate.value,()async {
                await controller.pickDateFormPicker().then((dateTime){
                  if(dateTime!=null){
                    controller.validToDate.value = dateTime;
                  }
                });
              },)
          ),
        ],
      ),
      const SizedBox(height: 30,),
      CommonTextField(
        label: "Number of time",
        controller: controller.itemsController,
        keyboardType: TextInputType.number,
        hintText: "Enter your number of time.".tr,
        validator: (value) {
          if (value!.isEmpty) {
            controller.itemsError.value = "Please enter your number of time.".tr;
            return "";
          } else if (value.removeAllWhitespace == "") {
            controller.itemsError.value = "Please enter valid number of time.".tr;
            return "";
          } else {
            controller.itemsError.value = "";
            return null;
          }
        },
        errorText: controller.itemsError.value,
      ),
      const SizedBox(height: 30,),
      CommonTextField(
        label: "Description",
        controller: controller.descriptionController,
        keyboardType: TextInputType.name,
        hintText: "Enter your description.".tr,
        validator: (value) {
          if (value!.isEmpty) {
            controller.descriptionError.value = "Please enter your description.".tr;
            return "";
          } else if (value.removeAllWhitespace == "") {
            controller.descriptionError.value = "Please enter valid description.".tr;
            return "";
          } else {
            controller.descriptionError.value = "";
            return null;
          }
        },
        errorText: controller.descriptionError.value,
      ),
      const SizedBox(height: 40,),
      CommonButton(text: "Save",color: ColorResource.mainColor,onPressed:(){},loading: false,)

    ],
  );
}

Widget _buildDiscountTypeRow(BuildContext context ,CreateOffersController controller){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Discount Type",
        style: StyleResource.instance.styleMedium(DimensionResource.fontSizeDoubleExtraLarge, ColorResource.secondColor),
        textAlign: TextAlign.start,
      ),
      const SizedBox(
        height: 8,
      ),
      Container(
        height: 50,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: ColorResource.white,
            border: Border(
              bottom: BorderSide(
                  color: ColorResource.borderTextField2, width: 1.5),
            )),
        child: Obx(()=>DropdownButton<String>(
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          hint: Text(controller.selectedDiscountType.value,style: StyleResource.instance.styleMedium(DimensionResource.fontSizeLarge, ColorResource.textColor),),
          items: controller.discountTypeList.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(controller.selectedDiscountType.value==items?"✓ $items":items,style:StyleResource.instance.styleRegular(DimensionResource.fontSizeLarge, ColorResource.textColor)),
            );
          }).toList(),
          borderRadius: BorderRadius.circular(10),
          underline:const SizedBox(),
          onChanged: (String? newValue) {
            controller.selectedDiscountType.value = newValue!;
          },
        ),),
      )
    ],
  );
}

Widget _buildDatePicker(BuildContext context,String title,DateTime date,VoidCallback onDateChange){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: StyleResource.instance.styleMedium(DimensionResource.fontSizeDoubleExtraLarge, ColorResource.secondColor),
        textAlign: TextAlign.start,
      ),
      const SizedBox(
        height: 8,
      ),
      Container(
        height: 50,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: ColorResource.white,
            border: Border(
              bottom: BorderSide(
                  color: ColorResource.borderTextField2, width: 1.5),
            )),
        child: Row(
          children: [
            Text(
                DateConverter.storyStringToDatetime(date),
                style: StyleResource.instance.styleRegular(DimensionResource.fontSizeLarge, ColorResource.textColor)),
            const Spacer(),
            IconButton(
                onPressed:onDateChange,
                icon: const Icon(
                  Icons.calendar_today_rounded,
                  size: 20,
                  color: ColorResource.textColor_2,
                ))],
        )
      )
    ],
  );
}