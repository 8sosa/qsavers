import "package:quantity_savers/app/core/values/socket_events.dart";
import "package:quantity_savers/app/modules/Details/models/details_request_model.dart";
import "package:quantity_savers/app/modules/authentication/models/dataModel/login_data_model.dart";
import "package:quantity_savers/app/modules/forums/models/data_model/group_list_data_model.dart";
import "package:quantity_savers/app/modules/forums/models/response_model/forum_sent_request_response_model.dart";
import "package:quantity_savers/app/modules/forums/models/response_model/group_list_response_model.dart";
import "package:quantity_savers/app/modules/home/controllers/main_controller.dart";

import "../../../export.dart";
import "../models/data_model/chat_history_response_model.dart";
import "../models/forums_request_model.dart";
import "../models/response_model/chat_history_response_model.dart";

class ForumsController extends GetxController {
  Timer? timer;
  final APIRepository _apiRepository = Get.find<APIRepository>();
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  var currentPage = 0;
  RxInt unreadMessages = 0.obs;
  String groupId = "";
  GroupListResponseModel groupListResponseModel = GroupListResponseModel();
  ForumRequestResponseModel forumRequestResponseModel =
      ForumRequestResponseModel();
  ForumsChatController? forumsChatController;
  MainController? mainController;
  bool isLoading = false;
  GroupListDataModel groupListDataModel = GroupListDataModel();
  ViewAllCampaignsController?viewAllCampaignsController;
  LoginDataModel loginResponseModel = LoginDataModel();
  ChatHistoryDataModel chatHistoryDataModel = ChatHistoryDataModel();
  ChatHistoryResponseModel chatHistoryResponseModel =
  ChatHistoryResponseModel();
  LoginDataModel loginDataModel = LoginDataModel();
  var type;

  @override
  void onReady() {
    if (_localStorage.getAuthToken() != null) {
      getLocalProfileData();
    }
    super.onReady();
  }

  void getLocalProfileData() =>
      timer = Timer(const Duration(seconds: 1, milliseconds: 500), () async {
        loginDataModel = await _localStorage.getSavedLoginData();
        update();
      });

  @override
  void onInit() async {
    type = _localStorage.getSaveType();
    groupId="";
    if ((_localStorage.getAuthToken() ?? "") != "") {
      hitGetGroupListSocket();
      hitGetForumRequestApiCall();
    }
    socketIOManager?.listenEvent(
        eventName: receivedMessageEvent,
        onDataReceived: (data) {
          debugPrint("receivedMessageEvent $data");
          if (data != null) {
            if(data['group_id']!=null)
              {
                hitDeliveredMessageSocket(data['group_id'] , data['_id']);
              }

            hitGetGroupListSocket();
          }
          update();
        });
    socketIOManager?.listenEvent(
        eventName: otherUserListEvent,
        onDataReceived: (data) {
          try {
            if (data != null) {
              List<GroupListDataModel> temp = [];
              final list = data as List<dynamic>;
              for (var element in list) {
                temp.add(GroupListDataModel.fromJson(element));
              }
              groupListResponseModel = GroupListResponseModel(data: temp);
              debugPrint("groupListResponseModel is ${groupListResponseModel.data?[0].groupName}");
              isLoading = false;
              update();
            }
          } catch (error) {
            showToast(message: error.toString());
          }
        });
    socketIOManager?.listenEvent(
        eventName: unreadMessageSocket,
        onDataReceived: (data) {
          debugPrint("The Unread Message Data is $data ");
          try {
            if (data != null && data['unread_message_count'] != null) {
             unreadCount.value=data['unread_message_count'];
               update();
               debugPrint("unread msg count is ${unreadCount}");
            }
          } catch (error) {
            showToast(message: error.toString());
          }
        });
    super.onInit();
  }
  void getLoggedInUserId() async {
    loginResponseModel = await _localStorage.getSavedLoginData();
    debugPrint("loginValue is ${loginResponseModel.unreadMessageCount}");
    update();
  }

  hitDeliveredMessageSocket(String groupId, String messageID)  {
    debugPrint("Deliverd Message Socket invoked $groupId");
    Map<String, dynamic> requestModel =
    ForumsRequestModel.readMessageRequestChatRequestModel(
        messageId: messageID, groupId: groupId);
    socketIOManager?.emitEvent(
      dataBody: requestModel,
      eventName: deliveredMessageEvent,
    );
    update();
  }

  Future<void> refreshList() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (Get.isRegistered<ViewAllCampaignsController>()) {
      viewAllCampaignsController = Get.find<ViewAllCampaignsController>();
    }
    viewAllCampaignsController?.getAllCampaignsData();

  }
      hitGetGroupListSocket([String? groupId, String? messageId]) {
     isLoading = true;
     Map<String, dynamic> requestModel =
     ForumsRequestModel.readMessageRequestChatRequestModel(
         messageId: messageId, groupId: groupId);
    socketIOManager?.emitEvent(dataBody: requestModel, eventName: sendUserListEvent);
    update();
  }

  hitGetForumRequestApiCall() {
    isLoading = true;
    Map<String, dynamic> requestModel = DetailsRequestModel.forumRequestModel(
        type: currentPage == 0 ? "RECIVED" : "SENT");
    _apiRepository
        .getForumRequestDataCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        forumRequestResponseModel = value;
        isLoading = false;
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  @override
  void dispose() {
    socketIOManager?.disconnectSocket();
    super.dispose();
  }
}
