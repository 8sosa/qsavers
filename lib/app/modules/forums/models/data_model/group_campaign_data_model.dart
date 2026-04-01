class GroupCampaignDataModel {
  var count;
  GroupDetail? groupDetail;
  List<GroupCampaignSubDataModel>? data;

  GroupCampaignDataModel({this.count, this.groupDetail, this.data});

  GroupCampaignDataModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    groupDetail = json['group_detail'] != null
        ? new GroupDetail.fromJson(json['group_detail'])
        : null;
    if (json['data'] != null) {
      data = <GroupCampaignSubDataModel>[];
      json['data'].forEach((v) {
        data!.add(new GroupCampaignSubDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.groupDetail != null) {
      data['group_detail'] = this.groupDetail!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupDetail {
  var sId;
  var groupName;
  var groupType;
  var updatedAt;
  CreatedBy? createdBy;
  var isDefault;
  var membersCount;
  List<GroupMembers>? groupMembers;

  GroupDetail(
      {this.sId,
      this.groupName,
      this.groupType,
      this.updatedAt,
      this.createdBy,
      this.isDefault,
      this.membersCount,
      this.groupMembers});

  GroupDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    groupName = json['group_name'];
    groupType = json['group_type'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'] != null
        ? new CreatedBy.fromJson(json['created_by'])
        : null;
    isDefault = json['is_default'];
    membersCount = json['members_count'];
    if (json['group_members'] != null) {
      groupMembers = <GroupMembers>[];
      json['group_members'].forEach((v) {
        groupMembers!.add(new GroupMembers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['group_name'] = this.groupName;
    data['group_type'] = this.groupType;
    data['updated_at'] = this.updatedAt;
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy!.toJson();
    }
    data['is_default'] = this.isDefault;
    data['members_count'] = this.membersCount;
    if (this.groupMembers != null) {
      data['group_members'] =
          this.groupMembers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreatedBy {
  var profilePic;
  var name;
  var sId;

  CreatedBy({this.profilePic, this.name, this.sId});

  CreatedBy.fromJson(Map<String, dynamic> json) {
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

class GroupMembers {
  var sId;
  var profilePic;
  var name;
  var role;
  var isBlocked;
  var isReport;

  GroupMembers(
      {this.sId,
      this.profilePic,
      this.name,
      this.role,
      this.isBlocked,
      this.isReport});

  GroupMembers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePic = json['profile_pic'];
    name = json['name'];
    role = json['role'];
    isBlocked = json['is_blocked'];
    isReport = json['is_report'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profile_pic'] = this.profilePic;
    data['name'] = this.name;
    data['role'] = this.role;
    data['is_blocked'] = this.isBlocked;
    data['is_report'] = this.isReport;
    return data;
  }
}

class GroupCampaignSubDataModel {
  var sId;
  var campaignName;
  var createdBy;
  var quantity;
  var totalQuantity;
  var soldQuantity;
  var sellerId;
  var status;
  var productId;
  var groupId;
  var oneProductPrice;
  var totalPrice;
  var userJoined;
  var startDate;
  var endDate;
  var image;
  var video;
  var liveStartDate;
  var liveStartTime;
  var isLive;
  var isLiveEnd;
  var liveTimeInMilisecond;
  var isSchedule;
  var cancelledBy;
  var cancelRequested;
  var isDelete;
  var isMoneyTransfer;
  var description;
  var updatedAt;
  var createdAt;
  var cancelledAt;

  GroupCampaignSubDataModel(
      {this.sId,
      this.campaignName,
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
      this.cancelledAt});

  GroupCampaignSubDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
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
    return data;
  }
}
