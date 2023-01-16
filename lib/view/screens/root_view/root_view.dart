import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/utils/resource/color_resource.dart';
import 'package:mudad_merchant/model/utils/resource/dimensions_resource.dart';
import 'package:mudad_merchant/model/utils/resource/style_resource.dart';


import '../../../model/utils/resource/decoration_resource.dart';
import '../../../view_model/controllers/root_view_controller/root_view_controller.dart';

class RootView extends StatelessWidget {
  const RootView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    RootViewController controller =Get.put(RootViewController());
    return Scaffold(
      bottomNavigationBar: Container(
        color: ColorResource.white,
        height: 77,
        child: _buildBottomNavigationBar(context,controller),
      ),

      body:_buildRootMainView(context, controller),
    );
  }
}

Widget _buildRootMainView(BuildContext context, RootViewController controller) {
  return Obx(() =>Center(
    child: controller.widgetOptions.elementAt(controller.selectedIndex.value),
  ));
}

Widget _buildBottomNavigationBar(BuildContext context, RootViewController controller) {
  return Container(
    decoration: BoxDecoration(
      color: ColorResource.white,
        boxShadow: DecorationResource.instance.containerBoxShadow()
    ),
    child: Obx(()=>Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:List.generate(4, (index) => _buildBottomBarIconTap(
        title: controller.bottomBarList[index]["title"],
          image: controller.bottomBarList[index]["image"],
          onTap:(){controller.onItemTapped(index);},
          isSelect:index==controller.selectedIndex.value)),
    )),
  );
}

Widget _buildBottomBarIconTap({required String image,required  String title,required  VoidCallback onTap,required  bool isSelect}){
  return InkWell(
    onTap: onTap,
    child: Container(
      height:77,
      padding:const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(Get.context!).size.width/4,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color:isSelect==true? ColorResource.mainColor:ColorResource.white,width: 4)
        )
      ),
      child: Column(
        children: [
          Image.asset(image,color: ColorResource.mainColor,height:title=="Transaction"?27:25,),
          SizedBox(height: title=="Transaction"?8:10,),
          Text(title,style: StyleResource.instance.styleRegular(DimensionResource.fontSizeDefault, ColorResource.textColor),)
        ],
      ),
    ),
  );
}
