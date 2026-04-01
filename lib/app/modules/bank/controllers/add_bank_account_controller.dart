import "package:quantity_savers/app/modules/bank/controllers/bank_account_controller.dart";
import "package:quantity_savers/app/modules/bank/models/add_bank_request_model.dart";
import "package:quantity_savers/app/modules/bank/models/response_model/add_bank_response_model.dart";
import "package:quantity_savers/app/modules/bank/models/response_model/flwPayPalContactAdminResponseModel.dart";

import "../../../export.dart";

class AddBankAccountController extends GetxController {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  String docImagePath = "";
  String selectedCountry = "";
  String selectedCurrency = "";
  bool isAlreadyAdded = false;
  var bankType;
  var country;
  var countryCode;
  bool isLoading = false;
  var countryZipCode;
  var currency;
  late int day;
  late int month;
  late int year;
  List<String> countryList = ["US", "CAN", "UK"];
  List<String> currencyList = ["USD", "CAD", "GBP (Pound)"];
  TextEditingController datePickerController = TextEditingController();
  TextEditingController holderNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController countryZipCodeController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController routingNumberController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController contactAdminController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController payPalEmailController = TextEditingController();
  TextEditingController accountHolderNameController = TextEditingController();
  TextEditingController flutterWaveAccountNumberController =
      TextEditingController();
  TextEditingController flutterWaveAccessBankController =
      TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController ssnNumberController = TextEditingController();
  TextEditingController mccNumberController = TextEditingController();
  TextEditingController taxNumberController = TextEditingController();
  ImageResposemodel? videoUploadResponse = ImageResposemodel();
  ImageResposemodel? imageUploadResponse = ImageResposemodel();

  FocusNode? holderNameFocusNode = FocusNode();
  FocusNode? accountNumberFocusNode = FocusNode();
  FocusNode? routingNumberFocusNode = FocusNode();
  FocusNode? firstNameFocusNode = FocusNode();
  FocusNode? lastNameFocusNode = FocusNode();
  FocusNode? emailFocusNode = FocusNode();
  FocusNode? payPalFocusNode = FocusNode();
  FocusNode? contactAdminFocusNode = FocusNode();
  FocusNode? flutterWaveAccountNoFocusNode = FocusNode();
  FocusNode? flutterWaveAccessBankFocusNode = FocusNode();
  FocusNode? phoneNumberFocusNode = FocusNode();
  FocusNode? addressFocusNode = FocusNode();
  FocusNode? cityFocusNode = FocusNode();
  FocusNode? stateFocusNode = FocusNode();
  FocusNode? postalCodeFocusNode = FocusNode();
  FocusNode? ssNumberFocusNode = FocusNode();
  FocusNode? mccNumberFocusNode = FocusNode();
  FocusNode? taxNumberFocusNode = FocusNode();
  FocusNode? accountHolderNameFocusNode = FocusNode();
  FocusNode? countryFocusNode = FocusNode();
  FocusNode? countryZipFocusNode = FocusNode();
  FocusNode? currencyFocusNode = FocusNode();

  AddBankResponseModel addBankResponseModel = AddBankResponseModel();
  FlwPayPalConatctAdminBankResponseModel
      flwPayPalConatctAdminBankResponseModel =
      FlwPayPalConatctAdminBankResponseModel();
  BankAccountController? bankAccountController;

  @override
  void onInit() {
    if (Get.isRegistered<BankAccountController>()) {
      bankAccountController = Get.find<BankAccountController>();
    }
    lightTheme(color: AppColors.appColor);
    getArguments();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    holderNameFocusNode?.dispose();
    accountNumberFocusNode?.dispose();
    routingNumberFocusNode?.dispose();
    firstNameFocusNode?.dispose();
    lastNameFocusNode?.dispose();
    emailFocusNode?.dispose();
    phoneNumberFocusNode?.dispose();
    addressFocusNode?.dispose();
    cityFocusNode?.dispose();
    stateFocusNode?.dispose();
    postalCodeFocusNode?.dispose();
    ssNumberFocusNode?.dispose();
    mccNumberFocusNode?.dispose();
    taxNumberFocusNode?.dispose();
    super.dispose();
  }

