import "package:flutter_ffmpeg/flutter_ffmpeg.dart";
import "package:flutter_ffmpeg/media_information.dart";
import "package:path_provider/path_provider.dart";
import "package:quantity_savers/app/core/values/socket_events.dart";
import "package:quantity_savers/app/modules/forums/controllers/progress_controller.dart";
import "package:quantity_savers/app/modules/forums/models/data_model/chat_history_response_model.dart";
import "package:quantity_savers/app/modules/forums/models/forums_request_model.dart";
import "package:quantity_savers/app/modules/forums/models/response_model/chat_history_response_model.dart";
import "package:quantity_savers/app/modules/forums/models/response_model/exit_delete_group_response_model.dart";
import "package:quantity_savers/app/modules/forums/models/response_model/group_info_response_model.dart";
import "package:quantity_savers/app/modules/forums/models/response_model/join_public_group_response_model.dart";
import "package:quantity_savers/app/modules/forums/models/response_model/manage_request_response_model.dart";
import "package:quantity_savers/app/modules/forums/models/response_model/message_received_notification_response_model.dart";
import "package:quantity_savers/app/modules/forums/models/response_model/request_status_response_model.dart";
import "../../../core/widget/progress_bar.dart";
import "../../../export.dart";
import "life_cycle_controller.dart";

class ForumsChatController extends SuperController {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  final ScrollController scrollController = ScrollController();
  final TextEditingController textEditingController = TextEditingController();
  ForumsController? forumsController;
  final TextEditingController joinRequestDescriptionEditingController =
      TextEditingController();
  MessageDelieverdNotificationResponseModel
      messageDelieverdNotificationResponseModel =
      MessageDelieverdNotificationResponseModel();
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  ValueNotifier<double> progressNotifier = ValueNotifier(0.0);
  List<ValueNotifier<double>> progressNotifierList =
  List.generate(5, (index) => ValueNotifier(0.0));

  // final ProgressController progressController = Get.put(ProgressController());
  dynamic userLoggedInId = "";
  var name;
  var profilePic;
  bool isImageUploaded = false;
  String docImagePath = "";
  bool isLoading = false;
  bool isVideoPlayed = false;
  bool isVideoUploaded = false;
  bool isDocumentUploaded = false;
  String docVideoPath = "";
  String editMessageId = "";
  final FocusNode focusNode = FocusNode();
  final FocusNode joinRequestDescriptionFocusNode = FocusNode();
  bool isJoinRequestFormOpened = false;
  late String forumGroupType;
  bool isSearchedForum = false;
  bool isSearchedForumCampaign = false;
  bool isGroupJoined = false;
  bool isRouteFromRequest = false;
  bool wantToEditMessage = false;
  bool isRouteFromViewRequest = false;
  var searchedForumDetails = {};
  String groupId = "";
  bool showEmoji = false;
  bool isPublicGroupJoined = false;
  String groupRequestId = "";
  String requestStatus = "ACCEPTED";
  bool isEditing = false;
  int? deleteMessageIndex;
  bool appStatus = true;
  double progress = 0.0;
  List<double> progressList = List.filled(5, 0.0);
  int currentVideoIndex = 0;

  ImageResposemodel? videoUploadResponse = ImageResposemodel();
  ImageResposemodel? imageUploadResponse = ImageResposemodel();
  ImageResposemodel? documentUploadResponse = ImageResposemodel();
  GroupInfoResponseModel groupInfoResponseModel = GroupInfoResponseModel();
  ManageRequestResponseModel manageRequestResponseModel =
      ManageRequestResponseModel();
  RequestStatusResponseModel requestStatusResponseModel =
      RequestStatusResponseModel();
  ChatHistoryResponseModel chatHistoryResponseModel =
      ChatHistoryResponseModel();
  ChatHistoryDataModel chatHistoryDataModel = ChatHistoryDataModel();
  ExitDeleteGroupResponseModel exitDeleteGroupResponseModel =
      ExitDeleteGroupResponseModel();
  JoinPublicGroupResponseModel joinPublicGroupResponseModel =
      JoinPublicGroupResponseModel();
  var messageId;
  var videoMessageId;

