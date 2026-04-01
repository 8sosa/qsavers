
class Message {
  final String id;
  final dynamic groupId;
  final Sender sentBy;
  final dynamic sentTo;
  final dynamic groupReqId;
  final String campaignId;
  final dynamic type;
  final String messageType;
  final String message;
  final dynamic mediaUrl;
  final bool isHide;
  final List<dynamic> readBy;
  final dynamic thumbnail;
  final dynamic localIdentifier;
  final String token;
  final bool isDelete;
  final int isRead;
  final String updatedAt;
  final String createdAt;
  final int v;

  Message({
    required this.id,
    required this.groupId,
    required this.sentBy,
    required this.sentTo,
    required this.groupReqId,
    required this.campaignId,
    required this.type,
    required this.messageType,
    required this.message,
    required this.mediaUrl,
    required this.isHide,
    required this.readBy,
    required this.thumbnail,
    required this.localIdentifier,
    required this.token,
    required this.isDelete,
    required this.isRead,
    required this.updatedAt,
    required this.createdAt,
    required this.v,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['_id'],
      groupId: json['group_id'],
      sentBy: Sender.fromJson(json['sent_by']),
      sentTo: json['sent_to'],
      groupReqId: json['group_req_id'],
      campaignId: json['campaign_id'],
      type: json['type'],
      messageType: json['message_type'],
      message: json['message'],
      mediaUrl: json['media_url'],
      isHide: json['is_hide'],
      readBy: List<dynamic>.from(json['read_by']),
      thumbnail: json['thumb_nail'],
      localIdentifier: json['local_identifier'],
      token: json['token'],
      isDelete: json['is_delete'],
      isRead: json['is_read'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'group_id': groupId,
      'sent_by': sentBy.toJson(),
      'sent_to': sentTo,
      'group_req_id': groupReqId,
      'campaign_id': campaignId,
      'type': type,
      'message_type': messageType,
      'message': message,
      'media_url': mediaUrl,
      'is_hide': isHide,
      'read_by': List<dynamic>.from(readBy),
      'thumb_nail': thumbnail,
      'local_identifier': localIdentifier,
      'token': token,
      'is_delete': isDelete,
      'is_read': isRead,
      'updated_at': updatedAt,
      'created_at': createdAt,
      '__v': v,
    };
  }
}

class Sender {
  final String id;
  final dynamic profilePic;
  final String name;

  Sender({
    required this.id,
    required this.profilePic,
    required this.name,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['_id'],
      profilePic: json['profile_pic'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'profile_pic': profilePic,
      'name': name,
    };
  }
}


