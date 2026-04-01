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

import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/add_member_response_model.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/search_group_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/brandListResponseModel.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/main_search_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/vendor_search_response_model.dart';

import '../../../export.dart';
import '../../bank/models/response_model/country_selection_response_model.dart';

class SearchOnHomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  BrandListResponseModel brandListResponseModel = BrandListResponseModel();
  CountrySelectionResponseModel countrySelectionResponseModel =
  CountrySelectionResponseModel();
  TabController? tabController;
  int currentIndex = 0;
  bool isLoading=false;
  RxBool showSuffixIcon = false.obs;
  bool isForForumsSearching = false;
  var isForFilterScreen = false;
  var isForAddMembers =false;
  var isForSearchBrand=false;
  var isForVendors = false;
  var addMember = false;
  var forBank=false;

  List<String> selectedMembersIds = [];

  TextEditingController searchFieldText = TextEditingController();
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 300));
  FocusNode searchFieldFocusNode = FocusNode();
  MainSearchResponseModel mainSearchResponseModel = MainSearchResponseModel();
  SearchGroupResponseModel searchGroupResponseModel =
      SearchGroupResponseModel();
  VendorSearchResponseModel vendorSearchResponseModel = VendorSearchResponseModel();
  AddMemberResponseModel addMemberResponseModel = AddMemberResponseModel();
  LocalStorage _localStorage = LocalStorage();

  @override
  void onInit() {
    lightTheme(color: AppColors.appColor);
    getArguments();
    tabController = TabController(vsync: this, length: 3);
    hitMainSearchApi();
    super.onInit();
  }

  getArguments() {

    if (Get.arguments != null) {
      isForForumsSearching = Get.arguments[argIsForForumsSearch] ?? false;
      isForFilterScreen=Get.arguments[argForFilterScreen]?? false;
      isForSearchBrand=Get.arguments[argForSearchBrand] ?? false;
      isForAddMembers=Get.arguments[argGroup] ?? false;
      isForVendors=Get.arguments[argForVendors] ?? false;
      addMember=Get.arguments[argMember] ?? false;
      if(Get.arguments[argSelectedMembers]!=null)
        {
          selectedMembersIds =  List<String>.from(Get.arguments[argSelectedMembers] ?? []);
          debugPrint("SelectedMember ids is $selectedMembersIds");
          updateSelectionState();
        }
      forBank = Get.arguments[argBank] ?? false;
      update();
    }
  }

  void updateSelectionState() {
        for (var id in selectedMembersIds) {
          final index = addMemberResponseModel.data?.indexWhere((element) => element.sId == id);
          if (index != null && index != -1) {
            addMemberResponseModel.data?[index].isSelected = true;
          }
        }
    update();
  }


  onSelectionChange( int index , String? id) {
    final  index= addMemberResponseModel.data?.indexWhere((element) => element.sId==id);
    if(index!=null)
    {
      bool isSelected = !addMemberResponseModel.data![index].isSelected;
      addMemberResponseModel.data![index].isSelected = isSelected;
      if (isSelected) {
        selectedMembersIds.add(addMemberResponseModel.data?[index].sId ?? "");
      } else {
        selectedMembersIds.remove(addMemberResponseModel.data?[index].sId);
      }
      update();
    }
  }


  handleCampaigns(int index)
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
        Get.toNamed(AppRoutes.campaignDetailsScreenRoute, arguments: {
          argCampaignId:
          mainSearchResponseModel.data?[index].sId, argSearchScreen: true
        });
      }
  }

  onTabChanged(int index) async {
    currentIndex = index;
    update();
    hitMainSearchApi();
  }

  updateSuffixIconVisibility() async {

    if (searchFieldText.length > 0) {
      showSuffixIcon.value = true;
      _debouncer(() {
        if (isForForumsSearching) {
          hitForumsSearchApi();
        }
        else if(isForFilterScreen==true)
          {
             hitVendorSearchApi();
          }
        else if(isForSearchBrand==true )
        {
          hitGetBrandListApi();
        }
        else if(isForAddMembers==true)
        {
         hitAddMembersApi();
        }
        else if(forBank==true)
          {
            hitGetCountryList();
          }
          else {
          hitMainSearchApi();
        }
      });
    } else {
      showSuffixIcon.value = false;
      _debouncer.cancel();
    }
    update();
  }

  hitGetCountryList() {
    isLoading = true;
    Map<String, dynamic> requestModel =
    HomepageRequestModel.searchCountryRequestModel(
        search: searchFieldText.text);
    _apiRepository.listCountriesApiCall(queryBody: requestModel).then((value) async {
      if (value != null) {
        countrySelectionResponseModel = value;
        isLoading = false;
        update();
      }
    }).onError((error, stackTrace) {
      isLoading = false;
      debugPrint("error $stackTrace");
      showToast(message: error.toString());
    });
  }

  clearSearchField() async {
    searchFieldText.clear();
    updateSuffixIconVisibility();
    _debouncer(() {
      if (isForForumsSearching) {
        hitForumsSearchApi();
      } else if(isForFilterScreen==true)
      {
        hitVendorSearchApi();
      }
      else if(isForSearchBrand==true)
      {
        hitGetBrandListApi();
      }
      else if(isForAddMembers==true)
      {
        hitAddMembersApi();
      }
      else if(forBank==true)
      {
        hitGetCountryList();
      }
      else {
        hitMainSearchApi();
      }
    });
    update();
  }

  hitForumsSearchApi() {

    Map<String, dynamic> requestModel =
        HomepageRequestModel.searchForumsRequestModel(
            search: searchFieldText.text);
    _apiRepository.groupSearchApiCall(queryBody: requestModel).then((value) {
      if (value != null) {

        searchGroupResponseModel = value;
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  hitMainSearchApi() {
    Map<String, dynamic> requestModel =
        HomepageRequestModel.mainSearchRequestModel(
            search: searchFieldText.text,
            type: currentIndex == 0
                ? "PRODUCT"
                : currentIndex == 1
                    ? "CAMPAIGN"
                    : "SELLER");
    _apiRepository.getMainSearchApiCall(queryBody: requestModel).then((value) {
      if (value != null) {

        mainSearchResponseModel = value;
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  hitGetBrandListApi()
  {
    isLoading=true;
    _apiRepository.getBrandListApiCall().then((value){
      if(value!=null)
      {
        brandListResponseModel=value;
        isLoading=false;
        update();
      }
    }).catchError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }


  hitVendorSearchApi() {

    Map<String, dynamic> requestModel =
    HomepageRequestModel.searchForumsRequestModel(
        search: searchFieldText.text);
    _apiRepository.vendorSearchApiCall(queryBody: requestModel).then((value) {
      if (value != null) {

        vendorSearchResponseModel=value;
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  hitAddMembersApi() {
    Map<String, dynamic> requestModel =
    HomepageRequestModel.searchForumsRequestModel(
        search: searchFieldText.text);
    _apiRepository.addMemberApiCall(queryBody: requestModel).then((value) {
      if (value != null) {
        addMemberResponseModel=value;
        updateSelectionState();
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  @override
  void dispose() {
    searchFieldFocusNode.dispose();
    super.dispose();
  }
}
