import "package:quantity_savers/app/modules/Details/models/details_request_model.dart";
import "package:quantity_savers/app/modules/forums/models/create_group_model.dart";
import "package:quantity_savers/app/modules/forums/models/forums_request_model.dart";
import "package:quantity_savers/app/modules/forums/models/response_model/forum_media_response_model.dart";
import "package:quantity_savers/app/modules/forums/models/response_model/group_campaign_response_model.dart";
import "package:quantity_savers/app/modules/forums/models/response_model/group_info_response_model.dart";
import "package:quantity_savers/app/modules/forums/models/response_model/report_member_response_model.dart";

import "../../../export.dart";

class GroupInfoController extends GetxController {
  late String forumGroupType;
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  final _apiRepository = Get.find<APIRepository>();
  ForumMediaResponseModel forumMediaResponseModel = ForumMediaResponseModel();
  dynamic userLoggedInId = "";
  int totalOnlineCount = 0;
  bool isDefaultGroup = false;
  String memberId = "";
  String editMemberType = "";
  String reason = "";
  bool isSearchedForum = false;
  List<String> selectedMembersIds = [];
  int selectedPrivacyType = 0;
  bool isLoading = false;
  TextEditingController groupNameEditingController = TextEditingController();
  FocusNode groupNameFocusNode = FocusNode();
  List<Map<String, dynamic>> groupPrivacyList = CreateGroupModel().groupPrivacy;
  ForumsChatController? forumsChatController;
  GroupInfoResponseModel? groupInfoResponseModel;
  GroupCampaignResponseModel groupCampaignResponseModel =
      GroupCampaignResponseModel();
  ReportMemberResponseModel reportMemberResponseModel =
      ReportMemberResponseModel();

  void getLoggedInUserId() async {
    LoginDataModel userInfo = await _localStorage.getSavedLoginData();
    userLoggedInId = userInfo.sId;
    update();
  }

  @override
  void onInit() {
    getLoggedInUserId();
    if (Get.isRegistered<ForumsChatController>()) {
      forumsChatController = Get.find<ForumsChatController>();
      groupInfoResponseModel = forumsChatController?.groupInfoResponseModel;
      if (groupInfoResponseModel?.data != null) {
        selectedPrivacyType =
            groupInfoResponseModel?.data?.groupType == "PUBLIC" ? 0 : 1;
        groupNameEditingController.text =
            groupInfoResponseModel?.data?.groupName;
        groupInfoResponseModel?.data?.groupMembers?.forEach((element) {
          if (element.isOnline == 1) {
            totalOnlineCount = totalOnlineCount + 1;
          }
        });
        groupInfoResponseModel?.data?.groupMembers?.sort((a, b) {
          if (a.isOnline == null && b.isOnline == null) {
            return 0;
          } else if (a.isOnline == null) {
            return 1; // Place null values at the end
          } else if (b.isOnline == null) {
            return -1; // Place null values at the end
          } else {
            return a.isOnline!.compareTo(b.isOnline!);
          }
        });
        update();
      }
    }
    lightTheme(color: AppColors.appColor);
    getArguments();
    hitGetGroupCampaignApi();
    hitForumMediaApiCall("ALL");
    super.onInit();
  }

  hitForumMediaApiCall(String mediaType)
  {
    isLoading=true;
    Map<String, dynamic>? requestModel =
    ForumsRequestModel.forumMediaRequestModel(type: mediaType);
    _apiRepository.forumMediaApiCall(queryBody: requestModel,id: groupInfoResponseModel?.data?.sId).then((value){
      if(value!=null)
      {
        forumMediaResponseModel=value;
        isLoading = false;
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });

  }


  hitGetGroupCampaignApi() {
    Map<String, dynamic> requestModel =
        ForumsRequestModel.groupCampaignRequestModel(
            groupId: groupInfoResponseModel?.data?.sId);
    _apiRepository
        .getGroupCampaignApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        groupCampaignResponseModel = value;
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitEditMemberApi() {
    Map<String, dynamic> requestModel =
        ForumsRequestModel.editMembersRequestModel(
            groupId: groupInfoResponseModel?.data?.sId,
            memberId: memberId,
            type: editMemberType);

    _apiRepository
        .manageMemberApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        groupInfoResponseModel = value;
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitReportMemberApi() {
    Map<String, dynamic> requestModel =
        ForumsRequestModel.reportMembersRequestModel(
            memberId: memberId, reason: "Report this Member");

    _apiRepository
        .reportMemberApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        reportMemberResponseModel = value;
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitUpdateGroupApi() {
    groupInfoResponseModel?.data?.groupType =
        selectedPrivacyType == 0 ? "PUBLIC" : "PRIVATE";
    Map<String, dynamic> requestModel =
        DetailsRequestModel.editGroupRequestModel(
            groupId: groupInfoResponseModel?.data?.sId,
            groupName: groupNameEditingController.text,
            groupType: groupInfoResponseModel?.data?.groupType,
            addMembers: selectedMembersIds);
    _apiRepository
        .updateGroupApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        groupInfoResponseModel = value;
        selectedMembersIds = [];
        Get.find<ForumsChatController>().hitGetGroupInfoApiCall();
        showToast(message: "Updated Successfully");
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  getArguments() {
    if (Get.arguments != null) {
      isDefaultGroup = Get.arguments[argIsDefaultGroup] ?? false;
      isSearchedForum = Get.arguments[argIsSearchedForum] ?? false;
      forumGroupType = Get.arguments[argForumGroupType] ?? "";
    }
  }
}
