import 'package:get/get.dart';
import 'package:quantity_savers/app/modules/profile/models/response_model/available_coupon_response_model.dart';
import 'package:quantity_savers/app/modules/profile/models/response_model/expired_coupon_response_model.dart';

import '../../../export.dart';
import '../../Details/models/details_request_model.dart';

class CouponController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final APIRepository _repository = Get.find<APIRepository>();
  TabController? tabController;
  var currentIndex=0;
  AvailableCouponResponseModel availableCouponResponseModel=AvailableCouponResponseModel();
  ExpiredCouponResponseModel expiredCouponResponseModel =ExpiredCouponResponseModel();

  @override
  void onInit() {
    lightTheme(color: AppColors.appColor);
    tabController = TabController(vsync: this, length: 2);
    tabController?.addListener(() {
      debugPrint("selectedIndexUpdate ${tabController?.index}");
      currentIndex= tabController?.index??0;
      update();
    });
   getAvailableCoupons();
    super.onInit();
  }


  onTabChanged(int index) async {
    currentIndex = index;
    debugPrint("$index");
    if(currentIndex==0)
    {
      getAvailableCoupons();
    }
    else if(currentIndex==1)
    {
      getExpiredCoupons();
    }

    update();
  }

  getAvailableCoupons()
  {
    Map<String, dynamic> requestModel =
    DetailsRequestModel.couponsRequestModel(language: "ENGLISH");
    _repository.availableCouponsApiCall(queryBody: requestModel).then((value) {
      if(value!=null)
        {
            availableCouponResponseModel=value;
            update();
        }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  getExpiredCoupons()
  {
    Map<String, dynamic> requestModel =
    DetailsRequestModel.couponsRequestModel(language: "ENGLISH");
    _repository.expiredCouponsApiCall(queryBody: requestModel).then((value)  {
      if(value!=null)
        {
            expiredCouponResponseModel=value;
            update();
        }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

}
