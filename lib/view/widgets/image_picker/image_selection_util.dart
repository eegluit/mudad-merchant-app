import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mudad_merchant/model/utils/resource/dimensions_resource.dart';
import 'package:mudad_merchant/view/widgets/log_print/log_print_condition.dart';
import 'package:mudad_merchant/view/widgets/toast_view/showtoast.dart';

import '../../../model/utils/resource/color_resource.dart';
import '../../../model/utils/resource/style_resource.dart';



class ImageSelectionUtil {
  final Function(String base64Image, File imageFile) _onImageGet;

   ImageSelectionUtil(this._onImageGet);

   void pickImage(BuildContext context){
     showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorResource.mainColor,
              ),
              child: Wrap(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: ListTile(
                        leading: const Icon(
                          Icons.photo_library,
                          color: ColorResource.white,
                        ),
                        title: Text(
                          "Gallery",
                          style: StyleResource.instance.styleMedium(DimensionResource.fontSizeDefault, ColorResource.white),
                        ),
                        onTap: () {
                          _openGallery();
                          Navigator.of(context).pop();
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: ListTile(
                      leading: const Icon(
                        Icons.photo_camera,
                        color: ColorResource.white,
                      ),
                      title: Text(
                        "Camera",
                        style: StyleResource.instance.styleMedium(DimensionResource.fontSizeDefault, ColorResource.white),
                      ),
                      onTap: () {
                        _openCamera();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

    void pickImageViaGallery(){
      _openGallery();
    }
    void pickImageViaCamera(){
      _openCamera();
    }
    void _openGallery() async {
      ImagePicker imagePicker = ImagePicker();

      try {
        XFile? imageFile = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 10);
        final bytes = await Io.File(imageFile!.path).readAsBytes();
        _onImageGet(base64Encode(bytes), File(imageFile.path));
      } catch (e) {
        logPrint(e);
      }
    }

    void _openCamera() async {
      ImagePicker imagePicker = ImagePicker();
      try {
       await imagePicker.pickImage(
            source: ImageSource.camera, imageQuality: 10).then((imageFile) async {
             if(imageFile != null){
               final bytes = await Io.File(imageFile.path).readAsBytes();
               _onImageGet(base64Encode(bytes), File(imageFile.path));
               logPrint(imageFile.mimeType.toString());
             } else{
               toastShow(massage: "Image not selected");
             }
        });

      } catch (e) {
          logPrint(e);
      }
    }
}
