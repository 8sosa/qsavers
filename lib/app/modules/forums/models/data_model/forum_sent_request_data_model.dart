class ForumRequestDataModel {
  var sentBy;
  var sentTo;
  GroupId? groupId;
  var status;
  var message;
  var updatedAt;
  var createdAt;
  var sId;
  var groupName;
  var groupType;
  var groupMembersCount;
  var groupReqCount;

  ForumRequestDataModel(
      {this.sentBy,
      this.sentTo,
      this.groupId,
      this.status,
      this.message,
      this.updatedAt,
      this.createdAt,
      this.sId,
      this.groupName,
      this.groupType,
      this.groupMembersCount,
      this.groupReqCount});

  ForumRequestDataModel.fromJson(Map<String, dynamic> json) {
    sentBy = json['sent_by'];
    sentTo = json['sent_to'];
    groupId = json['group_id'] != null
        ? new GroupId.fromJson(json['group_id'])
        : null;
    status = json['status'];
    message = json['message'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    sId = json['_id'];
    groupName = json['group_name'];
    groupType = json['group_type'];
    groupMembersCount = json['group_members_count'];
    groupReqCount = json['group_req_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sent_by'] = this.sentBy;
    data['sent_to'] = this.sentTo;
    if (this.groupId != null) {
      data['group_id'] = this.groupId!.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['_id'] = this.sId;
    data['group_name'] = this.groupName;
    data['group_type'] = this.groupType;
    data['group_members_count'] = this.groupMembersCount;
    data['group_req_count'] = this.groupReqCount;
    return data;
  }
}

class GroupId {
  CreatedBy? createdBy;
  var groupName;
  var sId;

  GroupId({this.createdBy, this.groupName, this.sId});

  GroupId.fromJson(Map<String, dynamic> json) {
    createdBy = json['created_by'] != null
        ? new CreatedBy.fromJson(json['created_by'])
        : null;
    groupName = json['group_name'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy!.toJson();
    }
    data['group_name'] = this.groupName;
    data['_id'] = this.sId;
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