  getArguments() {
    if (Get.arguments != null) {
      bankType = Get.arguments[argBankType] ?? "";
      if (bankType == "Stripe" && Get.arguments[argStripe]==false) {
        isAlreadyAdded = Get.arguments[argForAddBank] ?? false;
        debugPrint("This does not invoked");
      }
      country = Get.arguments[argCountry] ?? "";
      countryZipCode=Get.arguments[argCountryZipCode] ?? "";
      currency=Get.arguments[argCurrency] ?? "";
      debugPrint("countryZipCode $countryZipCode");
      currencyController.text=currency;
      countryZipCodeController.text=countryZipCode;
      countryCode = Get.arguments[argCountryId] ?? "";
      if (country != null) {
        countryController.text = country;
      }
      debugPrint("bankType is $bankType");
      update();
      // addressId = Get.arguments[argAddressId];
    }
  }

  onCountryChangeDropDownValue(String? value) async {
    selectedCountry = value ?? "";
    update();
  }

  onCurrencyChangeDropDownValue(String? value) async {
    selectedCurrency = value ?? "";
    update();
  }

  onDateChange() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.overlayContext!,
        firstDate: DateTime(1995),
        lastDate: DateTime.now(),
        initialDate: DateTime.now());
    if (pickedDate == null) return;
    datePickerController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    day = pickedDate.day;
    month = pickedDate.month;
    year = pickedDate.year;
  }

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      docImagePath = result.files.single.path!;
      update();
    } else {
      // User canceled the picker
    }
  }

  hitAddFlwPayPalContactAdminBank(
      {String? userCountry,
      String? contactAdminDetails,
      String? banktype,
      String? name,
      String? accNo,
      String? paypalAccountEmail,
      String? ssnNo}) async {
    isLoading = true;
    Map<String, dynamic> requestModel =
        BankRequestModel.addFlwPayPalContactAdminBankRequestModel(
            accountDetail: contactAdminDetails ?? "",
            country: userCountry ?? "",
            type: banktype ?? "",
            accountHolderName: name ?? "",
            accountNumber: accNo ?? "",
            payPalEmail: paypalAccountEmail ?? "",
            ssn: ssnNo ?? "",
            countryId: countryCode);
    _apiRepository
        .addFlwPayPalContactAdminBankApiCall(dataBody: requestModel)
        .then((value) {
      if (value != null) {
        flwPayPalConatctAdminBankResponseModel = value;
        bankAccountController?.hitGetBankAccountsApi();
        Get.back(result: true);
        showToast(message: "Bank added!");
        isLoading = false;
        update();
      }
    }).onError((error, stackTrace) {
      isLoading = false;
      showToast(message: error.toString());
    });
  }

  hitAddBankApiCall() async {
    isLoading = true;
    if (isAlreadyAdded) {
      imageUploadResponse = null;
    } else {
      imageUploadResponse =
          await _apiRepository.uploadImageAndVideoApi(docImagePath, "image");
    }
    Map<String, dynamic> requestModel = BankRequestModel.addBankRequestModel(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      phoneNumber: phoneNumberController.text,
      address: addressController.text,
      city: cityController.text,
      state: stateController.text,
      postalCode: postalCodeController.text,
      country:countryZipCode /*selectedCountry == "UK" ? "GB" : selectedCountry*/,
      currency: /*selectedCurrency*/currency,
      accountHolderName: holderNameController.text,
      ssnLastFour: ssnNumberController.text,
      routingNumber: routingNumberController.text,
      accountNumber: accountNumberController.text,
      mcc: mccNumberController.text,
      day: isAlreadyAdded ? 0 : day,
      month: isAlreadyAdded ? 0 : month,
      year: isAlreadyAdded ? 0 : year,
      taxId: isAlreadyAdded ? "" : taxNumberController.text,
      countryId: countryCode,
      frontImage: isAlreadyAdded
          ? ""
          : "https://quantitysavers-live.s3.amazonaws.com/quantitysavers-live/original/${imageUploadResponse?.data?.fileName ?? " "}",
    );
    _apiRepository.addBankApiCall(dataBody: requestModel).then((value) async {
      if (value != null) {
        addBankResponseModel = value;
        bankAccountController?.hitGetBankAccountsApi();
        Get.back(result: true);
        showToast(message: "Bank added!");
        isLoading = false;
        update();
      }
    }).onError((error, stackTrace) {
      isLoading = false;
      showToast(message: error.toString());
    });
  }
}
