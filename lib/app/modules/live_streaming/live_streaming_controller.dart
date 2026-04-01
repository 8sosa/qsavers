import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:heart_overlay/heart_overlay.dart';
import 'package:quantity_savers/app/core/values/socket_events.dart';
import 'package:quantity_savers/app/modules/forums/models/forums_request_model.dart';

import '../../export.dart';
import 'heart_animation.dart';
import 'live_stream_message_model.dart';

class LiveController extends GetxController with WidgetsBindingObserver {
  int? userType = 0; //0 for user, 1 for participant
  RtcEngine? engine;
  var micOn = true.obs;
  var cameraOn = true.obs;

 ScrollController commentsListController =ScrollController();
  RxInt isPrintCount = 0.obs;
  late TextEditingController commentController;
  late FocusNode commentFocusNode;
  List<Message> messages = [];
  late AnimationController animationController;
  bool isPlayingHeartBlastAnimation = false;
  Timer? timer;
  HeartOverlayController heartOverlayController=HeartOverlayController();

  int remoteUid = 0;
  RxList<int> remoteViewerIds = RxList.empty();

  bool myCam = true;
  RxBool isAudio = true.obs;
  RxBool isVideo = true.obs;
  int pageNumber = 0;
  ScrollController scrollController = ScrollController();
  RxBool showParticipantsLoader = false.obs;
  RxBool showParticipantsLoaderFirst = false.obs;
  RxBool showProductDetailShimmer = false.obs;
  var campaignId;
  var campaignName;
  var channelName;
  var token;
  var createdById;
  var type;
  RxBool isParticipant = false.obs; //viewer
  bool forThisScreen = false;
  String commentConnectioId = "";
  RxBool isCompleted = false.obs;
  DateTime? debateTimeLeft;
  Timer? debateTimer;
  RxBool debateEnd = false.obs;
  LocalStorage _localStorage = LocalStorage();
  LoginDataModel loginDataModel = LoginDataModel();
  dynamic userLoggedInId = "";
  var profilePic;
  var creatorName;
  var shownId = 0;
  var productImage;
  List<Widget> _hearts = [];
  List<Widget> get hearts => _hearts.toList();
  int animationCount = 0;

  void addHeart() {
    animationCount++;
    debugPrint("Emptyyyyy ${_hearts.length}");
    _hearts.add(HeartAnimation());
    if(animationCount>=10)
      {
        _hearts.clear();
        animationCount=0;
      }

    update();
  }




  bool get isTextFieldEnable => commentController.text.isNotEmpty;
  @override
  void onInit() {
    _getArgs();
    getLoggedInUserId();
    _getSavedProfileData();
    _initController();
    hitJoinSocket();
    WidgetsBinding.instance.addObserver(this);
    socketIOManager?.listenEvent(
        eventName: receivedMessageEvent,
        onDataReceived: (data) {
          if (data != null) {
            debugPrint("Data type is ${data.runtimeType}");
            final message = Message.fromJson(data);
            if (message.campaignId == campaignId) {
                messages.add(message);
              scrollToBottom();
            }
            debugPrint("LiveStream Data is $data");
            scrollToBottom();
          }
          update();
        });
    socketIOManager?.listenEvent(
        eventName: sendHeartEvent,
        onDataReceived: (data) {
          debugPrint("Dataa $data");
          if (data != null) {
            debugPrint("Datum $data");
            addHeart();
          }
          update();
        });
    socketIOManager?.listenEvent(
        eventName: leaveCallEvent,
        onDataReceived: (data) {
          if (data != null) {
            leaveCall();
            Get.back();
          }
          update();
        });

    super.onInit();
  }
  void toggleMic() async{
    engine?.setEnableSpeakerphone( !micOn.value);
    engine?.enableLocalAudio(!micOn.value);
     micOn.value = !micOn.value;
     update();

  }
  void toggleCamera() async{
    engine?.enableLocalVideo(!cameraOn.value);
    cameraOn.value = !cameraOn.value;
    update();
  }

  scrollToBottom() async {
    await Future.delayed(Duration(milliseconds: 100));
    if (commentsListController.hasClients) {
      commentsListController.animateTo(commentsListController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn);
      commentsListController.jumpTo(commentsListController.position.maxScrollExtent);
      update();
    }
  }

  void getLoggedInUserId() async {
    LoginDataModel userInfo = await _localStorage.getSavedLoginData();
    userLoggedInId = userInfo.sId;
    debugPrint("UserId is $userLoggedInId");
    update();
  }

  void _getSavedProfileData() async {
    final data = await _localStorage.getSavedLoginData();
    if (data != null) {
      loginDataModel = data;
    }
  }

  Future<void> onFieldSubmitted() async {
    if (!isTextFieldEnable) return;

    hitSendMessageSocket();
    update();
  }

