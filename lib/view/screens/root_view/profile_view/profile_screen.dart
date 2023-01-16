import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/utils/resource/image_resource.dart';
import 'package:mudad_merchant/view_model/routes/app_pages.dart';

import '../../../../model/services/auth_service.dart';
import '../../../../model/utils/resource/color_resource.dart';
import '../../../../model/utils/resource/dimensions_resource.dart';
import '../../../../model/utils/resource/style_resource.dart';
import '../../../../view_model/controllers/root_view_controller/profile_view_controller/profile_controller.dart';
import '../../../widgets/button_view/button_holders.dart';
import '../../base_view/base_view_screen.dart';
import '../../base_view/main_view_screen.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(viewControl: ProfileController(), onPageBuilder:(context,controller)=> MainViewScreen(
      header: _buildProfileHeader(context,controller),
      body: _buildProfileBody(context,controller),
    ));
  }
}
Widget _buildProfileHeader(BuildContext context ,ProfileController controller){
  return Padding(
    padding:const EdgeInsets.symmetric(horizontal: 20),
    child:Row(
      children: [
        Text("My Profile ",style: StyleResource.instance.styleSemiBold(DimensionResource.fontSizeDoubleOverExtraLarge, ColorResource.white),),
        const Spacer(),
        Stack(
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: ButtonResource.instance.iconButton(
                  image: ImageResource.instance.notificationIcon,
                  onTap: () {},
                  imageHeight: 28,
                  color: ColorResource.white,
                  alignmentGeometry: Alignment.centerRight),
            ),
            Positioned(
                top: 10,
                right: 0,
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorResource.errorColor),
                ))
          ],
        ),
        const SizedBox(width: 20,),
        const Icon(Icons.settings,size: 35,color: ColorResource.white,)
      ],
    ),
  );
}

Widget _buildProfileBody(BuildContext context ,ProfileController controller){
  return ListView(
    padding:const EdgeInsets.symmetric(vertical: 20),
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text("Personal Info",style: StyleResource.instance.styleSemiBold(DimensionResource.fontSizeDoubleExtraLarge, ColorResource.textColor),),
      ),
      const SizedBox(height: 10,),
      _buildNavigationRow(ImageResource.instance.homeIcon,"Personal Information",()=>Get.toNamed(Routes.editProfileScreen)),
      _buildNavigationRow(ImageResource.instance.passwordIcon,"Change Password",()=>Get.toNamed(Routes.changePassword)),
      const SizedBox(height: 20,),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text("Marchant Info",style: StyleResource.instance.styleSemiBold(DimensionResource.fontSizeDoubleExtraLarge, ColorResource.textColor),),
      ),
      const SizedBox(height: 10,),
      _buildNavigationRow(ImageResource.instance.storeIcon,"Store information",()=>Get.toNamed(Routes.storeInfoScreen)),
      _buildNavigationRow(ImageResource.instance.kycIcon,"KYC information",()=>Get.toNamed(Routes.kycInfoScreen)),
      const SizedBox(height: 20,),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text("Logout",style: StyleResource.instance.styleSemiBold(DimensionResource.fontSizeDoubleExtraLarge, ColorResource.textColor),),
      ),
      const SizedBox(height: 10,),
      _buildNavigationRow(ImageResource.instance.logoutIcon,"Logout",()=>Get.find<AuthService>().logOut()),


    ],
  );
}

Widget _buildNavigationRow(String image, String title, VoidCallback onPressed) {
  return MaterialButton(
    padding:const EdgeInsets.symmetric(horizontal: 5),
    onPressed: onPressed,
    child: Row(
      children: [
        Container(
            height: 50,
            width: 50,
            padding:const EdgeInsets.all(13),
            child: Image.asset(
              image,
              color: ColorResource.orangeColor,
            )),
        Text(title, style: StyleResource.instance.styleMedium(DimensionResource.fontSizeExtraLarge, ColorResource.textColor_2)),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios,color: ColorResource.textColor_2,size: 20,),
        const SizedBox(
          width: 10,
        ),
      ],
    ),
  );
}