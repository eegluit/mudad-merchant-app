import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/utils/resource/decoration_resource.dart';
import 'package:mudad_merchant/model/utils/resource/image_resource.dart';
import 'package:mudad_merchant/view/widgets/button_view/common_button.dart';
import 'package:mudad_merchant/view/widgets/cachednetworkimagewidget/cachednetworkimagewidget.dart';
import 'package:mudad_merchant/view_model/routes/app_pages.dart';

import '../../../../model/utils/resource/color_resource.dart';
import '../../../../model/utils/resource/dimensions_resource.dart';
import '../../../../model/utils/resource/style_resource.dart';
import '../../../../view_model/controllers/root_view_controller/my_offers_view_controller/my_offers_controller.dart';
import '../../base_view/base_view_screen.dart';
import '../../base_view/main_view_screen.dart';
class MyOffersScreen extends StatelessWidget {
  const MyOffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(viewControl: MyOffersController(), onPageBuilder:(context,controller)=> MainViewScreen(
      header: _buildMyOffersHeader(context,controller),
      body: _buildMyOffersBody(context,controller),
    ));
  }
}
Widget _buildMyOffersHeader(BuildContext context ,MyOffersController controller){
  return Padding(
    padding:const EdgeInsets.symmetric(horizontal: 20),
    child:Align(alignment: Alignment.centerLeft,child: Text("My Offers ",style: StyleResource.instance.styleSemiBold(DimensionResource.fontSizeDoubleOverExtraLarge, ColorResource.white),)),
  );
}

Widget _buildMyOffersBody(BuildContext context ,MyOffersController controller){
  return ListView(
    padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
    children: [
      Center(child: CommonButton(text: "Create Offers", loading: false, onPressed: ()=>Get.toNamed(Routes.createOffersScreen), color: ColorResource.white,textColor: ColorResource.orangeColor,width: 200,)),
      const SizedBox(height: 20,),
      ...List.generate(5, ((index) => _buildOffersBoxUi(
        image:index.isOdd?ImageResource.instance.offer1Icon:ImageResource.instance.offer2Icon,
        discountDes: "Daily login bonus \$50 max discount",
        discountTitle: "10% off your next order",
        code: "INABFQ"
      )))
    ],
  );
}

Widget _buildOffersBoxUi({required String image,required String discountTitle,required String discountDes,required String code}){
  return Container(
    margin:const EdgeInsets.only(bottom: 15),
    padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: ColorResource.white,
      boxShadow: DecorationResource.instance.containerBoxShadow()
    ),
    child: Row(
      children: [
        SizedBox(height: 50,width:100,child: cachedNetworkImage(image,fit: BoxFit.contain)),
        const SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(discountTitle,style: StyleResource.instance.styleMedium(DimensionResource.fontSizeExtraLarge, ColorResource.orangeColor),),
            const SizedBox(height: 10,),
            Text(discountDes,style: StyleResource.instance.styleRegular(DimensionResource.fontSizeDefault, ColorResource.textColor_2),),
            const SizedBox(height: 15,),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
              child: DottedBorder(borderType : BorderType.RRect,
                radius:const Radius.circular(6),
                  dashPattern:const [2, 2],
                  color: ColorResource.black,
                  strokeWidth: 1,
                  child: Padding(
                    padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Row(
                      children: [
                        Text(code,style: StyleResource.instance.styleSemiBold(DimensionResource.fontSizeSmall, ColorResource.textColor),),
                        const SizedBox(width: 10,),
                        const Icon(Icons.copy,size: 15,color: ColorResource.black,)
                      ],
                    ),
                  )),
            )

          ],
        )

      ],
    ),
  );
}