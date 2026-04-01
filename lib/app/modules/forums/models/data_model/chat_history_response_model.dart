class ChatHistoryDataModel {
  var groupId;
  SentBy? sentBy;
  var sentTo;
  var groupReqId;
  var campaignId;
  var type;
  var messageType;
  var message;
  var mediaUrl;
  var isHide;
  var thumbNail;
  var messageId;
  var isDelete;
  var createdAt;
  var updatedAt;
  var sId;
  var readState;
  var iV;
  var uploadProgress;
  var isNetwork;
 var isLocal;
 var inProgress;

  ChatHistoryDataModel(
      {this.groupId,
      this.sentBy,
      this.sentTo,
      this.groupReqId,
      this.campaignId,
      this.type,
      this.messageType,
      this.message,
      this.mediaUrl,
      this.isHide,
      this.thumbNail,
      this.messageId,
      this.isDelete,
      this.createdAt,
      this.updatedAt,
        this.readState,
      this.sId,
        this.uploadProgress,
        this.isNetwork=true,
        this.isLocal=false,
        this.inProgress,
      this.iV});

  ChatHistoryDataModel.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    sentBy =
        json['sent_by'] != null ? new SentBy.fromJson(json['sent_by']) : null;
    sentTo = json['sent_to'];
    groupReqId = json['group_req_id'];
    campaignId = json['campaign_id'];
    type = json['type'];
    messageType = json['message_type'];
    message = json['message'];
    mediaUrl = json['media_url'];
    isHide = json['is_hide'];
    thumbNail = json['thumb_nail'];
    messageId = json['message_id'];
    isDelete = json['is_delete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sId = json['_id'];
    iV = json['__v'];
    readState=json['read_state'];
    uploadProgress = json['upload_progress']?.toDouble();
    isNetwork = json ['is_network'];
    isLocal = json['isLocal'];
    inProgress=json['in_progress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    if (this.sentBy != null) {
      data['sent_by'] = this.sentBy!.toJson();
    }
    data['sent_to'] = this.sentTo;
    data['group_req_id'] = this.groupReqId;
    data['campaign_id'] = this.campaignId;
    data['type'] = this.type;
    data['message_type'] = this.messageType;
    data['message'] = this.message;
    data['media_url'] = this.mediaUrl;
    data['is_hide'] = this.isHide;
    data['thumb_nail'] = this.thumbNail;
    data['message_id'] = this.messageId;
    data['is_delete'] = this.isDelete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    data['read_state']=this.readState;
    data['is_network']=this.isNetwork;
    data['isLocal']=this.isLocal;
    data['in_progress']=this.inProgress;
    if (this.uploadProgress != null) {
      data['upload_progress'] = this.uploadProgress;
    }
    return data;
  }
}

class SentBy {
  var profilePic;
  var name;
  var sId;

  SentBy({this.profilePic, this.name, this.sId});

  SentBy.fromJson(Map<String, dynamic> json) {
    profilePic = json['profile_pic'];
    name = json['name'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_pic'] = this.profilePic;
    data['name'] = this.name;
    data['_id'] = this.sId;
    return data;
  }
}
