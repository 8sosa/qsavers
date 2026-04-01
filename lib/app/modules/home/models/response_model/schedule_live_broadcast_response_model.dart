class ScheduleLiveBroadCastResponseModel {
  bool? success;
  var message;
  Data? data;

  ScheduleLiveBroadCastResponseModel({this.success, this.message, this.data});

  ScheduleLiveBroadCastResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  var campaignName;
  var createdBy;
  int? quantity;
  int? totalQuantity;
  int? soldQuantity;
  var sellerId;
  var status;
  var productId;
  var groupId;
  int? oneProductPrice;
  int? totalPrice;
  int? userJoined;
  int? startDate;
  int? endDate;
  var image;
  var video;
  var liveStartDate;
  var liveStartTime;
  bool? isLive;
  bool? isLiveEnd;
  int? liveTimeInMilisecond;
  bool? isSchedule;
  var cancelledBy;
  bool? cancelRequested;
  bool? isDelete;
  bool? isMoneyTransfer;
  var description;
  var updatedAt;
  var createdAt;
  var cancelledAt;
  var sId;
  int? iV;

  Data(
      {this.campaignName,
        this.createdBy,
        this.quantity,
        this.totalQuantity,
        this.soldQuantity,
        this.sellerId,
        this.status,
        this.productId,
        this.groupId,
        this.oneProductPrice,
        this.totalPrice,
        this.userJoined,
        this.startDate,
        this.endDate,
        this.image,
        this.video,
        this.liveStartDate,
        this.liveStartTime,
        this.isLive,
        this.isLiveEnd,
        this.liveTimeInMilisecond,
        this.isSchedule,
        this.cancelledBy,
        this.cancelRequested,
        this.isDelete,
        this.isMoneyTransfer,
        this.description,
        this.updatedAt,
        this.createdAt,
        this.cancelledAt,
        this.sId,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    campaignName = json['campaign_name'];
    createdBy = json['created_by'];
    quantity = json['quantity'];
    totalQuantity = json['total_quantity'];
    soldQuantity = json['sold_quantity'];
    sellerId = json['seller_id'];
    status = json['status'];
    productId = json['product_id'];
    groupId = json['group_id'];
    oneProductPrice = json['one_product_price'];
    totalPrice = json['total_price'];
    userJoined = json['user_joined'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    image = json['image'];
    video = json['video'];
    liveStartDate = json['live_start_date'];
    liveStartTime = json['live_start_time'];
    isLive = json['is_live'];
    isLiveEnd = json['is_live_end'];
    liveTimeInMilisecond = json['live_time_in_milisecond'];
    isSchedule = json['is_schedule'];
    cancelledBy = json['cancelled_by'];
    cancelRequested = json['cancel_requested'];
    isDelete = json['is_delete'];
    isMoneyTransfer = json['is_money_transfer'];
    description = json['description'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    cancelledAt = json['cancelled_at'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campaign_name'] = this.campaignName;
    data['created_by'] = this.createdBy;
    data['quantity'] = this.quantity;
    data['total_quantity'] = this.totalQuantity;
    data['sold_quantity'] = this.soldQuantity;
    data['seller_id'] = this.sellerId;
    data['status'] = this.status;
    data['product_id'] = this.productId;
    data['group_id'] = this.groupId;
    data['one_product_price'] = this.oneProductPrice;
    data['total_price'] = this.totalPrice;
    data['user_joined'] = this.userJoined;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['image'] = this.image;
    data['video'] = this.video;
    data['live_start_date'] = this.liveStartDate;
    data['live_start_time'] = this.liveStartTime;
    data['is_live'] = this.isLive;
    data['is_live_end'] = this.isLiveEnd;
    data['live_time_in_milisecond'] = this.liveTimeInMilisecond;
    data['is_schedule'] = this.isSchedule;
    data['cancelled_by'] = this.cancelledBy;
    data['cancel_requested'] = this.cancelRequested;
    data['is_delete'] = this.isDelete;
    data['is_money_transfer'] = this.isMoneyTransfer;
    data['description'] = this.description;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['cancelled_at'] = this.cancelledAt;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}