  hitSendHeartSocket() async
  {

    debugPrint("heart is $campaignId");
    Map<String, dynamic> requestModel =
    ForumsRequestModel.sendHeartRequestModel(
        campaignId: campaignId);
    debugPrint("RequestModel is $requestModel");
   await socketIOManager?.emitEvent(
        dataBody: requestModel, eventName: sendHeartEvent);
  }

  hitLeaveCall() async
  {
    debugPrint("Leave");
    Map<String, dynamic> requestModel =
    ForumsRequestModel.sendHeartRequestModel(
        campaignId: campaignId);
    await socketIOManager?.emitEvent(
        dataBody: requestModel, eventName: leaveCallEvent);
  }

  hitJoinSocket() {
    Map<String, dynamic> requestModel =
        ForumsRequestModel.initForumChatRequestModel(
            groupRequestId: campaignId);
    socketIOManager?.emitEvent(
        dataBody: requestModel, eventName: initForumSentRequestChatEvent);


        hitSendMessageSocket("JOINED");


  }

  hitSendMessageSocket([String?message]) async {
    debugPrint("Hello");
    Map<String, dynamic> requestModel =
        ForumsRequestModel.sendMessageRequestModel(
            message: message!=null ? message: commentController.text.trim(),
            messageType: "TEXT",
            campaignId: campaignId);
    await socketIOManager?.emitEvent(
      dataBody: requestModel,
      eventName: sendMessageEvent,
    );
    commentController.text = "";
  }

  Future<void> initAgora() async {
    if (agoraAppId.isEmpty) {
      debugPrint('Please add your Agora App ID in main.dart');
      return;
    }

    await [Permission.camera, Permission.microphone].request();
    try {
      engine = createAgoraRtcEngine();

      await engine?.initialize(RtcEngineContext(
        appId: agoraAppId,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      ));

      await engine?.registerLocalUserAccount(
        appId: agoraAppId,
        userAccount: userLoggedInId,
      );
    } catch (e, stackTrace) {
      debugPrint("error on agora init $e ======== $stackTrace");
    }

    await engine?.setVideoEncoderConfiguration(const VideoEncoderConfiguration(
        dimensions: VideoDimensions(width: 1920, height: 1080)));
    await engine?.enableVideo();
    await engine?.enableAudio();
    _agoraEventHandler();
    joinChannel();
  }

  void joinChannel() async {
    print("joinChannel id ${campaignId}");
    await engine?.joinChannelWithUserAccount(
      token: token,
      options: ChannelMediaOptions(
          autoSubscribeAudio: true,
          enableAudioRecordingOrPlayout: true,
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
          clientRoleType: ClientRoleType.clientRoleBroadcaster),
      channelId: campaignId ?? "",
      userAccount: userLoggedInId,
    );
  }

