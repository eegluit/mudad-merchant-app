import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/utils/resource/color_resource.dart';

import '../../../model/utils/resource/dimensions_resource.dart';
import '../../../model/utils/resource/style_resource.dart';
class BackButtonBarUi extends StatelessWidget {
  final String title;
  final VoidCallback ?onBackTap;
  const BackButtonBarUi({Key? key,required this.title,this.onBackTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 8,),
          IconButton(onPressed:onBackTap?? ()=>Get.back(), icon:const  Icon(Icons.arrow_back_ios,color: ColorResource.white,size: 25,)),
          Text(title,style: StyleResource.instance.styleSemiBold(DimensionResource.fontSizeOverExtraLarge, ColorResource.white),)
        ],
      ),
    );
  }
}
