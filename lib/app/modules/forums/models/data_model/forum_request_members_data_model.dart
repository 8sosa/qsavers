class ForumRequestMembersDataModel {
  SentBy? sentBy;
  var sentTo;
  var groupId;
  var status;
  var message;
  var updatedAt;
  var createdAt;
  var sId;

  ForumRequestMembersDataModel(
      {this.sentBy,
      this.sentTo,
      this.groupId,
      this.status,
      this.message,
      this.updatedAt,
      this.createdAt,
      this.sId});

  ForumRequestMembersDataModel.fromJson(Map<String, dynamic> json) {
    sentBy =
        json['sent_by'] != null ? new SentBy.fromJson(json['sent_by']) : null;
    sentTo = json['sent_to'];
    groupId = json['group_id'];
    status = json['status'];
    message = json['message'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sentBy != null) {
      data['sent_by'] = this.sentBy!.toJson();
    }
    data['sent_to'] = this.sentTo;
    data['group_id'] = this.groupId;
    data['status'] = this.status;
    data['message'] = this.message;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['_id'] = this.sId;
    return data;
  }
}

class SentBy {
  var profilePic;
  var name;
  var sId;

  SentBy({this.profilePic, this.name, this.sId});

  SentBy.fromJson(Map<String, dynamic> json) {
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
