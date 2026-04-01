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

import 'package:quantity_savers/app/core/base/socket_file.dart';
import 'package:quantity_savers/app/core/values/socket_events.dart';
import 'package:quantity_savers/app/modules/Details/models/details_request_model.dart';
import 'package:quantity_savers/app/modules/forums/controllers/forums_chat_controller.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/group_list_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/navigation_item.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/user_notifications_response_model.dart';

import '../../../core/widget/guest_custom_widget.dart';
import '../../../export.dart';
import '../../forums/models/data_model/group_list_data_model.dart';

class MainController extends GetxController {
  var selectedIndex = 0;
  LoginResponseModel loginResponseModel = LoginResponseModel();
  GroupListResponseModel groupListResponseModel = GroupListResponseModel();
  LoginDataModel loginDataModel = LoginDataModel();
  final APIRepository _repository = Get.find<APIRepository>();
  List<String> groupIds = [];
  LocalStorage? _localStorage;
  ForumsController? forumsController;
  ForumsChatController? forumsChatController;
  ViewAllCampaignsController?viewAllCampaignsController;
  UserNotificationResponseModel userNotificationResponseModel =UserNotificationResponseModel();


  List<NavigationItem> pages = [
    NavigationItem(title: strHome, view: HomeScreen()),
    NavigationItem(title: strCampaigns, view: ViewAllCompaignsScreen()),
    NavigationItem(title: strForums, view: ForumsScreen()),
    NavigationItem(title: strProfile, view: ProfileScreen()),
  ];

  String? name;
  String? image;
  String token = "";
  int currentBottomNavigationIndex = 0;
  bool isLoading=false;
  bool isFromSkip=false;

  onItemTapped(int index) async {
    if (index == 2 || index==1 || index==0) {
      forumsController?.onInit();
    }
    if(index==1)
      {
        debugPrint("Index 1 is pressed");
        viewAllCampaignsController?.onInit();
      }

    if (_localStorage?.getAuthToken() == null && index == 3) {
      Get.dialog(CustommDialogWidget(
          cancelTitleColor: AppColors.gradientColorSecondary,
          cancelBtnBorder: Border.all(color: AppColors.gradientColorSecondary),
          confirmBtnBgColor: AppColors.gradientColorSecondary,
          title: strNotAuthorized,
          confirmTitle: strLogin,
          cancelTitle: strSignup,
          isCustomizedTapCancel: true,
          isCloseBtn: true,
          onTapCancel: () {
            Get.offAllNamed(AppRoutes.signupRoute);
          },
          onTapConfirm: () {
            Get.offAllNamed(AppRoutes.loginRoute);
          }));
    } else {
      selectedIndex = index;
      update();
    }
    if (_localStorage?.getAuthToken() == null && index == 2) {
      Get.dialog(CustommDialogWidget(
          cancelTitleColor: AppColors.gradientColorSecondary,
          cancelBtnBorder: Border.all(color: AppColors.gradientColorSecondary),
          confirmBtnBgColor: AppColors.gradientColorSecondary,
          title: strNotAuthorized,
          confirmTitle: strLogin,
          cancelTitle: strSignup,
          isCloseBtn: true,
          isCustomizedTapCancel: true,
          onTapCancel: () {
            Get.offAllNamed(AppRoutes.signupRoute);
          },
          onTapConfirm: () {
            Get.offAllNamed(AppRoutes.loginRoute);
          }));
    } else {
      forumsController?.onInit();
      selectedIndex = index;
      update();
    }
  }


  @override
  void onInit() {
    socketIOManager = Get.put(SocketIOManager());

    debugPrint("SelectedIndex is ${selectedIndex}");
    debugPrint("Unread count is ${userNotificationResponseModel.data?.unreadCount}");
    if(Get.arguments!=null)
      {
        isFromSkip=Get.arguments[argSkip] ?? false;
      }


    if (Get.isRegistered<ViewAllCampaignsController>()) {
      viewAllCampaignsController = Get.find<ViewAllCampaignsController>();
    } else {
      Get.put(ViewAllCampaignsController());
    }
    if (Get.isRegistered<LocalStorage>()) {
      _localStorage = Get.find<LocalStorage>();
    } else {
      Get.put(LocalStorage());
    }
    // socketIOManager = Get.put(SocketIOManager());
    lightTheme(color: AppColors.appColor);
    token = _localStorage?.getAuthToken() ?? "";
    debugPrint("Is From Skip Value is $isFromSkip");
    isFromSkip==true? null : hitProfileApiCall() ;
    isFromSkip==true? null :  getNotifications('');
    getArguments();
    super.onInit();
  }

  getArguments() {
    if (Get.arguments != null) {
      currentBottomNavigationIndex =
          Get.arguments[argBottomNavigationIndex] ?? 0;
      if (currentBottomNavigationIndex == 2) {
        forumsController?.onInit();
      }

      if(currentBottomNavigationIndex==1)
        {
          viewAllCampaignsController?.onInit();
        }
      selectedIndex = currentBottomNavigationIndex;
    }
    update();
  }

  hitProfileApiCall() {
    Map<String, dynamic> requestModel =
        AuthRequestModel.getProfileRequestModel();
    _repository.getProfileApiCall().then((value) async {
      if (value != null) {
        loginResponseModel = value;
        unreadCount.value=loginResponseModel.data?.unreadMessageCount ?? 0;
        await saveDataToLocalStorage(loginResponseModel.data);
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  saveDataToLocalStorage(LoginDataModel? loginDataModel) async {
    await _localStorage?.saveRegisterData(loginDataModel);
  }
  getNotifications(String state)
  {

    isLoading = true;
    Map<String, dynamic>? requestModel =
    DetailsRequestModel.getNotificationsRequestModel(type: state);
    _repository
        .getNotificationApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {

        isLoading = false;
        userNotificationResponseModel = value;
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  handleNotifications() {
    if (_localStorage?.getAuthToken() == null) {
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
    else {
      Get.toNamed(AppRoutes.notificationRoute);
    }
  }

  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 2000),() {
      if (Get.isRegistered<ForumsController>()) {
        forumsController = Get.find<ForumsController>();
      } else {
        Get.put(ForumsController());
      }
      forumsController?.onInit();
    },);
    super.onReady();
  }

}
