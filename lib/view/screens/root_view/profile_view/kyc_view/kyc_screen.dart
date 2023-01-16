import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/utils/resource/color_resource.dart';
import 'package:mudad_merchant/model/utils/resource/dimensions_resource.dart';
import 'package:mudad_merchant/model/utils/resource/style_resource.dart';
import 'package:mudad_merchant/view/screens/base_view/base_view_screen.dart';
import 'package:mudad_merchant/view/widgets/cachednetworkimagewidget/cachednetworkimagewidget.dart';

import '../../../../../view_model/controllers/root_view_controller/profile_view_controller/kyc_controller.dart';
import '../../../../widgets/view_helpers/back_button_bar_ui.dart';
import '../../../base_view/main_view_screen.dart';
class KycInfoScreen extends StatelessWidget {
  const KycInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(viewControl: KycController(), onPageBuilder:(context,controller)=> MainViewScreen(
      isBottomBarAvailable: false,
      header:const BackButtonBarUi(title: "Kyc Information",),
      body: _buildKycInfoBody(context,controller),
    ));
  }
}

Widget _buildKycInfoBody(BuildContext context ,KycController controller){
  return Obx(()=>controller.kycInfo.value.idType!=null?ListView(
    padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("1.Selected Id Type :  ",style: StyleResource.instance.styleMedium(DimensionResource.fontSizeDoubleExtraLarge, ColorResource.secondColor),),
          Text(controller.kycInfo.value.idType??"",style: StyleResource.instance.styleMedium(DimensionResource.fontSizeDoubleExtraLarge, ColorResource.textColor),)
        ],
      ),
      const SizedBox(height: 20,),
      Text("2.Clicked Kyc Doc :",style: StyleResource.instance.styleMedium(DimensionResource.fontSizeDoubleExtraLarge, ColorResource.secondColor),),
      const SizedBox(height: 10,),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorResource.borderColor,width: 2),
        ),
        child: ClipRRect(borderRadius: BorderRadius.circular(10),child: cachedNetworkImage(controller.kycInfo.value.kycDoc??"")),
      ),
      const SizedBox(height: 20,),
      Text("3.Clicked Selfie :",style: StyleResource.instance.styleMedium(DimensionResource.fontSizeDoubleExtraLarge, ColorResource.secondColor),),
      const SizedBox(height: 10,),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorResource.borderColor,width: 2),
        ),
        child: ClipRRect(borderRadius: BorderRadius.circular(10),child: cachedNetworkImage(controller.kycInfo.value.selfie??"")),
      )


    ],
  ):const Center(child: CircularProgressIndicator(color: ColorResource.mainColor,),));
}