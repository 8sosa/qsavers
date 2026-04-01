class ForumMediaResponseModel {
  Data? data;

  ForumMediaResponseModel({this.data});

  ForumMediaResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Datum>? data;
  int? count;

  Data({this.data, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Datum>[];
      json['data'].forEach((v) {
        data!.add(new Datum.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class Datum {
  String? sId;
  String? groupId;
  SentBy? sentBy;
  var sentTo;
  var groupReqId;
  var campaignId;
  var type;
  String? messageType;
  String? message;
  String? mediaUrl;
  bool? isHide;
  List<String>? readBy;
  String? thumbNail;
  var localIdentifier;
  var messageId;
  String? token;
  bool? isDelete;
  int? isRead;
  String? updatedAt;
  String? createdAt;
  int? readState;

  Datum(
      {this.sId,
        this.groupId,
        this.sentBy,
        this.sentTo,
        this.groupReqId,
        this.campaignId,
        this.type,
        this.messageType,
        this.message,
        this.mediaUrl,
        this.isHide,
        this.readBy,
        this.thumbNail,
        this.localIdentifier,
        this.messageId,
        this.token,
        this.isDelete,
        this.isRead,
        this.updatedAt,
        this.createdAt,
        this.readState});

  Datum.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
    readBy = json['read_by'].cast<String>();
    thumbNail = json['thumb_nail'];
    localIdentifier = json['local_identifier'];
    messageId = json['message_id'];
    token = json['token'];
    isDelete = json['is_delete'];
    isRead = json['is_read'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    readState = json['read_state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
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
    data['read_by'] = this.readBy;
    data['thumb_nail'] = this.thumbNail;
    data['local_identifier'] = this.localIdentifier;
    data['message_id'] = this.messageId;
    data['token'] = this.token;
    data['is_delete'] = this.isDelete;
    data['is_read'] = this.isRead;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['read_state'] = this.readState;
    return data;
  }
}

class SentBy {
  String? sId;
  String? profilePic;
  String? name;

  SentBy({this.sId, this.profilePic, this.name});

  SentBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePic = json['profile_pic'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profile_pic'] = this.profilePic;
    data['name'] = this.name;
    return data;
  }
}


