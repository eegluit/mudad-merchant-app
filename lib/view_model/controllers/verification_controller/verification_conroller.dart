import 'dart:convert';
import 'dart:developer';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_document_reader_api/document_reader.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/services/auth_service.dart';
import 'package:mudad_merchant/view/widgets/image_picker/image_selection_util.dart';
import 'package:mudad_merchant/view_model/routes/app_pages.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_face_api/face_api.dart' as Regula;
import '../../../model/network_calls/api_helper/provider_helper/auth_provider.dart';
import '../../../model/network_calls/api_helper/provider_helper/kyc_provider.dart';
import '../../../model/network_calls/dio_client/get_it_instance.dart';
import '../../../view/screens/auth_view/verification_view/view_holder/identity_view.dart';
import '../../../view/screens/auth_view/verification_view/view_holder/selecte_id_view.dart';
import '../../../view/screens/auth_view/verification_view/view_holder/selfie_view.dart';
import '../../../view/screens/auth_view/verification_view/view_holder/verification_process_view.dart';
import '../../../view/widgets/log_print/log_print_condition.dart';
import '../../../view/widgets/toast_view/showtoast.dart';
import '../../model/select_type_model.dart';

class VerificationController extends GetxController{
  KycProvider kycProvider = getIt();
  AuthProvider authProvider = getIt();
  var isLoading = false.obs;
  RxBool isInitialise = false.obs;
  RxMap<String,dynamic> documentMap = <String,dynamic>{}.obs;
  List<String> verifyIdentityList = <String>[
    'Your identification document',
    'A quick selfie',
  ];
  List<SelectTypeModel> typeList = [
    SelectTypeModel(
      id: 1,
      name: "Passport",
    ),
    SelectTypeModel(
      id: 2,
      name: "ID Card",
    ),
    SelectTypeModel(
      id: 3,
      name: "Drivers License",
    ),
  ];
  var typeId = 0.obs;
  List<Widget> verifyWidgetList = <Widget>[
    const IdentityWidget(),
    const SelectIdWidget(),
    const SelfieWidget(),
    const VerificationProcessWidget()
  ];
  RxInt currentStep = 1.obs;
  RxInt selectedId = (-1).obs;
  RxBool isVerified = true.obs;
  Rx<io.File> selectedIdPic = io.File("").obs;
  Rx<io.File> selectSelfie = io.File("").obs;
  List<VerifyPage> verifyPageDataList = <VerifyPage>[
    VerifyPage(
        title: "Verify Your Identity",
        subTitle: "Simply use your phone camera to capture the following: "
    ),
    VerifyPage(
        title: "Select ID Type",
        subTitle: ""
    ),
    VerifyPage(
        title: "Take a Selfie",
        subTitle: "Place your face inside the oval and press start when you are ready"
    ),
    VerifyPage(
        title: "Verification\nProcess ",
        subTitle: ""
    ),
  ];

  late ImageSelectionUtil imageSelectionUtils = ImageSelectionUtil((String base64Image,io.File imageFiles) async {
    if(currentStep.value == 2){
      selectedIdPic.value = imageFiles;
    }else{
    selectSelfie.value = imageFiles;
    }
  });

  openSelfieCamera(){
   liveness();
  }

  /// on Verify Identity
  onVerifyIdentity(){
    currentStep.value = 2;
  }

  onUploadDocument()async{
    await kycProvider.uploadIdProof(documentMap, onError: (errorMessage){
      logPrint("errorMessage=> $errorMessage");
      toastShow(massage: errorMessage,error: true);
      isLoading.value = false;
    }, onSuccess: (message,data){
      isLoading.value = false;
      toastShow(massage: "Your document uploaded successfully.",error: false);
      currentStep.value = 3;
    });
  }

  onDocumentScan() {
    DocumentReader.showScanner().then((value) {
      log("val $value");

    });
  }

  onSelectId()async{
   if(isLoading.value==false){
     try {
       isLoading.value = true;
       await kycProvider.registerTap({"kycIdType":typeList[selectedId.value].name}, onError: (errorMessage){
         toastShow(massage: errorMessage,error: true);
         isLoading.value = false;
       }, onSuccess: (message,data)async{
         isLoading.value = false;
         onDocumentScan();
       });
     } catch (e) {
       isLoading.value = false;
       logPrint("this is login try error ${e.toString()}");
       toastShow(massage: "Something want wrong here.",error: true);

     }
   }

  }

  onTakeSelfie()async{


   if(selectSelfie.value.path != ""){
     onSkipNowButton();
   }else{
     liveness();
   }

  }
  onVerificationComplete()async{
    await authProvider.userProfile(onError:(errorMessage){}, onSuccess:(message,data)async{
      await Get.find<AuthService>().saveUser(data!);
      if(Get.find<AuthService>().user.value.storeRegistered==false || Get.find<AuthService>().user.value.storeRegistered==null){
        Get.toNamed(Routes.storeRegistrationScreen);
      }else{
        Get.toNamed(Routes.rootView);
      }
      isLoading.value = false;
    });

  }

