class GroupInfoDataModel {
  var sId;
  var groupName;
  var groupType;
  var updatedAt;
  var request;
  CreatedBy? createdBy;
  var isDefault;
  var membersCount;
  List<GroupMembers>? groupMembers;
  var isJoined;
  var isRequest;
  var isBlocked;
  var isOrganiser;

  GroupInfoDataModel(
      {this.sId,
      this.groupName,
      this.groupType,
      this.updatedAt,
      this.request,
      this.createdBy,
      this.isDefault,
      this.membersCount,
      this.groupMembers,
      this.isJoined,
      this.isRequest,
      this.isBlocked,
      this.isOrganiser});

  GroupInfoDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    groupName = json['group_name'];
    groupType = json['group_type'];
    request = json['request'];
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
    isJoined = json['is_joined'];
    isRequest = json['is_request'];
    isBlocked = json['is_blocked'];
    isOrganiser = json['is_organiser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['group_name'] = this.groupName;
    data['group_type'] = this.groupType;
    data['request'] = this.request;
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
    data['is_joined'] = this.isJoined;
    data['is_request'] = this.isRequest;
    data['is_blocked'] = this.isBlocked;
    data['is_organiser'] = this.isOrganiser;
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
  var isOnline;
  var isReport;

  GroupMembers(
      {this.sId,
      this.profilePic,
      this.name,
      this.role,
      this.isOnline,
      this.isReport});

  GroupMembers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePic = json['profile_pic'];
    name = json['name'];
    role = json['role'];
    isBlocked = json['is_blocked'];
    isOnline = json['is_online'];
    isReport = json['is_report'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profile_pic'] = this.profilePic;
    data['name'] = this.name;
    data['role'] = this.role;
    data['is_blocked'] = this.isBlocked;
    data['is_online'] = this.isOnline;
    data['is_report'] = this.isReport;
    return data;
  }
}
