class ExitDeleteGroupDataModel {
  var sId;
  var groupName;
  var groupType;
  var updatedAt;
  var unreadMessages;

  ExitDeleteGroupDataModel(
      {this.sId,
      this.groupName,
      this.groupType,
      this.updatedAt,
      this.unreadMessages});

  ExitDeleteGroupDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    groupName = json['group_name'];
    groupType = json['group_type'];
    updatedAt = json['updated_at'];
    unreadMessages = json['unread_messages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['group_name'] = this.groupName;
    data['group_type'] = this.groupType;
    data['updated_at'] = this.updatedAt;
    data['unread_messages'] = this.unreadMessages;
    return data;
  }
}
