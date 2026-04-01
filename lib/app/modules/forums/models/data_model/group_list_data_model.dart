class GroupListDataModel {
  var sId;
  var groupName;
  var lastMessage;
  var groupType;
  var createdBy;
  var updatedAt;
  var unreadMessages;

  GroupListDataModel(
      {this.sId,
      this.groupName,
      this.groupType,
      this.createdBy,
      this.updatedAt,
      this.lastMessage,
      this.unreadMessages});

  GroupListDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    groupName = json['group_name'];
    groupType = json['group_type'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    lastMessage = json['last_message'];
    unreadMessages = json['unread_messages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['group_name'] = this.groupName;
    data['group_type'] = this.groupType;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['last_message'] = this.lastMessage;
    data['unread_messages'] = this.unreadMessages;
    return data;
  }
}
