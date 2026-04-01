import "package:quantity_savers/app/modules/Details/models/details_request_model.dart";
import "package:quantity_savers/app/modules/forums/models/response_model/forums_request_members_response_model.dart";

import "../../../export.dart";

class ViewRequestsController extends GetxController {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  ForumRequestMembersResponseModel forumRequestMembersResponseModel =
      ForumRequestMembersResponseModel();
  String groupId = "";
  String groupName = "";
  bool isRequestTypeSent = false;

  @override
  void onInit() async {
    getArguments();
    hitGetForumRequestMembersApiCall();
    super.onInit();
  }

  getArguments() {
    if (Get.arguments != null) {
      groupId = Get.arguments[argGroupId];
      groupName = Get.arguments[argGroupName];
      isRequestTypeSent = Get.arguments[argIsRequestTypeSent];
    }
  }

  hitGetForumRequestMembersApiCall() {
    Map<String, dynamic> requestModel =
        DetailsRequestModel.forumRequestMembersModel(id: groupId);
    _apiRepository
        .getForumRequestMembersDataCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        forumRequestMembersResponseModel = value;
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }
}