  void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void toggleEmojiPicker() {
    showEmoji = !showEmoji;
    if (showEmoji) {
      dismissKeyboard();
    }
    update();
  }

  void hideEmoji() {
    showEmoji = false;
    update();
  }

  int calculateDifferenceInDays(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  Future<void> onFieldSubmitted() async {
    if (!isTextFieldEnable) return;
    hitSendMessageSocket();
    update();
  }

  getLoggedInUserId() async {
    LoginDataModel userInfo = await _localStorage.getSavedLoginData();
    userLoggedInId = userInfo.sId;
    name = userInfo.name;
    profilePic = userInfo.profilePic;
  }

  void onFieldChanged(String term) {
    update();
  }

  bool get isTextFieldEnable => textEditingController.text.isNotEmpty;

  hitGetGroupInfoApiCall() {
    _apiRepository.getGroupInfoApiCall(groupId: groupId).then((value) async {
      if (value != null) {
        groupInfoResponseModel = value;
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  @override
  void onInit() {
    if (Get.isRegistered<ForumsChatController>()) {
      forumsController = Get.find<ForumsController>();
    }
    lightTheme(color: AppColors.appColor);
    getLoggedInUserId();
    getArguments();
    debugPrint("ChatHistoryGroupId is${chatHistoryDataModel.groupId}");
    debugPrint("Is RouteFrom Request $isRouteFromRequest");
    debugPrint("Is Route from View Request $isRouteFromViewRequest");
    // if(isSearchedForumCampaign==false)
    //   {
    //     hitGetGroupInfoApiCall();
    //   }
    hitGetGroupInfoApiCall();
    focusNode.addListener(() {
      scrollToBottom();
    });
    debugPrint("Inside Received Message ${groupId}");
    socketIOManager?.listenEvent(
        eventName: sendPrivateGroupJoinRequestEvent,
        onDataReceived: (data) {
          try {
            if (data != null) {
              showToast(message: "Request Successfully Sent");
              Get.offNamed(AppRoutes.mainScreenRoute,
                  arguments: {argBottomNavigationIndex: 2});
            }
          } catch (error) {
            showToast(message: error.toString());
          }
        });
    socketIOManager?.listenEvent(
        eventName: initForumSentRequestChatEvent,
        onDataReceived: (data) {
          try {
            if (data != null) {
              if (groupRequestId == "") {
                hitGroupChatHistoryApi();
              } else {
                hitRequestChatHistoryApi();
              }
            }
          } catch (error) {
            showToast(message: error.toString());
          }
        });
    socketIOManager?.listenEvent(
        eventName: deleteMessageEvent,
        onDataReceived: (data) {
          debugPrint('Delete Message Event is called');
          try {
            if (data != null) {
              chatHistoryResponseModel.data
                  ?.removeWhere((element) => element.sId == data["message_id"]);
            }
            update();
          } catch (error) {
            showToast(message: error.toString());
          }
        });
    socketIOManager?.listenEvent(
        eventName: editMessageEvent,
        onDataReceived: (data) {
          debugPrint('Edit Message Event is called');
          if (data != null) {
            chatHistoryResponseModel.data?.forEach((element) {
              if (element.sId == data["message_data"]["_id"]) {
                element.message = data["message_data"]["message"];
                element.updatedAt = data["message_data"]["updated_at"];
              }
              wantToEditMessage = false;
              update();
            });
          }
        });
    socketIOManager?.listenEvent(
        eventName: editVideoSocket,
        onDataReceived: (data) {
          debugPrint('Edit Message Event is called $data');
          debugPrint("Message Data is ${data["group_id"]}");
          debugPrint("Message Dataaaa is ${data["message_id"]}");
          if (data != null) {
            chatHistoryResponseModel = ChatHistoryResponseModel.fromJson(data);
            if (data['group_req_id'] == null) {
              if (groupId == data['group_id'] && appStatus == true) {
                debugPrint("UpdateSeenStatusValue $appStatus");
                hitReadMessageSocket(data['group_id'], data['message_id']);
              } else {
                hitDeliveredMessageSocket(data['group_id'], data['message_id']);
              }
            } else {
              if (data['group_req_id'] == null) {
                debugPrint("Delivered Invoked");
                hitDeliveredMessageSocket(data['group_id'], data['message_id']);
              }
            }

            scrollToBottom();
            update();
          }
        });
    socketIOManager?.listenEvent(
        eventName: receivedMessageEvent,
        onDataReceived: (data) {
          if (data != null) {
            debugPrint("Dataaaa is $data");
            chatHistoryDataModel = ChatHistoryDataModel.fromJson(data);
            if (chatHistoryDataModel.inProgress == true) {
              messageId = data['_id'];
              debugPrint(
                  "Message Id of Video is $messageId and in progress value is ${chatHistoryDataModel.inProgress}");
            }
            if (chatHistoryDataModel.inProgress == true &&
                chatHistoryDataModel.messageType == 'VIDEO' &&
                userLoggedInId != chatHistoryDataModel.sentBy?.sId) {
              debugPrint(
                  "Skipping message as it's not sent by the logged-in user.");
              return;
            }
            if ((chatHistoryDataModel.messageType == "VIDEO" ||
                    chatHistoryDataModel.messageType == "IMAGE" ||
                    chatHistoryDataModel.messageType == "DOCUMENT") &&
                chatHistoryDataModel.sentBy?.sId == userLoggedInId) {
              debugPrint(
                  "Skipping message as it's sent by the logged-in user.");
              return;
            }
            forumsController?.hitGetGroupListSocket(
                data['group_id'], data['_id']);
            if(data['group_id']!=null)
              {
                hitDeliveredMessageSocket(data['group_id'], data['_id']);
              }
            getGroupID();
            if (chatHistoryDataModel.groupReqId != null ||
                (groupId == chatHistoryDataModel.groupId)) {
              chatHistoryResponseModel.data?.add(chatHistoryDataModel);
              textEditingController.text = "";
              debugPrint(
                  "Inside Received Message ${groupId} ${groupId == data['group_id']}");
              if (data['group_req_id'] == null) {
                if (groupId == data['group_id'] && appStatus == true) {
                  debugPrint("UpdateSeenStatusValue $appStatus");
                  hitReadMessageSocket(data['group_id'], data['_id']);
                } else {
                  hitDeliveredMessageSocket(data['group_id'], data['_id']);
                }
              }
            } else {
              if (data['group_req_id'] == null) {
                debugPrint("Delivered Invoked");
                hitDeliveredMessageSocket(data['group_id'], data['_id']);
              }
            }

            scrollToBottom();
          }
          update();
        });
    socketIOManager?.listenEvent(
        eventName: readMessageEvent,
        onDataReceived: (data) {
          if (data != null) {
            if (groupId == data['group_id'] &&
                userLoggedInId == data['sent_by']) {
              debugPrint("Listen Socket Read");
              hitUpdateChatHistory();
            }
            update();
          }
        });
    socketIOManager?.listenEvent(
        eventName: deliveredMessageEvent,
        onDataReceived: (data) {
          debugPrint("Listen Socket Delivered");
          debugPrint("Dattttta aaa is $data");
          debugPrint("Dattttta aaa is $groupId");
          debugPrint("Dattttta aaa is $userLoggedInId");
          if (data != null) {
            if (groupId ==
                    data[
                        'group_id'] /*&&
                userLoggedInId == data['sent_by']*/
                ) {
              debugPrint("Listen Socket Delivered");
              hitUpdateChatHistory();
            }
            update();
          }
        });
    // socketIOManager?.listenEvent(
    //     eventName: updateChatHistorySocket,
    //     onDataReceived: (data) {
    //       if (data != null) {
    //         debugPrint("Data issssss $data");
    //         chatHistoryResponseModel = ChatHistoryResponseModel.fromJson(data);
    //         scrollToBottom();
    //         isLoading = false;
    //         update();
    //       }
    //     });
    socketIOManager?.listenEvent(
      eventName: updateChatHistorySocket,
      onDataReceived: (data) {
        if (data != null) {
          debugPrint("Data issssss $data");
          List<dynamic> messageList = data['data'];
          var finalData = <ChatHistoryDataModel>[];
          for (var messageData in messageList) {
            var message = ChatHistoryDataModel.fromJson(messageData);
            if (message.inProgress == true) {
              message.uploadProgress = progress;
            }
            finalData.add(message);
          }
          chatHistoryResponseModel = ChatHistoryResponseModel(data: finalData);
          scrollToBottom();
          isLoading = false;
          update();
        }
      },
    );
    super.onInit();
  }

  void updateSeenStatus() {
    print('update called');

    if (chatHistoryResponseModel.data?.isNotEmpty ?? false) {
      final lastMessageStatus = chatHistoryResponseModel.data?.last.readState;
      if (lastMessageStatus == 1 || lastMessageStatus == 2) {
        for (ChatHistoryDataModel message
            in (chatHistoryResponseModel.data ?? [])) {
          if (message.readState == 1 && lastMessageStatus == 2) {
            message.readState = lastMessageStatus;
          } else if (message.readState == 0) {
            message.readState = lastMessageStatus;
          }
          update();
        }
      }
    }
  }

  hitReadMessageSocket(String groupId, String messageID) {
    debugPrint("Read Message Socket Invoked");
    Map<String, dynamic> requestModel =
        ForumsRequestModel.readMessageRequestChatRequestModel(
            messageId: messageID, groupId: groupId);
    socketIOManager?.emitEvent(
      dataBody: requestModel,
      eventName: readMessageEvent,
    );
    update();
  }

  hitDeliveredMessageSocket(String groupId, String messageID) {
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

  hitDeleteMessageSocket(String messageId) async {
    debugPrint("Delete Message Socket $messageId");
    Map<String, dynamic> requestModel =
        ForumsRequestModel.deleteMessageRequestChatRequestModel(
            messageId: messageId);
    socketIOManager?.emitEvent(
      dataBody: requestModel,
      eventName: deleteMessageEvent,
    );
    update();
  }

  scrollToBottom() async {
    await Future.delayed(Duration(milliseconds: 100));
    if (scrollController.hasClients) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn);
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
      update();
    }
  }

  getGroupID() {
    if (Get.arguments != null) {
      groupId = Get.arguments[argGroupId];
      debugPrint("This group id is $groupId");
    } else {
      groupId = '';
      debugPrint("Your Group ID is null");
    }
  }

  getArguments() {
    if (Get.arguments != null) {
      groupId = Get.arguments[argGroupId];
      debugPrint("This group id is $groupId");
      forumGroupType = Get.arguments[argForumGroupType] ?? "PRIVATE";
      isSearchedForum = Get.arguments[argIsSearchedForum] ?? false;
      isGroupJoined = Get.arguments[argGroupJoined] ?? false;
      isRouteFromRequest = Get.arguments[argIsRouteFromRequest] ?? false;
      isSearchedForumCampaign =
          Get.arguments[argIsSearchedForumCampaign] ?? false;
      isRouteFromViewRequest =
          Get.arguments[argIsRouteFromViewRequest] ?? false;
      if (isRouteFromRequest == true || isRouteFromViewRequest == true) {
        groupRequestId = Get.arguments[argGroupRequestId] ?? "";
      }
      hitForumChatInitSocket();
      update();
    }
  }

  hitMessageReceivedNotificationApi(String id) {
    _apiRepository.messageDelieveredNotificationApi(id).then((value) {
      if (value != null) {
        messageDelieverdNotificationResponseModel = value;
        debugPrint(
            "MessageId is ${messageDelieverdNotificationResponseModel.data?.message}");
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  refreshList() {}

  hitSendJoinForumRequestSocket({groupIds}) {
    Map<String, dynamic> requestModel =
        ForumsRequestModel.privateForumJoinRequestModel(
            groupId: groupId ?? groupIds,
            message: joinRequestDescriptionEditingController.text);
    socketIOManager?.emitEvent(
      dataBody: requestModel,
      eventName: sendPrivateGroupJoinRequestEvent,
    );
  }

  hitForumChatInitSocket() {
    Map<String, dynamic> requestModel =
        ForumsRequestModel.initForumChatRequestModel(
            groupRequestId: groupRequestId == "" ? groupId : groupRequestId);
    socketIOManager?.emitEvent(
        dataBody: requestModel, eventName: initForumSentRequestChatEvent);
  }

  hitGroupLeaveSocket() {
    Map<String, dynamic> requestModel =
        ForumsRequestModel.initForumChatRequestModel(
            groupRequestId: groupRequestId == "" ? groupId : groupRequestId);
    socketIOManager?.emitEvent(
        dataBody: requestModel, eventName: leaveGroupSocket);
  }

  hitUpdateChatHistorySocket() {
    Map<String, dynamic> requestModel =
        ForumsRequestModel.initForumChatRequestModel(groupRequestId: groupId);
    socketIOManager?.emitEvent(
        dataBody: requestModel, eventName: updateChatHistoryEvent);
  }

  hitUpdateChatHistory() {
    Map<String, dynamic> requestModel =
        ForumsRequestModel.initForumChatRequestModel(groupRequestId: groupId);
    socketIOManager?.emitEvent(
        dataBody: requestModel, eventName: updateChatHistorySocket);
  }

  hitManageForumRequestApi() {
    Map<String, dynamic> requestModel = ForumsRequestModel.manageRequestModel(
        requestId: groupRequestId, status: requestStatus);
    _apiRepository
        .manageForumRequestCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        manageRequestResponseModel = value;
        showToast(message: manageRequestResponseModel.data?.status);
        Get.offAllNamed(AppRoutes.mainScreenRoute,
            arguments: {argBottomNavigationIndex: 2});
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitJoinPublicGroupApi() {
    Map<String, dynamic> requestModel =
        ForumsRequestModel.exitDeleteGroupRequestModel(groupId: groupId);
    _apiRepository.joinGroupApiCall(dataBody: requestModel).then((value) async {
      if (value != null) {
        joinPublicGroupResponseModel = value;
        showToast(message: "Group Successfully Joined");
        isPublicGroupJoined = true;
        forumsController?.onInit();
        Get.offAllNamed(AppRoutes.mainScreenRoute,
            arguments: {argBottomNavigationIndex: 2});
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitDeleteGroupApi() {
    Map<String, dynamic> requestModel =
        ForumsRequestModel.exitDeleteGroupRequestModel(groupId: groupId);
    _apiRepository
        .deleteGroupApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        exitDeleteGroupResponseModel = value;
        showToast(message: "Group Deleted Successfully");
        Get.offAllNamed(AppRoutes.mainScreenRoute,
            arguments: {argBottomNavigationIndex: 2});
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitExitGroupApi() {
    Map<String, dynamic> requestModel =
        ForumsRequestModel.exitDeleteGroupRequestModel(groupId: groupId);
    _apiRepository
        .exitGroupApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        exitDeleteGroupResponseModel = value;
        showToast(message: "Group Exited Successfully");
        Get.offAllNamed(AppRoutes.mainScreenRoute,
            arguments: {argBottomNavigationIndex: 2});
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitGroupChatHistoryApi() {
    debugPrint("The Groupppp Id is $groupId");
    if (groupId case (null || "")) {
      return;
    }
    isLoading = true;
    Map<String, dynamic> requestModel =
        ForumsRequestModel.groupChatHistoryRequestModel(groupId: groupId);
    _apiRepository
        .getGroupChatHistoryApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        chatHistoryResponseModel = value;
        //updateSeenStatus();
        scrollToBottom();
        isLoading = false;
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitRequestChatHistoryApi() {
    Map<String, dynamic> requestModel =
        ForumsRequestModel.requestChatHistoryRequestModel(
            requestId: groupRequestId);
    _apiRepository
        .getRequestChatHistoryApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        chatHistoryResponseModel = value;
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitGetForumRequestStatusApiCall() {
    _apiRepository
        .getForumRequestStatusApiCall(requestId: groupRequestId)
        .then((value) async {
      if (value != null) {
        requestStatusResponseModel = value;
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  hitVideoMessageSocket(String path) async {
    debugPrint("Path is $path");
    Map<String, dynamic> requestModel =
        ForumsRequestModel.sendMessageRequestChatRequestModel(
            message: textEditingController.text,
            mediaUrl: path,
            groupId: groupRequestId == "" ? groupId : null,
            groupRequestId: groupRequestId == "" ? null : groupRequestId,
            messageType: "VIDEO");
    socketIOManager?.emitEvent(
      dataBody: requestModel,
      eventName: sendMessageEvent,
    );
    textEditingController.text = "";
    update();
  }

  hitEditVideoMessageSocket() async {
    Map<String, dynamic> requestModel =
        ForumsRequestModel.sendVideoMessageRequestChatRequestModel(
            mediaUrl: videoUploadResponse?.data?.fileName,
            messageId: videoMessageId);
    socketIOManager?.emitEvent(
      dataBody: requestModel,
      eventName: editVideoSocket,
    );
    textEditingController.text = "";
  }

  hitSendMessageSocket() async {
    debugPrint("Video file is ${videoUploadResponse?.data?.fileName}");
    if (wantToEditMessage == true) {
      Map<String, dynamic> requestModel =
          ForumsRequestModel.EditMessageRequestChatRequestModel(
              messageId: editMessageId,
              message: textEditingController.text.trim());
      await socketIOManager?.emitEvent(
        dataBody: requestModel,
        eventName: editMessageEvent,
      );
      textEditingController.text = "";
    } else {
      hitUpdateChatHistorySocket();
      Map<String, dynamic> requestModel =
          ForumsRequestModel.sendMessageRequestChatRequestModel(
              message: textEditingController.text,
              mediaUrl: isImageUploaded == true
                  ? imageUploadResponse?.data?.fileName
                  : isVideoUploaded == true
                      ? videoUploadResponse?.data?.fileName
                      : documentUploadResponse?.data?.fileName,
              groupId: groupRequestId == "" ? groupId : null,
              groupRequestId: groupRequestId == "" ? null : groupRequestId,
              messageType: groupRequestId != ""
                  ? null
                  : isImageUploaded == true
                      ? "IMAGE"
                      : isVideoUploaded == true
                          ? "VIDEO"
                          : isDocumentUploaded == true
                              ? "DOCUMENT"
                              : "TEXT");
      socketIOManager?.emitEvent(
        dataBody: requestModel,
        eventName: sendMessageEvent,
      );
      textEditingController.text = "";
    }
  }

  Future<void> pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx'],
    );

    if (result != null && result.files.single.path != null) {
      String docPath = result.files.single.path!;
      ChatHistoryDataModel newChat = ChatHistoryDataModel(
        messageType: 'DOCUMENT',
        mediaUrl: docPath,
        uploadProgress: 0.0,
        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
        sentBy: SentBy(
          name: name,
          profilePic: profilePic,
          sId: userLoggedInId,
        ),
        isNetwork: false,
      );

      chatHistoryResponseModel.data?.add(newChat);
      update();
      scrollToBottom();

      await uploadDocument(docPath, newChat);
    }
  }

  Future<void> uploadDocument(
      String path, ChatHistoryDataModel chatModel) async {
    try {
      debugPrint("Path is $path");
      documentUploadResponse = await _apiRepository
          .uploadImageAndVideoApiWithOutLoader(path, "document",
              (int sent, int total) {
        double progress = sent / total;
        int percentage = (progress * 100).toInt();
        progressNotifier.value = progress;
        debugPrint("Upload progress: $percentage%");
        chatModel.uploadProgress = progress;
        update();
      });

      chatModel.uploadProgress = 1.0;
      if (chatModel.uploadProgress == 1.0) {
        isDocumentUploaded = true;
      }

      chatModel.mediaUrl = documentUploadResponse?.data?.fileName;
      chatModel.isNetwork = null;
      update();
      debugPrint("chatMediaUrl is ${chatModel.mediaUrl}");
      hitSendMessageSocket();
      update();
    } catch (e) {
      debugPrint("Exception is $e");
    } finally {
      documentUploadResponse = null;
      isDocumentUploaded = false;
      update();
    }
  }

  Future<void> uploadVideo(String path, ChatHistoryDataModel chatModel) async {
    debugPrint("Message Id of Local Video is $messageId");
    videoMessageId = messageId;
    try {
      debugPrint("Path is $path");
      videoUploadResponse = await _apiRepository.uploadVideoApiWithOutLoader(
          path, "video", messageId, (int sent, int total) {
        progress = sent / total;
        int percentage = (progress * 100).toInt();
        progressNotifier.value = progress;
        debugPrint("Upload progress: $percentage%");
        chatModel.uploadProgress = progress;
        update();
      });
      chatModel.uploadProgress = 1.0;
      if (chatModel.uploadProgress == 1.0) {
        isVideoUploaded = true;
        chatModel.isLocal = false;
        hitEditVideoMessageSocket();
        update();
      }
      update();
    } catch (e) {
      debugPrint("Exception is $e");
    } finally {
      videoUploadResponse = null;
      isVideoUploaded = false;
      update();
    }
  }



  Future<void> pickVideo() async {
    showDialog(
      context: Get.overlayContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Select Video Source')),
          content: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        child: const Icon(Icons.videocam),
                        onTap: () async {
                          Navigator.pop(context);
                          XFile? result = await ImagePicker().pickVideo(
                            source: ImageSource.camera,
                          );
                          if (result != null) {
                            ChatHistoryDataModel newChat = ChatHistoryDataModel(
                                messageType: 'VIDEO',
                                mediaUrl: result.path,
                                uploadProgress: progressNotifier.value,
                                createdAt: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                updatedAt: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                sentBy: SentBy(
                                  name: name,
                                  profilePic: profilePic,
                                  sId: userLoggedInId,
                                ),
                                isLocal: true,
                                isNetwork: false);
                            chatHistoryResponseModel.data?.add(newChat);
                            update();
                            hitVideoMessageSocket(result.path);
                            scrollToBottom();
                            await Future.delayed(const Duration(seconds: 2),
                                () {
                              uploadVideo(result.path, newChat).then((value) {
                                newChat.isLocal = false;
                                update();
                              });
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      const Text('Camera'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        child: const Icon(Icons.video_library),
                        onTap: () async {
                          Navigator.pop(context);
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.video,
                          );
                          if (result != null) {
                            ChatHistoryDataModel newChat = ChatHistoryDataModel(
                                messageType: 'VIDEO',
                                mediaUrl: result.files.single.path!,
                                uploadProgress: progressNotifier.value,
                                createdAt: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                updatedAt: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                sentBy: SentBy(
                                  name: name,
                                  profilePic: profilePic,
                                  sId: userLoggedInId,
                                ),
                                isNetwork: false,
                                isLocal: true);
                            chatHistoryResponseModel.data?.add(newChat);
                            update();
                            hitVideoMessageSocket(result.files.single.path!);
                            scrollToBottom();
                            await Future.delayed(const Duration(seconds: 2),
                                () {
                              uploadVideo(result.files.single.path!, newChat)
                                  .then((value) {
                                newChat.isLocal = false;
                                update();
                              });
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      const Text('Gallery'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void setMessageForEdit(String messageId) {
    for (var element in chatHistoryResponseModel.data ?? []) {
      if (element.sId == messageId) {
        textEditingController.text = element.message;
      }
    }
    editMessageId = messageId;
    wantToEditMessage = true;
    update();
  }

  Future<void> pickImage() async {
    showDialog(
      context: Get.overlayContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Select Image Source')),
          content: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        child: const Icon(Icons.camera_alt),
                        onTap: () async {
                          Navigator.pop(context);
                          XFile? result = await ImagePicker().pickImage(
                            source: ImageSource.camera,
                          );
                          if (result != null) {
                            // docImagePath = result.path;
                            // update();
                            // await uploadImage(result.path);
                            ChatHistoryDataModel newChat = ChatHistoryDataModel(
                                messageType: 'IMAGE',
                                mediaUrl: result.path,
                                uploadProgress: progressNotifier.value,
                                createdAt: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                updatedAt: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                sentBy: SentBy(
                                  name: name,
                                  profilePic: profilePic,
                                  sId: userLoggedInId,
                                ),
                                isNetwork: false);
                            chatHistoryResponseModel.data?.add(newChat);
                            scrollToBottom();
                            update();
                            await uploadImage(result.path, newChat);
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      const Text('Camera'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        child: const Icon(Icons.photo_library),
                        onTap: () async {
                          Navigator.pop(context);
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.image,
                          );
                          if (result != null) {
                            // docImagePath = result.files.single.path!;
                            ChatHistoryDataModel newChat = ChatHistoryDataModel(
                                messageType: 'IMAGE',
                                mediaUrl: result.files.single.path!,
                                uploadProgress: progressNotifier.value,
                                createdAt: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                updatedAt: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                sentBy: SentBy(
                                  name: name,
                                  profilePic: profilePic,
                                  sId: userLoggedInId,
                                ),
                                isNetwork: false);
                            chatHistoryResponseModel.data?.add(newChat);
                            scrollToBottom();
                            update();
                            await uploadImage(
                                result.files.single.path!, newChat);
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      const Text('Gallery'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> uploadImage(String path, ChatHistoryDataModel chatModel) async {
    try {
      imageUploadResponse = await _apiRepository
          .uploadImageAndVideoApiWithOutLoader(path, "image",
              (int sent, int total) {
        double progress = sent / total;
        int percentage = (progress * 100).toInt();
        progressNotifier.value = progress;
        debugPrint("Upload progress: $percentage%");
      });
      chatModel.uploadProgress = 1.0;
      if (chatModel.uploadProgress == 1.0) {
        isImageUploaded = true;
      }
      chatModel.mediaUrl = imageUploadResponse?.data?.fileName;
      chatModel.isNetwork = null;
      update();
      debugPrint("chatMediaUrl is ${chatModel.mediaUrl}");
      hitSendMessageSocket();

      update();
    } catch (e) {
      debugPrint("Exception is $e");
    } finally {
      // ProgressDialog.hide(Get.context!);
      imageUploadResponse = null;
      isImageUploaded = false;
      update();
    }
  }

  @override
  void dispose() {
    socketIOManager?.disconnectSocket();
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {
    appStatus = false;
    hitAppBackGroundSocket(true);
    update();
    debugPrint("App state is $appStatus");
  }

  @override
  void onResumed() {
    appStatus = true;
    hitAppBackGroundSocket(false);
    update();
    debugPrint("App state is this $appStatus");
  }

  hitAppBackGroundSocket(var isBackGround) {
    debugPrint("BackGround Socket Invoked");
    Map<String, dynamic> requestModel =
        ForumsRequestModel.backGroundRequestModel(
            appInBackGround: isBackGround, groupId: groupId);
    socketIOManager?.emitEvent(
      dataBody: requestModel,
      eventName: appBackGroundSocket,
    );
    update();
  }
}
