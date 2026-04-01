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


import 'package:quantity_savers/app/modules/Details/models/data_models/product_details_data_model.dart';
import 'package:quantity_savers/app/modules/Details/models/details_request_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/product_details_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/product_media_response_model.dart';

import '../../../export.dart';

class ReviewVideosAndImageController extends GetxController with GetSingleTickerProviderStateMixin{
  final APIRepository _apiRepository = Get.find<APIRepository>();
  ProductDetailsResponseModel productDetailsResponseModel =ProductDetailsResponseModel();
  ProductMediaResponseModel productMediaResponseModel = ProductMediaResponseModel();

  TabController? tabController;
  var currentIndex = 0;
  var index =false;
  var productId;
  bool isLoading=false;
  var totalReviews=0;

  List<Widget> tiles = List.generate(20, (index) => const AssetSVGWidget(demoImagesImage10));

  @override
  void onInit() {
    lightTheme(color: AppColors.appColor);
    tabController = TabController(vsync: this, length: 2,initialIndex: index ? 1 :0);
    super.onInit();
    getArguments();
    hitGetProductsDetailsApi();
    hitMediaReviewApi();
  }
  getArguments()
  {
    if(Get.arguments!=null)
      {
        index=Get.arguments[argForImages] ?? false;
        productId=Get.arguments[argProductId];
        if(Get.arguments[typeVideo]==true){
          tabController?.index = 0;
        }else{
          tabController?.index = 1;
        }
      }
  }

  hitMediaReviewApi()
  {
    isLoading=true;
    Map<String, dynamic> requestModel =
    DetailsRequestModel.productDetailsMediaRequestModel(id: productId);
    _apiRepository.getProductMediaApiCall(queryBody: requestModel).then((value){
      if(value!=null)
      {
        productMediaResponseModel=value;
        isLoading=false;
        update();
      }

    }).catchError((error, stackTrace) {
      isLoading = false;
      update();
      debugPrint("message: '$stackTrace'");
    });
  }

  hitGetProductsDetailsApi() {

    isLoading = true;
    update();
    Map<String, dynamic> requestModel =
    DetailsRequestModel.productDetailsRequestModel(id: productId);

    _apiRepository
        .getProductDetailsApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {

        productDetailsResponseModel = value;
        productId = productDetailsResponseModel.data?.sId ?? "";
        if (productDetailsResponseModel.data != null) {
          productDetailsResponseModel.data!.productVariations ??=
          []; // Ensure productVariations list is initialized
          productDetailsResponseModel.data!.productVariations!.insert(
            0,
            ProductVariations(
                sId: productDetailsResponseModel.data!.sId ?? "",
                name: productDetailsResponseModel.data!.name ?? "",
                price: productDetailsResponseModel.data!.price ?? 0,
                discountPrice:
                productDetailsResponseModel.data!.discountPrice ?? 0.0,
                quantity: productDetailsResponseModel.data!.quantity ?? 0,
                productId: productDetailsResponseModel.data!.sId ?? "",
                wholesaleQuntity:
                productDetailsResponseModel.data!.wholesaleQuntity ?? 0),
          );
        }
        totalReviews = productDetailsResponseModel.data?.totalReviews ?? 0;
        isLoading = false;
        update();
        // hitGetProductReviewApi(productDetailsResponseModel.data?.sId);
        update();
      }
    }).catchError((error, stackTrace) {
      isLoading = false;
      update();
      debugPrint("message: '$stackTrace'");
    });
  }

  onTabChanged(int index) async {
    currentIndex = index;
    if(currentIndex==1)
      {
        isLoading=true;
        await Future.delayed(Duration(seconds: 1));
        isLoading = false;
        hitGetProductsDetailsApi();
        debugPrint("heyyy");
      }
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

