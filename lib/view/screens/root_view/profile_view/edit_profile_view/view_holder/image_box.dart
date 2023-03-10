
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/utils/resource/color_resource.dart';
import 'package:mudad_merchant/model/utils/resource/image_resource.dart';
import 'package:mudad_merchant/view/widgets/cachednetworkimagewidget/cachednetworkimagewidget.dart';

import '../../../../../../view_model/controllers/root_view_controller/profile_view_controller/edit_profile_controller.dart';
import '../../../../../widgets/button_view/image_picker.dart';


class ProfileImagePox extends GetView<EditProfileController> {
  final bool ?updatePartialProfile;
  const ProfileImagePox({Key? key,this.updatePartialProfile}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: 130,
      child: Stack(
        children: [
          Hero(
            tag: "profile",
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100), // if you need this
              ),
              child: Obx(() {
                return Container(
                  width: 125,
                  height: 125,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: ColorResource.mainColor),
                      color: ColorResource.lightGrey),
                  child: controller.image.value.path != "" || controller.image.value.path.isNotEmpty
                      ? Obx(() {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              controller.image.value,
                              fit: BoxFit.cover,
                            ),
                          );
                        })
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: cachedNetworkImage(ImageResource.instance.defaultUser)),
                );
              }),
            ),
          ),
          Positioned(
            bottom: 7,
            right: 7,
            child: InkWell(
              onTap: () {
                showImagePicker(context ,
                    onCamaraTap: () {controller.imgFromCamera(updatePartialProfile!);Navigator.of(context).pop();},
                  onGalleryTap: () {controller.imgFromGallery(updatePartialProfile!);Navigator.of(context).pop();},
                );
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ColorResource.mainColor,
                ),
                child:const Icon(
                  Icons.edit_outlined,
                  color: ColorResource.white,
                  size: 15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
