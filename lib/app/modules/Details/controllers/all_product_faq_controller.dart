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

import 'package:quantity_savers/app/data/local/preferences/preference.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/faq_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/product_faq_response_model.dart';
import 'package:quantity_savers/app/modules/profile/models/response_model/profile_faq_response_model.dart';

import '../../../export.dart';
import '../models/details_request_model.dart';

class AllProductFAQsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  ProductFaqResponseModel productFaqResponseModel = ProductFaqResponseModel();
  FAQResponseModel faqResponseModel = FAQResponseModel();
  LocalStorage _localStorage = LocalStorage();
  bool isLoading=false;
  var faqLength = 0;
  var productId;
  @override
  void onInit() {
    lightTheme(color: AppColors.appColor);
    getArguments();
    hitProductFaqDetailsApi();
    super.onInit();
  }

  getArguments()
  {
    if(Get.arguments!=null)
      {
        productId=Get.arguments[argProductId] ?? "" ;
      }
  }

  hitProductFaqDetailsApi() {
    isLoading = true;
    Map<String, dynamic> requestModel =
    DetailsRequestModel.productFaqRequestModel(productId: productId);
    _apiRepository.getProductFaqApiCall(queryBody: requestModel).then((value) {
      if (value != null) {
        productFaqResponseModel = value;
        faqLength = productFaqResponseModel.totalCount ?? 0;
        isLoading = false;
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitLikeProductFaq(var id,var type)
  {
    if(_localStorage.getAuthToken() == null) {
      Get.dialog(CustomDialogWidget(
          cancelTitleColor: AppColors.gradientColorSecondary,
          cancelBtnBorder: Border.all(color: AppColors.gradientColorSecondary),
          confirmBtnBgColor: AppColors.gradientColorSecondary,
          title: strNotAuthorized,
          confirmTitle: strLogin,
          cancelTitle: strSignup,
          isCustomizedTapCancel: true,
          onTapCancel: () {
            Get.offAllNamed(AppRoutes.signupRoute);
          },
          onTapConfirm: () {
            Get.offAllNamed(AppRoutes.loginRoute);
          }));
    }
    else
      {
        Map<String, dynamic> requestModel =
        DetailsRequestModel.productFaqLikeRequestModel(faqId: id,type: type);
        _apiRepository.productFaqLikeApi(dataBody: requestModel).then((value){
          if(value!=null)
          {
            faqResponseModel = value;
            isLoading=false;
            hitProductFaqDetailsApi();
            update();
          }
        }).onError((error, stackTrace) => showToast(message: error.toString()));
      }


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