  Rx<Uint8List> imageUint8ListData = Uint8List(0).obs;

  liveness() {
    logPrint("face sdk error ");
    try{
      Regula.FaceSDK.startLiveness().then((value) async {
        //log("facesdk result ${value}");
        var result = Regula.LivenessResponse.fromJson(json.decode(value));
        if (result!.bitmap == null) return;
        //log("facesdk result ${result?.bitmap}");
        //setImage(base64Decode(result.bitmap!.replaceAll("\n", "")));
        imageUint8ListData.value = base64Decode(result.bitmap!.replaceAll("\n", ""));
        log("imageUint8ListData ${imageUint8ListData.value}");
        try{
          io.Directory path = await getApplicationDocumentsDirectory();
          log("imageUint8ListData path ${path}");
          io.File("${path.path}/${DateTime.now().millisecondsSinceEpoch}.png").writeAsBytes(imageUint8ListData.value).then((value) {
            logPrint("valaue image ${value.path}");
            selectSelfie.value = value;
          });
        }catch(e){
          logPrint("error $e");
        }
        // setState(() => _liveness =
        // result.liveness == Regula.LivenessStatus.PASSED
        //     ? "passed"
        //     : "unknown");
      }).onError((error, stackTrace) {
        logPrint("face sdk error $error");
      });
    }catch(e){
      log("startLiveness $e");
    }
  }

  onSkipNowButton() async {
    if(isLoading.value==false){
      if(selectSelfie.value.path == ""){
        openSelfieCamera();
      }else{
        isLoading.value=true;
        await kycProvider.selfieUpload({"file": selectSelfie.value}, onError: (errorMessage){
          logPrint("errorMessage=> $errorMessage");
          toastShow(massage: errorMessage,error: true);
          isLoading.value = false;
        }, onSuccess: (message,data){
          toastShow(massage: "Your selfie uploaded successfully.",error: false);
          currentStep.value = 4;
          isLoading.value = false;
        });
      }
    }
  }

  RxString selectedScenario = "FullProcess".obs;

  Future<void> initPlatformState() async {
    isInitialise.value = false;

    DocumentReader.prepareDatabase("Full").then((s) {
      // do something
    }).catchError((Object error) =>
        log("error rer ${(error as PlatformException).message ?? ""}"));
    log("Initializing...");
    ByteData byteData = await rootBundle.load("assets/regula.license");

    DocumentReader.initializeReader({
      "license": base64.encode(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)),
      "delayedNNLoad": true
    }).then((s) {
      log(s);
      isInitialise.value = true;
    }).catchError((Object error) async {
      log((error as PlatformException).message ?? "");
      log("error rer ${(error as PlatformException).message ?? ""}");
    });

    log("Ready");

    await DocumentReader.setConfig({
      "functionality": {
        "videoCaptureMotionControl": true,
        "showCaptureButton": true
      },
      "customization": {
        "showResultStatusMessages": true,
        "showStatusMessages": true
      },
      "processParams": {
        "scenario": selectedScenario.value,
        "doublePageSpread": true
      }
    });

    List<List<String>> scenarios = [];
    var scenariosTemp =
    json.decode(await DocumentReader.getAvailableScenarios());
    for (var i = 0; i < scenariosTemp.length; i++) {
      DocumentReaderScenario scenario = DocumentReaderScenario.fromJson(
          scenariosTemp[i] is String
              ? json.decode(scenariosTemp[i])
              : scenariosTemp[i])!;
      log("scenariosTemp ${scenario.name}");
      scenarios.add([scenario.name!, scenario.caption!]);
    }

    Regula.FaceSDK.init().then((json) {
      var response = jsonDecode(json);
      if (!response["success"]) {
        print("Init failed: ");
        print(json);
      }
    });

