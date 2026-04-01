class CreateGroupDataModel {
  String? message;
  String? groupId;

  CreateGroupDataModel({this.message, this.groupId});

  CreateGroupDataModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    groupId = json['group_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['group_id'] = this.groupId;
    return data;
  }
}
