import 'package:get/get.dart';
import 'package:quantity_savers/app/core/values/route_arguments.dart';
import 'package:quantity_savers/app/modules/Details/models/details_request_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/product_sub_sub_categoryResponseModel.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/product_subcategory_responseModel.dart';

import '../../../export.dart';

class SubCategoryController extends GetxController {
  final APIRepository _apiRepository =APIRepository();
  ProductSubCategoryResponseModel productSubCategoryResponseModel =ProductSubCategoryResponseModel();
  ProductSubSubCategoryResponseModel productSubSubCategoryResponseModel =ProductSubSubCategoryResponseModel();
  var count=10;
  var title ="";
  var categoryId;
  bool isLoading =false;


  List<ProductSubSubCategoryResponseModel>? product;
  Map<String, List<Map<String, String>>> subSubCategoryMap = {};

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getArguments();
    hitSubCategoriesApi();
  }

  getArguments() {
    if (Get.arguments != null) {
      title = Get.arguments[argTitle] ?? "";
      categoryId=Get.arguments[argCategoryId] ?? "" ;
      update();
    }
  }

  hitSubCategoriesApi() async{
    isLoading = true;
    Map<String, dynamic> requestModel =
    DetailsRequestModel.subCategoryRequestModel(categoryId: categoryId);
    debugPrint("RequestModel is $requestModel");
    _apiRepository
        .getSubCategoryApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {
        productSubCategoryResponseModel = value;
        productSubCategoryResponseModel.data?.data?.forEach((element) {
          String? sid = element.sId;
          debugPrint("Sid is $sid");
          if(sid!=null && !subSubCategoryMap.containsKey(sid))
            {
              hitSubSubCategoriesApi(sid);
            }

        });

        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitSubSubCategoriesApi(String? subCatId)
  {

    isLoading = true;
    Map<String, dynamic> requestModel =
    DetailsRequestModel.subsubCategoryRequestModel(subCategoryId: subCatId);
    debugPrint("RequestModel is $requestModel");
    _apiRepository
        .getSubSubCategoryApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {

        productSubSubCategoryResponseModel=value;
        subSubCategoryMap[subCatId!] = [];
        for (var item in productSubSubCategoryResponseModel.data?.data ?? []) {
          if (item != null) {
            subSubCategoryMap[subCatId]!.add({
              'id': item.sId ?? '',
              'name': item.name ?? '',
            });
          }
        }
        isLoading=false;

        printSubSubCategoryMap();

        update();
      }
    }).onError((error, stackTrace) {
      isLoading =false;
      debugPrint("error $stackTrace");
      showToast(message: error.toString());
    });
  }

  void printSubSubCategoryMap() {
    subSubCategoryMap.forEach((subCatId, subSubCategories) {
      print('SubCategoryId: $subCatId');
      for (var subSubCategory in subSubCategories) {
        print('  ID: ${subSubCategory['id']}, Name: ${subSubCategory['name']}');
      }
    });
  }


}
