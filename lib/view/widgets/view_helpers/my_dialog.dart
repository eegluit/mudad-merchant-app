import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/utils/resource/color_resource.dart';
import '../../../model/utils/resource/dimensions_resource.dart';
import '../../../model/utils/resource/style_resource.dart';

class MyDialog extends StatelessWidget {
  final VoidCallback? onPress;
  final bool? isFailed;
  final double? rotateAngle;

  final String? title;
  final String? description;
  final String? image;
  const MyDialog({super.key,this.isFailed = false,this.rotateAngle = 0,@required this.title,@required this.description,@required this.onPress,this.image});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * .8,
        child: Stack(clipBehavior: Clip.none, children: [
          Positioned(
            left: 0,
            right: 0,
            top: -55,
            child: Container(
              height: 80,
              width: 80,
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: ColorResource.mainColor, shape: BoxShape.circle),
              child: Transform.rotate(
                angle: rotateAngle!,
                child: Image.asset(
                  image!,
                  height: 30,
                  color: ColorResource.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(title!, style: StyleResource.instance.styleSemiBold(DimensionResource.fontSizeExtraLarge, ColorResource.black)),
              const SizedBox(height: 10),
              Text(description!,
                  textAlign: TextAlign.center,
                  style: StyleResource.instance.styleMedium(DimensionResource.fontSizeDefault, ColorResource.black)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: ColorResource.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ColorResource.mainColor, width: 2)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: MaterialButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("No".tr, style: StyleResource.instance.styleSemiBold(DimensionResource.fontSizeExtraLarge, ColorResource.mainColor)),
                        )),
                  ),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(color: ColorResource.mainColor, borderRadius: BorderRadius.circular(8)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: MaterialButton(
                          onPressed: onPress!,
                          child: Text("Yes".tr, style: StyleResource.instance.styleSemiBold(DimensionResource.fontSizeExtraLarge, ColorResource.white)),
                        )),
                  ),
                ],
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
