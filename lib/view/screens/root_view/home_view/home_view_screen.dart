import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mudad_merchant/model/services/auth_service.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:mudad_merchant/model/utils/resource/color_resource.dart';
import 'package:mudad_merchant/model/utils/resource/dimensions_resource.dart';
import 'package:mudad_merchant/model/utils/resource/style_resource.dart';
import 'package:mudad_merchant/view/screens/base_view/base_view_screen.dart';
import 'package:mudad_merchant/view_model/controllers/root_view_controller/homw_view_controller/home_controller.dart';


import '../../../../model/utils/resource/image_resource.dart';
import '../../../../view_model/routes/app_pages.dart';
import '../../../widgets/button_view/common_button.dart';
import '../../../widgets/cachednetworkimagewidget/cachednetworkimagewidget.dart';
import '../../base_view/main_view_screen.dart';



class HomeViewScreen extends StatelessWidget {
  const HomeViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(viewControl: HomeController(), onPageBuilder:(context,controller)=> MainViewScreen(
      header: _buildHomeHeader(context,controller),
      body: _buildHomeBody(context,controller),
    ));
  }
}
Widget _buildHomeHeader(BuildContext context ,HomeController controller){
  return Padding(
    padding:const EdgeInsets.symmetric(horizontal: 20),
    child: Center(
      child: Row(
        children: [
          InkWell(
            onTap: ()=>Get.toNamed(Routes.editProfileScreen),
            child: Hero(
              tag: "profile",
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(50), // if you need this
                ),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          width: 2, color: ColorResource.white),
                      color: ColorResource.grey_1),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: cachedNetworkImage(ImageResource.instance.defaultUser)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20,),
          Obx(()=>Column(

            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(Get.find<AuthService>().user.value.name??"Guest User",style: StyleResource.instance.styleSemiBold(DimensionResource.fontSizeOverLarge, ColorResource.white),),
              Text(Get.find<AuthService>().user.value.email??"GuestUser@gmail.com",style: StyleResource.instance.styleRegular(DimensionResource.fontSizeLarge, ColorResource.textColor_2),)
            ],
          )),
        ],
      ),
    ),
  );
}

Widget _buildHomeBody(BuildContext context ,HomeController controller){
  return ListView(
    padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
    children: [
      const SizedBox(height: 30,),
      _buildHomeCardUi(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15,),
          Text("Create Offers",style: StyleResource.instance.styleSemiBold(DimensionResource.fontSizeDoubleExtraLarge, ColorResource.white),),
          const SizedBox(height: 10,),
          Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the ",style: StyleResource.instance.styleRegular(DimensionResource.fontSizeDefault, ColorResource.white),),
          const SizedBox(height: 20,),
          CommonButton(text: "Create Offers", loading: false, onPressed: ()=>Get.toNamed(Routes.createOffersScreen), color: ColorResource.white,textColor: ColorResource.mainColor),
          const SizedBox(height: 20,),
        ],
      )),
      const SizedBox(height: 50,),
      _buildHomeCardUi(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Last Transaction ",style: StyleResource.instance.styleSemiBold(DimensionResource.fontSizeDoubleExtraLarge, ColorResource.white),),
              InkWell(onTap: ()=>Get.toNamed(Routes.viewAllTransactionScreen),child: Text("All Transaction",style: StyleResource.instance.styleRegular(DimensionResource.fontSizeLarge, ColorResource.white),)),
            ],
          ),
          const SizedBox(height: 30,),
          _buildTransactionRowUi(
              backGroundColor:ColorResource.white,
              transactionDateAndTime: "March 12, 06:30 pm",
              amount: "+RO 100",
              transactionTitle: "Recived from Customer "
          ),
          const SizedBox(height: 5,),
        ],
      )),
      const SizedBox(height: 20,),
      CommonButton(text: "My QR", loading: false, onPressed: ()=>Get.toNamed(Routes.qrCodeScreen) , color: ColorResource.mainColor,textColor: ColorResource.white),
          const SizedBox(height: 20,),
    ],
  );
}

Widget _buildHomeCardUi({required Widget child}){
  return Container(
    padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
        gradient:const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorResource.mainColor,
            ColorResource.mainColor,
          ],
        )
    ),
    child: child,
  );
}

Widget _buildTransactionRowUi({required Color backGroundColor,required String transactionTitle,required  String transactionDateAndTime,required String amount}){
  return Container(
    margin:const EdgeInsets.only(bottom: 10),
    padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: backGroundColor,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: ColorResource.secondColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(ImageResource.instance.walletIcon,color: ColorResource.white,),
          ),
        ),
        const SizedBox(width: 15,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(transactionTitle,style: StyleResource.instance.styleMedium(DimensionResource.fontSizeExtraLarge, ColorResource.black),),
              const SizedBox(height: 5,),
              Text(transactionDateAndTime,style: StyleResource.instance.styleRegular(DimensionResource.fontSizeDefault, ColorResource.textColor),),

            ],
          ),
        ),
        const SizedBox(width: 10,),
        Text(amount,style: StyleResource.instance.styleMedium(DimensionResource.fontSizeLarge, ColorResource.darkGreenColor),),
      ],
    ),

  );
}

