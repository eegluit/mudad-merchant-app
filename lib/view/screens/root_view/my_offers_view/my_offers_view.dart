import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/utils/resource/decoration_resource.dart';
import 'package:mudad_merchant/model/utils/resource/image_resource.dart';
import 'package:mudad_merchant/view/widgets/button_view/common_button.dart';
import 'package:mudad_merchant/view/widgets/cachednetworkimagewidget/cachednetworkimagewidget.dart';
import 'package:mudad_merchant/view/widgets/toast_view/showtoast.dart';
import 'package:mudad_merchant/view_model/routes/app_pages.dart';
import 'package:flutter/services.dart';

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
    print('ABC Check 123');

    return BaseView(
        viewControl: MyOffersController(),
        onPageBuilder: (context, controller) => MainViewScreen(
              header: _buildMyOffersHeader(context, controller),
              body: _buildMyOffersBody(context, controller),
            ));
  }
}

Widget _buildMyOffersHeader(
    BuildContext context, MyOffersController controller) {
  print('ABC Check 1234 ${controller.isLoading.value}');

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "My Offers ",
          style: StyleResource.instance.styleSemiBold(
              DimensionResource.fontSizeDoubleOverExtraLarge,
              ColorResource.white),
        )),
  );
}

Widget _buildMyOffersBody(BuildContext context, MyOffersController controller) {
  print('ABC Check ${controller.isLoading.value}');
  return Obx(
    () => controller.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(
              color: ColorResource.mainColor,
            ),
          )
        : ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            children: [
              Center(
                child: CommonButton(
                  text: "Create Offers",
                  loading: false,
                  onPressed: () => Get.toNamed(Routes.createOffersScreen),
                  color: ColorResource.white,
                  textColor: ColorResource.orangeColor,
                  width: 200,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ...List.generate(
                controller.offerList.length,
                ((index) => _buildOffersBoxUi(
                      image: ImageResource.instance.offer2Icon,
                      discountTitle:
                          controller.offerList[index].description ?? "-",
                      code: controller.offerList[index].couponCode ?? "-",
                      context: context,
                      controller: controller,
                      offerId: controller.offerList[index].id ?? '',
                    )),
              ),
            ],
          ),
  );
}

Widget _buildOffersBoxUi({
  required String image,
  required String discountTitle,
  required String code,
  required BuildContext context,
  required MyOffersController controller,
  required String offerId,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorResource.white,
        boxShadow: DecorationResource.instance.containerBoxShadow()),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            height: 50,
            width: 100,
            child: cachedNetworkImage(image, fit: BoxFit.contain)),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              discountTitle,
              style: StyleResource.instance.styleMedium(
                  DimensionResource.fontSizeExtraLarge,
                  ColorResource.orangeColor),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                // Copy the text to the clipboard when tapped
                Clipboard.setData(ClipboardData(text: code));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Text copied to clipboard')),
                );
              },
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(6)),
                child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(6),
                    dashPattern: const [2, 2],
                    color: ColorResource.black,
                    strokeWidth: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          Text(
                            code,
                            style: StyleResource.instance.styleSemiBold(
                                DimensionResource.fontSizeSmall,
                                ColorResource.textColor),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.copy,
                            size: 15,
                            color: ColorResource.black,
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                // Copy the text to the clipboard when tapped
                Clipboard.setData(ClipboardData(text: code));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Text copied to clipboard')),
                );
              },
              child: const Icon(
                Icons.edit,
                size: 25,
                color: ColorResource.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                controller.isLoading.value = true;
                controller.offersService
                    .deleteOffer(offerId)
                    .then((value) => null);
                controller.offersService.deleteOffer(offerId).then((response) {
                  if (response.code != 200) {
                    controller.isLoading.value = false;
                    toastShow(error: true, massage: response.errorMessage);
                  } else {
                    controller.isLoading.value = false;
                    controller.offerList = [];
                    controller.getOffers();
                    toastShow(error: false, massage: response.successMessage);
                  }
                });
              },
              child: const Icon(
                Icons.delete_outline,
                size: 25,
                color: ColorResource.darkRed,
              ),
            )
          ],
        )
      ],
    ),
  );
}
