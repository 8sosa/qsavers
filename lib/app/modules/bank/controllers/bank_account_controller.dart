import "package:quantity_savers/app/modules/Details/models/details_request_model.dart";
import "package:quantity_savers/app/modules/bank/models/response_model/add_bank_response_model.dart";
import "package:quantity_savers/app/modules/bank/models/response_model/country_selection_response_model.dart";
import "package:quantity_savers/app/modules/bank/models/response_model/default_bank_response_model.dart";
import "package:quantity_savers/app/modules/bank/models/response_model/delete_bank_response_model.dart";

import "../../../export.dart";
import "../models/response_model/country_details_response_model.dart";

class BankAccountController extends GetxController {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  bool isForSelectedBank = false;
  AddBankResponseModel addBankResponseModel = AddBankResponseModel();
  DefaultBankResponseModel defaultBankResponseModel =
      DefaultBankResponseModel();
  CountrySelectionResponseModel countrySelectionResponseModel =
      CountrySelectionResponseModel();
  CountryDetailResponseModel countryDetailResponseModel =
      CountryDetailResponseModel();
  DeleteBankResponseModel deleteBankResponseModel = DeleteBankResponseModel();
  bool isLoading = false;
  var countryCode;
  var countryZipCode;
  var currency;

  List<String> countryNames = [];
  List<CountryDataModel> countryDataList = [];
  List<String> paymentMethods = [];
  List<String> paymentsMethodSelectedCountry=[];

  RxString? selectedQuantityValue = "".obs;
  RxString? selectedPaymentMethod = "".obs;
  RxString? selectedCountryPaymentMethod = "".obs;
  onChangeDropDownValueQuantity(String? str) async {
    selectedQuantityValue?.value = str ?? "";
    paymentMethods.clear();
    updatePaymentMethods();
    debugPrint("Selected Country is ${selectedQuantityValue?.value}");
    update();
  }

  onChangeSelectedPaymentMethod(String? str) async {
    selectedPaymentMethod?.value = str ?? "";
    update();
  }

  void updatePaymentMethods() {
    var selectedCountryData = countryDataList.firstWhere(
        (country) => country.country == selectedQuantityValue?.value);

    paymentMethods = [];
    if (selectedCountryData.paypal ?? false) paymentMethods.add('PayPal');
    if (selectedCountryData.flutterwave ?? false)
      paymentMethods.add('Flutterwave');
    if (selectedCountryData.stripe ?? false) paymentMethods.add('Stripe');
    if (selectedCountryData.contactAdmin ?? false)
      paymentMethods.add('Contact Admin');

    if (selectedCountryData.sId != null) {
      countryCode = selectedCountryData.sId;
    }
    if (selectedCountryData.countryCode != null) {
      countryZipCode = selectedCountryData.countryCode;
    }
    if (selectedCountryData.currency != null) {
      currency = selectedCountryData.currency;
    }

    if (paymentMethods.isEmpty) {
      paymentMethods.add('Contact Admin');
    }
    selectedPaymentMethod?.value = paymentMethods.first;
    update();
  }

  void setPaymentMethodSelectedCountry()
  {
    if(countryDetailResponseModel.data?.data?.flutterwave ?? false)
      {
        paymentsMethodSelectedCountry.add('Flutterwave');
      }
    if(countryDetailResponseModel.data?.data?.paypal ?? false)
    {
      paymentsMethodSelectedCountry.add('PayPal');
    }
    if(countryDetailResponseModel.data?.data?.stripe ?? false)
    {
      paymentsMethodSelectedCountry.add('Stripe');
    }
    if(countryDetailResponseModel.data?.data?.contactAdmin ?? false)
    {
      paymentsMethodSelectedCountry.add('Contact Admin');
    }

    if (paymentsMethodSelectedCountry.isEmpty) {
      paymentsMethodSelectedCountry.add('Contact Admin');
    }
    selectedCountryPaymentMethod?.value = paymentsMethodSelectedCountry.first;
    update();
  }

  onChangeSelectedCountryPaymentMethod(String? str) async {
    selectedCountryPaymentMethod?.value = str ?? "";
    update();
  }

  @override
  void onInit() {
    hitGetCountryList(); //Payout
    super.onInit();
  }

  void showLoaderForDuration() {
    isLoading = true;
    update();
    Future.delayed(Duration(seconds: 3), () {
      isLoading = false;
      update();
    });
  }

  onSelectedCountry(int tempIndex, var country) async {
    if (tempIndex != null && tempIndex != -1) {
      selectedQuantityValue?.value = country;
      paymentMethods.clear();
      updatePaymentMethods();
      update();
    }
  }

  hitGetCountryList() {
    isLoading = true;
    _apiRepository.listCountriesApiCall(queryBody: {}).then((value) async {
      if (value != null) {
        countrySelectionResponseModel = value;
        List<CountryDataModel> newDataList =
            countrySelectionResponseModel.data?.data ?? [];
        newDataList.forEach((newCountry) {
          if (!countryDataList.any((existingCountry) =>
              existingCountry.country == newCountry.country)) {
            countryDataList.add(newCountry);
            countryNames.add(newCountry.country ?? "");
          }
        });
        Future.delayed(Duration(seconds: 6), () {
          isLoading = false;
          update();
        });
        debugPrint("The country Names is $countryNames");
        hitGetBankAccountsApi();
        update();
      }
    }).onError((error, stackTrace) {
      isLoading = false;
      debugPrint("error $stackTrace");
      showToast(message: error.toString());
    });
  }

  hitGetCountryDetailsApi() async {
    _apiRepository.getCountryDetailsApiCall(
        queryBody: {},
        id: addBankResponseModel.data?.data?[0].country_id).then((value) async {
      if (value != null) {
        countryDetailResponseModel = value;
        paymentsMethodSelectedCountry.clear();
        setPaymentMethodSelectedCountry();
        isLoading = false;
        update();
      }
    }).onError((error, stackTrace) {
      isLoading = false;
      debugPrint("error $stackTrace");
      showToast(message: error.toString());
    });
  }

  hitGetBankAccountsApi() {
    isLoading = true;
    _apiRepository.listBankAccountsApiCall(queryBody: {}).then((value) async {
      if (value != null) {
        addBankResponseModel = value;
          isLoading = false;
          update();
      }
    }).onError((error, stackTrace) {
      isLoading = false;
      debugPrint("error $stackTrace");
      showToast(message: error.toString());
    });
  }

  hitDeleteBankAccountApi(String sid) {
    debugPrint("Sid is $sid");

    Map<String, dynamic> requestModel =
        DetailsRequestModel.deleteBankAccountRequestModel(id: sid);
    _apiRepository
        .deleteBankAccountsApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        deleteBankResponseModel = value;
        hitGetBankAccountsApi();
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitDefaultBankAccountApi(String sid) {
    isLoading = true;
    debugPrint("Sids is $sid");
    Map<String, dynamic> requestModel =
        DetailsRequestModel.deleteBankAccountRequestModel(id: sid);

    _apiRepository
        .defaultBankAccountsApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        defaultBankResponseModel = value;
        hitGetBankAccountsApi();
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }
}
