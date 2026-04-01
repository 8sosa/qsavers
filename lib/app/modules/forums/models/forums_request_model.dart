import "../../../export.dart";

class ForumsRequestModel {
  /*================================================== Private Forum Join Request Model==============================================*/
  static privateForumJoinRequestModel({
    String? groupId,
    String? message,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["group_id"] = groupId;
    data["message"] = message;
    return data;
  }

  /*================================================== Initialize Forum Sent Request Chat Model==============================================*/
  static initForumChatRequestModel({
    String? groupRequestId,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["group_id"] = groupRequestId;
    return data;
  }

  /*================================================== Send Message Request Chat Model==============================================*/
  static sendMessageRequestChatRequestModel(
      {String? message,
      String? mediaUrl,
      String? groupRequestId,
      String? groupId,
      var messageType}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["message"] = message;
    data["media_url"] = mediaUrl;
    data["group_req_id"] = groupRequestId;
    data["group_id"] = groupId;
    data["message_type"] = messageType;
    return data;
  }

  /*================================================== Send Video Message Request Chat Model==============================================*/
  static sendVideoMessageRequestChatRequestModel(
      {String? messageId,
        String? mediaUrl,
       }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["message_id"] = messageId;
    data["media_url"] = mediaUrl;
    return data;
  }

  /*================================================== Manage Request Model==============================================*/
  static manageRequestModel({String? requestId, String? status}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["request_id"] = requestId;
    data["status"] = status;
    return data;
  }

  /*================================================== Request Chat History Request Chat Model==============================================*/
  static requestChatHistoryRequestModel({
    String? requestId,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["request_id"] = requestId;
    return data;
  }

  /*================================================== Group Chat History Request Chat Model==============================================*/
  static groupChatHistoryRequestModel({
    String? groupId,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["group_id"] = groupId;
    return data;
  }

  /*================================================== Group Campaign Request Model==============================================*/
  static groupCampaignRequestModel({
    String? groupId,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = groupId;
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*================================================== Delete Group Request Model==============================================*/
  static exitDeleteGroupRequestModel({
    String? groupId,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = groupId;
    return data;
  }

  /*================================================== edit Members Request Model==============================================*/
  static editMembersRequestModel({
    String? groupId,
    String? memberId,
    String? type,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["group_id"] = groupId;
    data["member_id"] = memberId;
    data["type"] = type;
    return data;
  }
  /*================================================== Report Members Request Model==============================================*/
  static reportMembersRequestModel({

    String? memberId,
    String? reason,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["reported_user_id"] = memberId;
    data["reason"] =reason;
    return data;
  }

  /*================================================== Delete Message Request Chat Model==============================================*/
  static deleteMessageRequestChatRequestModel(
      {String? messageId,
        }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["message_id"] = messageId;
    return data;
  }

  /*================================================== Read Message Request Chat Model==============================================*/
  static readMessageRequestChatRequestModel(
      {String? messageId,
        String? groupId
      }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["message_id"] = messageId;
    data["group_id"] = groupId;

    return data;
  }


  /*================================================== BackGround Request Chat Model==============================================*/
  static backGroundRequestModel(
      {var appInBackGround,
        String? groupId
      }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["is_app_in_background"] = appInBackGround;
    data["group_id"] = groupId;
    return data;
  }

/*================================================== Edit Message Request Chat Model==============================================*/
  static EditMessageRequestChatRequestModel(
      {String? messageId,
        String? message
      }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["message_id"] = messageId;
    data["message"]=message;
    return data;
  }
/*================================================== Start Live Request Model==============================================*/
  static startLiveRequestModel({
    String? id,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["campaign_id"] = id;
    return data;
  }

  /*================================================== ScheduleLiveBroadCase Request Model==============================================*/
  static scheduleLiveBroadCastRequestModel({
    String? date,
    String? time,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["live_start_date"] = date;
    data["live_start_time"] = time;
    return data;
  }

  /*================================================== Live Stream Send Message Request Chat Model==============================================*/
  static sendMessageRequestModel(
        {String? message,
        String? campaignId,
        var messageType}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["message"] = message;
    data["campaign_id"] = campaignId;
    data["message_type"] = messageType;
    return data;
  }
  /*================================================== Heart Request Chat Model==============================================*/
  static sendHeartRequestModel({
    String? campaignId,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["campaign_id"] = campaignId;
    return data;
  }

  /*==================================================Edit ScheduleLiveBroadCase Request Model==============================================*/
  static editScheduleLiveBroadCastRequestModel({
    String? date,
    String? time,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["live_start_date"] = date;
    data["live_start_time"] = time;
    return data;
  }

  /*================================================== Forum Media Request Model==============================================*/
  static forumMediaRequestModel({
    String? type,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["type"] = type;
    return data;
  }
}
