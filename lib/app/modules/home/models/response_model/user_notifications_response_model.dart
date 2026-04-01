class UserNotificationResponseModel {
  Data? data;

  UserNotificationResponseModel({this.data});

  UserNotificationResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? unreadCount;
  List<ReadNotifications>? readNotifications;
  List<UnreadNotifications>? unreadNotifications;

  Data({this.unreadCount, this.readNotifications, this.unreadNotifications});

  Data.fromJson(Map<String, dynamic> json) {
    unreadCount = json['unread_count'];
    if (json['read_notifications'] != null) {
      readNotifications = <ReadNotifications>[];
      json['read_notifications'].forEach((v) {
        readNotifications!.add(new ReadNotifications.fromJson(v));
      });
    }
    if (json['unread_notifications'] != null) {
      unreadNotifications = <UnreadNotifications>[];
      json['unread_notifications'].forEach((v) {
        unreadNotifications!.add(new UnreadNotifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unread_count'] = this.unreadCount;
    if (this.readNotifications != null) {
      data['read_notifications'] =
          this.readNotifications!.map((v) => v.toJson()).toList();
    }
    if (this.unreadNotifications != null) {
      data['unread_notifications'] =
          this.unreadNotifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UnreadNotifications {
  String? sId;
  String? campaignId;
  String? campaignRequestedId;
  String? userId;
  String? orderId;
  String? orderProductId;
  String? title;
  String? type;
  List<String>? images;
  String? message;
  bool? readByUser;
  bool? clearForUser;
  String? createdAt;

  UnreadNotifications(
      {this.sId,
        this.userId,
        this.orderId,
        this.orderProductId,
        this.title,
        this.type,
        this.images,
        this.message,
        this.readByUser,
        this.clearForUser,
        this.campaignId,
        this.campaignRequestedId,
        this.createdAt});

  UnreadNotifications.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    campaignId=json['campaign_id'];
    campaignRequestedId=json['campaign_request_id'];
    userId = json['user_id'];
    orderId = json['order_id'];
    orderProductId = json['orderProduct_id'];
    title = json['title'];
    type = json['type'];
    images = json['images'].cast<String>();
    message = json['message'];
    readByUser = json['read_by_user'];
    clearForUser = json['clear_for_user'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['campaign_id'] = this.campaignId;
    data['campaign_request_id'] = this.campaignRequestedId;
    data['order_id'] = this.orderId;
    data['orderProduct_id'] = this.orderProductId;
    data['title'] = this.title;
    data['type'] = this.type;
    data['images'] = this.images;
    data['message'] = this.message;
    data['read_by_user'] = this.readByUser;
    data['clear_for_user'] = this.clearForUser;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class ReadNotifications {
  String? sId;
  String? campaignId;
  String? campaignRequestedId;
  String? userId;
  String? orderId;
  String? orderProductId;
  String? title;
  String? type;
  List<String>? images;
  String? message;
  bool? readByUser;
  bool? clearForUser;
  String? createdAt;

  ReadNotifications(
      {this.sId,
        this.userId,
        this.orderId,
        this.orderProductId,
        this.title,
        this.type,
        this.images,
        this.message,
        this.readByUser,
        this.clearForUser,
        this.campaignId,this.campaignRequestedId,
        this.createdAt});

  ReadNotifications.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    campaignId=json['campaign_id'];
    campaignRequestedId=json['campaign_request_id'];
    userId = json['user_id'];
    orderId = json['order_id'];
    orderProductId = json['orderProduct_id'];
    title = json['title'];
    type = json['type'];
    images = json['images'].cast<String>();
    message = json['message'];
    readByUser = json['read_by_user'];
    clearForUser = json['clear_for_user'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['campaign_id'] = this.campaignId;
    data['campaign_request_id'] = this.campaignRequestedId;
    data['user_id'] = this.userId;
    data['order_id'] = this.orderId;
    data['orderProduct_id'] = this.orderProductId;
    data['title'] = this.title;
    data['type'] = this.type;
    data['images'] = this.images;
    data['message'] = this.message;
    data['read_by_user'] = this.readByUser;
    data['clear_for_user'] = this.clearForUser;
    data['created_at'] = this.createdAt;
    return data;
  }
}
