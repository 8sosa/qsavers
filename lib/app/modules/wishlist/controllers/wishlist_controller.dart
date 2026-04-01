import "package:quantity_savers/app/modules/wishlist/models/wishlist_request_model.dart";

import "../../../export.dart";
import "../models/response_model/wishlist_response_model.dart";

class WishlistController extends GetxController {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  WishlistResponseModel? wishlistResponseModel = WishlistResponseModel();
  String wishlistType = "PRODUCT";
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getWishlistData();
    update();
  }

  getWishlistData([wishListType]) {
    Map<String, dynamic> queryModel =
        WishlistRequestModel.getWishlistRequestModel(type: wishlistType);
    _apiRepository
        .productsInWishlistApiCall(queryBody: queryModel)
        .then((value) async {
      if (value != null) {
        wishlistResponseModel = value;
        //showToast(message: "Item added to wishlist");
        isLoading = false;
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitDeleteFromWishlistApi(dynamic data) {
    _apiRepository
        .removeProductFromWishlistApiCall(productId: data)
        .then((value) async {
      if (value != null) {
        getWishlistData();
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  Future<void> refreshList() async {
    await Future.delayed(Duration(milliseconds: 1000));
   debugPrint("List is Refreshed");
   getWishlistData("PRODUCT");
  }

  Future<void> refreshCampaignList() async {
    await Future.delayed(Duration(milliseconds: 1000));
    debugPrint("List is Refreshed");
    getWishlistData("CAMPAIGN");
  }

}