    // const EventChannel('flutter_face_api/event/livenessNotification')
    //     .receiveBroadcastStream()
    //     .listen((event) {
    //   var notification =
    //   Regula.LivenessNotification.fromJson(json.decode(event));
    //   print("LivenessProcessStatus: ${notification!.status}");
    // });
  }

  Rx<Regula.MatchFacesImage> image1 = Regula.MatchFacesImage().obs;
  Rx<Image> img1 = Image.asset('assets/images/portrait.png').obs;


  setImage( Uint8List? imageFile) async {
    try{
      io.File(await getDirectoryPath()).writeAsBytes(imageFile!).then((value) {
        logPrint("valaue image ${value.path}");
        selectSelfie.value = value;
      });
    }catch(e){
      logPrint("valaue image error $e");
    }
  }

  saveImage() async {
    // TakeSelfieController selfieController =
    // Get.find<TakeSelfieController>();
    // var token = Get.find<AuthServices>().getUserToken();
    // selfieController.kycService
    //     .submitKycSelfie(
    //     selectSelfie.value,
    //     token)
    //     .then((response) {
    //   logPrint("response ${response.toJson()}");
    //   if (response.code != 200) {
    //     toastShow(
    //         error: true,
    //         massage: response.message);
    //   } else {
    //     currentStep.value = 4;
    //     //controller.onSelectId();
    //   }
    // });
  }

  Future<String> getDirectoryPath()async{
    io.Directory tempDir = await getApplicationDocumentsDirectory();

    // Directory path = Directory('${tempDir.path}/${DateTime.now().millisecond}.png');

    /// if folder exists in four phone memory.
    if ((await tempDir.exists())) {
      //download call
      return tempDir.path;
    } else {
      /// Create folder in your memory.
      io.Directory? newPath = await tempDir.create();
      return newPath.path;
    }
  }

  runAutoUpdate() {
    DocumentReader.runAutoUpdate("Full").then((s) {
      // do something
    }).catchError(
            (Object error) => print((error as PlatformException).message));
  }

  @override
  void onClose() {
    // TODO: implement onClose
    DocumentReader.removeDatabase().then((str) {
      print('Removed');
    }).catchError(
            (Object error) => print((error as PlatformException).message));

    DocumentReader.cancelDBUpdate().then((str) {
      print('Cancelled');
    }).catchError(
            (Object error) => print((error as PlatformException).message));
    super.onClose();
  }

  @override
  void onInit() {
    runAutoUpdate();
    initPlatformState();
    const EventChannel('flutter_document_reader_api/event/completion')
        .receiveBroadcastStream()
        .listen((jsonString) => handleCompletion(
        DocumentReaderCompletion.fromJson(json.decode(jsonString)) ??
            DocumentReaderCompletion()));
    super.onInit();
  }

  void handleCompletion(DocumentReaderCompletion completion) {
    //handleResults(completion.results!);
    log("status ${completion.action}");
    if (completion.action == DocReaderAction.COMPLETE) {
      handleResults(completion.results!);
    } else if (completion.action == DocReaderAction.CANCEL) {
      toastShow(massage: "Cancelled");
    } else if (completion.action == DocReaderAction.TIMEOUT) {
      toastShow(massage: "Timeout !!! Please try again");
    } else if (completion.action == DocReaderAction.ERROR) {
      toastShow(massage: " ${completion.error?.message ?? ""}");
    }
  }

  Future<void> handleResults(DocumentReaderResults results) async {
    log("DocumentReaderResults ${results.rawResult}");
    log("DocumentReaderResults ${results.authenticityResult}");


    results.graphicFieldImageByType(EGraphicFieldType.GF_DOCUMENT_IMAGE).then((value) {
      //log("image Get ${value?.path.}");
      try{

        // log("converted image $image");
      }catch(e){
        log("error r $e");
      }

    });


    for(DocumentReaderGraphicField? graphicsField in results.graphicResult?.fields??[]){
      log("graphicsField ${graphicsField?.toJson()}");

      log("graphicsField  ${(graphicsField?.fieldName??"") + ', value: ' + (graphicsField?.value??"") + ', source: '}");
      documentMap.clear();
      if((graphicsField?.fieldName??"") == "Document image"){
        //Uint8List image = base64Decode((graphicsField?.value??"").replaceAll("\n", ""));
        // documentMap.addAll({"document_image" : image});
        Uint8List image = base64Decode((graphicsField?.value??"").replaceAll("\n", ""));
        //log("imageUint8ListData ${imageUint8ListData.value}");
        try{
          io.Directory path = await getApplicationDocumentsDirectory();
          log("imageUint8ListData path ${path}");
          io.File("${path.path}/${DateTime.now().millisecondsSinceEpoch}.png").writeAsBytes(image).then((value) {
            logPrint("valaue image ${value.path}");
            selectedIdPic.value = value;
          });
        }catch(e){
          logPrint("error $e");
        }
        // log("pathOfImage $pathOfImage");
        // final Uint8List bytes = pathOfImage..buffer.asUint8List();
        // await pathOfImage.writeAsBytes(bytes);
      }
    }

    for (var textField in results.textResult?.fields??[]) {
      for (var value in textField.values) {
        log(textField.fieldName +
            ', value: ' +
            value.value +
            ', source: ' +
            value.sourceType.toString());
        documentMap.addAll({textField.fieldName : value.value});
      }
    }
    log("documentMap ${documentMap.toString()}");
    log("ducument json $documentMap");
    if(documentMap.isNotEmpty){
      currentStep.value = 2;
    }
  }
}


class VerifyPage {
  final String title;
  final String subTitle;

  VerifyPage({required this.title,required this.subTitle});

}