class SearchGroupDataModel {
  var sId;
  var groupType;
  var groupName;

  SearchGroupDataModel({this.sId, this.groupType, this.groupName});

  SearchGroupDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    groupType = json['group_type'];
    groupName = json['group_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['group_type'] = this.groupType;
    data['group_name'] = this.groupName;
    return data;
  }
}
