import 'package:quantity_savers/app/modules/Details/models/details_request_model.dart';
import 'package:quantity_savers/app/modules/manage_address/models/addresses_requests_model.dart';
import 'package:quantity_savers/app/modules/manage_address/models/responce_models/defaultAddress_response_model.dart';
import 'package:quantity_savers/app/modules/manage_address/models/responce_models/delete_address_response_model.dart';

import '../../../export.dart';

class ManageAddressController extends GetxController {
  bool isForSelectAddress = true;
  var isLoading = true;
  bool isPagination = false;
  var page = 0;
  var currentPage = 0;
  var limit = 10;
  var addressId = "";
  int? selectedAddress;
  bool isForCampaign = false;

  ScrollController scrollController = ScrollController();

  /*JoinedCampaignDetailResponseModel? joinedCampaignDetailResponseModel =
      Get.find<CheckoutItemController>().joinedCampaignDetailResponseModel;*/

  /* CartDataResponseModel? cartDataResponseModel =
      Get.find<CheckoutItemController>().cartDataResponseModel;
  PriceDetailsResponseModel? priceDetailsResponseModel =
      Get.find<CheckoutItemController>().priceDetailsResponseModel;*/
  ManageAddressResponseModel? manageAddressResponseModel =
      ManageAddressResponseModel();
  DeleteAddressResponseModel deleteAddressResponseModel =
      DeleteAddressResponseModel();
  final APIRepository _apiRepository = Get.find<APIRepository>();
  DefaultAddressResponseModel defaultAddressResponseModel =
      DefaultAddressResponseModel();

  @override
  void onInit() {
    lightTheme(color: AppColors.appColor);
    getAddressDataApiCall();
    getArguments();
    scrollController.addListener(() {
      _scrollListener();
    });
    super.onInit();
  }

  getArguments() {
    if (Get.arguments != null) {
      isForCampaign = Get.arguments[argIsRouteFromCampaignOrder] ?? false;
      isForSelectAddress = Get.arguments[argIsForSelectAddress];
      update();
    }
  }

  getAddressDataApiCall() async {
    currentPage = page;
    debugPrint("page : $page");
    isLoading = page == 0 ? true : false;
    isPagination = page > 0 ? true : false;
    update();
    var requestModel = HomepageRequestModel.productCategoriesRequestModel(
      id: addressId ?? "",
      pagination: page,
    );
    _apiRepository
        .getAddressesApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        if (page == 0) {
          manageAddressResponseModel = value;
        } else {
          if ((value?.data?.data.length ?? 0) != 0) {
            manageAddressResponseModel?.data?.data
                ?.addAll(value?.data?.data ?? []);
          }
        }
        if ((value?.data?.data.length ?? 0) == 10) {
          page += 1;
        }
      }
      isLoading = false;
      isPagination = false;
      update();
    }).onError((error, stackTrace) {
      isLoading = false;
      isPagination = false;
      update();
      showToast(message: error.toString());
    });
  }

  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (page > currentPage) {
        getAddressDataApiCall();
      }
      debugPrint("reach the bottom");
    }
  }

  hitDeleteAddresApi(String? id) {
    Map<String, dynamic>? requestModel =
        AddressesRequestModel.deleteAddressRequestModel(id: id);
    _apiRepository
        .deleteAddressRequestApiCall(dataBody: requestModel)
        .then((value) {
      if (value != null) {
        deleteAddressResponseModel = value;
        showToast(message: deleteAddressResponseModel.data?.message);
        getAddressDataApiCall();
        update();
      }
    }).onError((error, stackTrace) {
      update();
      showToast(message: error.toString());
    });
  }

  hitDefaultAddressApi(String? addressId) {
    Map<String, dynamic> requestModel =
        DetailsRequestModel.defaultAddressRequestModel(addressId: addressId);
    _apiRepository
        .defaultAddressApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        defaultAddressResponseModel = value;
        getAddressDataApiCall();
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }
}