  _agoraEventHandler() {
    engine?.registerEventHandler(RtcEngineEventHandler(
      onError: (err, msg) {
        debugPrint('[onError] err: $err, msg: $msg');
      },
      onLocalUserRegistered: (uid, userAccount) {
        debugPrint(
            'agora [onLocalUserRegistered]: uid $uid, userAccount $userAccount, ');
      },
      onJoinChannelSuccess: (connection, elapsed) {
        debugPrint(
            'aagorauser [onJoinChannelSuccess]: connection $connection, elapsed $elapsed userData: ${loginDataModel?.email}');

        if (createdById != userLoggedInId) {
          engine?.enableLocalAudio(false);
          engine?.enableLocalVideo(false);
          addRemoteViewer(connection.localUid!);
        }
        update();
      },
      onUserInfoUpdated: (uid, info) {
        debugPrint(
            'aagorauser [onUserInfoUpdated]: uid $uid, info $info, userData: ${loginDataModel?.email}');
        var isAdded = false;
        if (isAdded == false) {
          addRemoteViewer(uid);
        }

        update();
      },
      onUserJoined: (connection, remoteUid, elapsed) async {
        debugPrint(
            'aagorauser [onUserJoined]: connection $connection, remoteUid: $remoteUid elapsed $elapsed  userData: ${loginDataModel?.email}');
        var isAdded = false;
        UserInfo? kData = await engine?.getUserInfoByUid(remoteUid);

        debugPrint(
            'aagorauser  isAdded $isAdded, userData: ${loginDataModel?.name} isParticipant ${isParticipant.value} userData: ${loginDataModel?.email}');
        if (kData?.userAccount == createdById) {
          shownId = remoteUid;
        } else {
          addRemoteViewer(remoteUid);
        }
        if (isParticipant.value == false) {
          refresh();
        }

        update();
      },
      onLeaveChannel: (connection, stats) {
        debugPrint(
            'aagorauser [onLeaveChannel]: connection $connection, stats $stats  userData: ${loginDataModel?.email}');

        remoteViewerIds
            .removeWhere((element) => element == connection.localUid);
        remoteViewerIds.refresh();
        update();
      },
      onUserMuteAudio: (connection, remoteUid, muted) {
        debugPrint(
            'agora [onUserMuteAudio]: connection $connection, remoteUid $remoteUid, muted $muted');
      },
      onUserMuteVideo: (connection, remoteUid, muted) {
        debugPrint(
            'agora [onUserMuteVideo]: connection $connection, remoteUid $remoteUid , muted $muted');
      },
      onLocalVideoStateChanged: (source, state, reason) {
        debugPrint(
            'agora [onLocalVideoStateChanged]: source $source,  state $state, reason $reason');

      },
      onRemoteAudioStateChanged:
          (connection, remoteUid, state, reason, elapsed) async{
        debugPrint(
            'agora [onRemoteAudioStateChanged]: connection $connection, remoteUid $remoteUid , state $state, reason $reason');
        UserInfo? kData = await engine?.getUserInfoByUid(remoteUid);
        if(createdById == kData?.userAccount)
        {
          if (reason == RemoteAudioStateReason.remoteAudioReasonRemoteMuted)
          {
            micOn.value=false;
          }
          else if(reason == RemoteAudioStateReason.remoteAudioReasonRemoteUnmuted) {
            micOn.value = true;
          }
        }
        update();
      },
      onRemoteVideoStateChanged:
          (connection, remoteUid, state, reason, elapsed) async{
        debugPrint(
            'agora [onRemoteVideoStateChanged]: connection $connection, remoteUid $remoteUid , state $state, reason $reason');
        UserInfo? kData = await engine?.getUserInfoByUid(remoteUid);
        debugPrint(
            'agora [onRemoteVideoStateChanged]: connection ${createdById == kData?.userAccount}]');

        if(createdById == kData?.userAccount)
        {
          if (reason == RemoteVideoStateReason.remoteVideoStateReasonRemoteUnmuted)
          {
            cameraOn.value=true;
          }
          else if (reason == RemoteVideoStateReason.remoteVideoStateReasonRemoteMuted) cameraOn.value = false;
        }
        update();
      },
      onUserOffline: (connection, remoteUid, reason) {
        debugPrint(
            'aagorauser [onUserOffline]: connection $connection, remoteUid $remoteUid, reason $reason, userData: ${loginDataModel?.email}');

        remoteViewerIds.removeWhere((element) => element == remoteUid);
        remoteViewerIds.refresh();
        debugPrint(
            'aaagorauser remoteViewerIds ${remoteViewerIds.length}, userData: ${loginDataModel?.email}');

        update();
      },

    ));
  }

  Future<void> refreshList() async {
    pageNumber = 0;
  }

  void leaveCall() async {
    await engine?.leaveChannel();
    await engine?.release();
  }

  Future<bool> handleBackButton() async {
    if (createdById == userLoggedInId) {
      await hitLeaveCall();
    } else {
       leaveCall();
    }
    return true;
  }

  void _getArgs() {
    if (Get.arguments != null) {
      campaignId = Get.arguments[argCampaignId] ?? "";
      channelName = Get.arguments[argChannelName] ?? "";
      token = Get.arguments[argToken] ?? "";
      createdById = Get.arguments[argCreatedById] ?? "";
      campaignName=Get.arguments[argCampaignName] ?? "";
      creatorName=Get.arguments[argCreatorName] ?? "";
      profilePic=Get.arguments[argProfilePic] ?? "";
      productImage=Get.arguments[argProductImage] ?? "";
      debugPrint("CreatedById is $createdById");
    }
    update();
  }

  void _onCommentNodeChange() {
    debugPrint("Focus: ${commentFocusNode.hasFocus.toString()}");
  }

  void _initController() {
    commentsListController = ScrollController();
    commentController = TextEditingController();
    commentFocusNode = FocusNode();

    commentFocusNode.addListener(_onCommentNodeChange);
  }

  @override
  void onReady() {
    initAgora();
    _scrollDown();

    super.onReady();
  }


  void _scrollDown() {
    commentsListController.animateTo(
      commentsListController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _disposeControllers() {
    commentController.dispose();
    commentFocusNode.dispose();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    commentsListController.dispose();
    timer?.cancel();
    timer = null;

    leaveCall();
    _disposeControllers();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      cameraOn.value = false;
      micOn.value = false;
      engine?.enableLocalAudio(false);
      engine?.enableLocalVideo(false);
      engine?.setEnableSpeakerphone(false);
    } else if (state == AppLifecycleState.resumed) {
      cameraOn.value = true;
      micOn.value = true;
      engine?.enableLocalAudio(true);
      engine?.enableLocalVideo(true);
      engine?.setEnableSpeakerphone(true);
    }
       update();
  }

  void addRemoteViewer(int uid) {
    if (uid == createdById) {
      shownId = uid;
    } else if (!remoteViewerIds.contains(uid)) {
      remoteViewerIds.add(uid);
      remoteViewerIds.refresh();
    }
  }


}
