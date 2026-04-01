/*
 *
 *  * @copyright : Henceforth Pvt. Ltd. <info@henceforthsolutions.com>
 *  * @author     : Gaurav Negi
 *  * All Rights Reserved.
 *  * Proprietary and confidential :  All information contained herein is, and remains
 *  * the property of Henceforth Pvt. Ltd. and its partners.
 *  * Unauthorized copying of this file, via any medium is strictly prohibited.
 *  *
 *
 */

import "../../../export.dart";

class EditProfileController extends GetxController {
  List<Country> countryList = countries;
  final APIRepository _repository = Get.find<APIRepository>();
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  final GlobalKey<FormState> editProfileFormGlobalKey = GlobalKey<FormState>();
  final ImagePicker imagePicker = ImagePicker();

  dynamic image;
  bool editImage = false;
  bool dataUpdate = false;

  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController mobileNumberTextController = TextEditingController();
  LoginDataModel loginDataModel = LoginDataModel();
  LoginResponseModel loginResponseModel = LoginResponseModel();

  FocusNode? nameFocusNode = FocusNode();
  FocusNode? emailFocusNode = FocusNode();
  FocusNode? mobileNumberFocusNode = FocusNode();
  var type;

  var selectedCountry = const Country(
    name: "United Kingdom",
    flag: "🇬🇧",
    code: "GB",
    dialCode: "44",
    minLength: 8,
    maxLength: 15,
    nameTranslations: {},
  );

  @override
  void onInit() {
    // TODO: implement onInit
    getArguments();
    type = _localStorage.getSaveType();
    debugPrint("Type is $type");
    super.onInit();
  }

  selectImageFromGallary() async {
    final selectedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      image = selectedImage;
      debugPrint("Image is $image");
      editImage = true;
      Get.back();
    }
    update();
  }

  Future<PickedFile?> imageFromGallery() async {
    var pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile == null) {
      showToast(message: 'No Image Selected');
    } else {
      image = await cropImage(pickedFile.path);
      if(image!=null)
        {
          debugPrint("Image is $image");
          editImage=true;
          Get.back();
          update();
        }
      else
        {
          showToast(message: 'Image crop cancelled');
        }

    }
    update();
    return null;
  }

  Future<PickedFile?> cropImage(filePath) async {
    var croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.original],
    );
    if (croppedImage == null) {
      debugPrint("Nullllll");
    } else {
      debugPrint('The path is:${croppedImage.path}');
      return PickedFile(croppedImage.path);
    }
    return null;
  }

  Future<PickedFile?> imageFromCamera() async {
    var pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile == null) {
      showToast(message: 'No Image Selected');
    } else {
      image = await cropImage(pickedFile.path);
      if(image!=null)
        {
          debugPrint("Image is $image");
          editImage=true;
          Get.back();
          update();
        }
      else
      {
        showToast(message: 'Image cropping cancelled');
      }


    }
    update();
    return null;
  }

  selectImageFromCamera() async {
    final selectedImage =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (selectedImage != null) {
      image = selectedImage;
      editImage = true;
      Get.back();
    }
    update();
  }

  getArguments() {
    if (Get.arguments != null) {

      loginDataModel = Get.arguments[argProfileData];
      nameTextController.text = loginDataModel.name ?? "";
      emailTextController.text = loginDataModel.email ?? "";
      mobileNumberTextController.text = "${loginDataModel.phoneNo ?? 0}";
      debugPrint("Value of mobile number is ${mobileNumberTextController.text}");
      for (var element in countryList) {
        if ("+${element.dialCode}" == loginDataModel.countryCode) {
          selectedCountry = element;
        }
      }
      update();
    }
  }

  Future<void> hitUpdateProfileApiCall() async {
    try {
      final imageUploadResponse =
          await _repository.uploadImageApi(image, "image");
      if (imageUploadResponse != null) {
        ImageResposemodel ResponseModel = imageUploadResponse;
        Map<String, dynamic> requestModel =
            await ProfileRequestModel.editProfileRequestModel(
          // email:type==null? emailTextController.text.trim():null,
          phoneNo: int.parse(mobileNumberTextController.text.trim()),
          countryCode: "+${selectedCountry.dialCode}",
          name: nameTextController.text.trim(),
          profile_pic: ResponseModel?.data?.fileName ?? "",
          about: "",
          language: "ENGLISH",
        );
        await _repository
            .updateProfileApiCall(dataBody: requestModel)
            .then((value) {
          if (value != null) {

            loginResponseModel = value;
            saveDataToLocalStorage(loginResponseModel?.data);
            update();
            Get.back(result: true);
            showToast(message: "Profile updated successfully");
          }
        }).onError((error, stackTrace) {
          debugPrint("error $stackTrace");
          showToast(message: error.toString());
        });
      }
    } catch (error, stack) {
      debugPrint("error $stack");
      showToast(message: error.toString());
    }
  }

  Future<void> hitUpdateProfileWithoutImageApiCall() async {
    Map<String, dynamic> requestModel =
        await ProfileRequestModel.editProfileRequestModel(
      // email:type==null? emailTextController.text.trim():null,
      phoneNo: int.parse(mobileNumberTextController.text.trim()),
      countryCode: "+${selectedCountry.dialCode}",
      name: nameTextController.text.trim(),
      profile_pic: loginDataModel?.profilePic ?? "",
      about: "",
      language: "ENGLISH",
    );
    await _repository
        .updateProfileApiCall(dataBody: requestModel)
        .then((value) {
      if (value != null) {

        loginResponseModel = value;
        saveDataToLocalStorage(loginResponseModel?.data);
        update();
        Get.back(result: true);
        showToast(message: "Profile updated successfully");
      }
    }).onError((error, stackTrace) {
      debugPrint("error $stackTrace");
      showToast(message: error.toString());
    });
  }

  getDataFromLocalStorage() async {
    debugPrint("Work");
    loginDataModel = await _localStorage.getSavedLoginData();
    update();
  }

  saveDataToLocalStorage(LoginDataModel? loginData) async {
    _localStorage.saveRegisterData(loginData);
    _localStorage.saveAuthToken(loginData?.accessToken);
  }
}
