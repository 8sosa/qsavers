class JoinPublicGroupDataModel {
  var groupType;
  var createdBy;
  var groupName;
  var token;
  var isDeleted;
  var isDefault;
  var updatedAt;
  var createdAt;
  var sId;
  List<GroupMembers>? groupMembers;
  var iV;

  JoinPublicGroupDataModel(
      {this.groupType,
      this.createdBy,
      this.groupName,
      this.token,
      this.isDeleted,
      this.isDefault,
      this.updatedAt,
      this.createdAt,
      this.sId,
      this.groupMembers,
      this.iV});

  JoinPublicGroupDataModel.fromJson(Map<String, dynamic> json) {
    groupType = json['group_type'];
    createdBy = json['created_by'];
    groupName = json['group_name'];
    token = json['token'];
    isDeleted = json['is_deleted'];
    isDefault = json['is_default'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    sId = json['_id'];
    if (json['group_members'] != null) {
      groupMembers = <GroupMembers>[];
      json['group_members'].forEach((v) {
        groupMembers!.add(new GroupMembers.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_type'] = this.groupType;
    data['created_by'] = this.createdBy;
    data['group_name'] = this.groupName;
    data['token'] = this.token;
    data['is_deleted'] = this.isDeleted;
    data['is_default'] = this.isDefault;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['_id'] = this.sId;
    if (this.groupMembers != null) {
      data['group_members'] =
          this.groupMembers!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class GroupMembers {
  var memberId;
  var role;
  var isBlocked;
  var sId;

  GroupMembers({this.memberId, this.role, this.isBlocked, this.sId});

  GroupMembers.fromJson(Map<String, dynamic> json) {
    memberId = json['member_id'];
    role = json['role'];
    isBlocked = json['is_blocked'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['member_id'] = this.memberId;
    data['role'] = this.role;
    data['is_blocked'] = this.isBlocked;
    data['_id'] = this.sId;
    return data;
  }
}
