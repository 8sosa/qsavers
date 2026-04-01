import "package:quantity_savers/app/modules/manage_address/models/addresses_requests_model.dart";
import "package:quantity_savers/app/modules/manage_address/models/responce_models/addAddress_responce_model.dart";
import "package:quantity_savers/app/modules/manage_address/models/responce_models/defaultAddress_response_model.dart";

import "../../../export.dart";

class AddNewAddressController extends GetxController {
  final GlobalKey<FormState> addNewAddressFormGlobalKey =
      GlobalKey<FormState>();
  late int selectedAddressType = 1;
  var lat = 0.0;
  var lng = 0.0;
  String addressId = "";
  var isRouteForEditManageAddress = false;
  final APIRepository _apiRepository = Get.find<APIRepository>();
  ManageAddressController? manageAddressController;
  AddAddressResponceModel? addAddressResponseModel = AddAddressResponceModel();
  ManageAddressDataSubData manageAddressDataSubData =
      ManageAddressDataSubData();
  ManageAddressResponseModel manageAddressResponseModel =
      ManageAddressResponseModel();

  @override
  void onInit() {
    if (Get.isRegistered<ManageAddressController>()) {
      manageAddressController = Get.find<ManageAddressController>();
    }
    lightTheme(color: AppColors.appColor);
    super.onInit();
    getArguments();
  }

  getArguments() {
    if (Get.arguments != null) {
      isRouteForEditManageAddress =
          Get.arguments[argIsRouteForEditManageAddress] ?? false;
      addressId = Get.arguments[argId] ?? '';
      manageAddressDataSubData =
          Get.arguments[argIsRouteForEditManageAddressData] ?? '';
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameFocusNode?.dispose();
    lastnameFocusNode?.dispose();
    mobileNumberFocusNode?.dispose();
    super.dispose();
  }

  TextEditingController nameTextController = TextEditingController();
  TextEditingController lastnameTextController = TextEditingController();
  TextEditingController mobileNumberTextController = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController addressTextController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateTextController = TextEditingController();
  TextEditingController pinTextController = TextEditingController();
  TextEditingController apartmentNumberTextController = TextEditingController();

  FocusNode? nameFocusNode = FocusNode();
  FocusNode? lastnameFocusNode = FocusNode();
  FocusNode? mobileNumberFocusNode = FocusNode();
  FocusNode? companyNameFocusNode = FocusNode();
  FocusNode? addressFocusNode = FocusNode();
  FocusNode? countryFocusNode = FocusNode();
  FocusNode? cityFocusNode = FocusNode();
  FocusNode? stateFocusNode = FocusNode();
  FocusNode? pinFocusNode = FocusNode();
  FocusNode? apartmentNumberFocusNode = FocusNode();

  // var selectedCountry = const Country(
  //   name: "India",
  //   flag: "🇮🇳",
  //   code: "IN",
  //   dialCode: "91",
  //   minLength: 10,
  //   maxLength: 10,
  //   nameTranslations: {},
  // );
  var selectedCountry = const Country(
    name: "United Kingdom",
    flag: "🇬🇧",
    code: "GB",
    dialCode: "44",
    minLength: 8,
    maxLength: 15,
    nameTranslations: {},
  );



  hitAddAddressApi() {
    debugPrint("Selected country is ${selectedCountry.dialCode}");
    var addresstype = "";
    if (selectedAddressType == 1) {
      addresstype = "Home".toUpperCase();
    } else {
      addresstype = "Work".toUpperCase();
    }
    Map<String, dynamic> requestModel =
        AddressesRequestModel.addAddressRequestModel(
            name: "${nameTextController.text} ${lastnameTextController.text}",
            phoneNo: mobileNumberTextController.text,
            company: companyName.text,
            countryCode: "+${selectedCountry.dialCode}",
            fullAddress: addressTextController.text,
            country: countryController.text,
            city: cityController.text,
            state: stateTextController.text,
            pinCode: pinTextController.text,
            apartmentNumber: apartmentNumberTextController.text,
            addressType: addresstype,
            lat: "$lat",
            lng: "$lng");
    _apiRepository.addAddressApiCall(queryBody: requestModel).then((value) {
      if (value != null) {
        addAddressResponseModel = value;
        manageAddressController?.getAddressDataApiCall();
        Get.back();
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitEditAddressApi() {
    var addresstype = "";
    if (selectedAddressType == 1) {
      addresstype = "Home".toUpperCase();
    } else {
      addresstype = "Work".toUpperCase();
    }
    Map<String, dynamic> requestModel =
        AddressesRequestModel.addAddressRequestModel(
            id: addressId,
            name: "${nameTextController.text} ${lastnameTextController.text}",
            phoneNo: mobileNumberTextController.text,
            company: companyName.text,
            countryCode: "+${selectedCountry.dialCode}",
            fullAddress: addressTextController.text,
            country: countryController.text,
            city: cityController.text,
            state: stateTextController.text,
            pinCode: pinTextController.text,
            apartmentNumber: apartmentNumberTextController.text,
            addressType: addresstype,
            lat: "$lat",
            lng: "$lng");
    _apiRepository.editAddressApiCall(queryBody: requestModel).then((value) {
      if (value != null) {
        addAddressResponseModel = value;
        manageAddressController?.getAddressDataApiCall();
        Get.back(result: true);
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }
}
