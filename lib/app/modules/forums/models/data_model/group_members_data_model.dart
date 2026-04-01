class GroupMembersDataModel {
  var profilePic;
  var name;
  var email;
  var sId;
  var isSelected = false;

  GroupMembersDataModel({this.profilePic, this.name, this.email, this.sId,this.isSelected=false});

  GroupMembersDataModel.fromJson(Map<String, dynamic> json) {
    profilePic = json['profile_pic'];
    name = json['name'];
    email = json['email'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_pic'] = this.profilePic;
    data['name'] = this.name;
    data['email'] = this.email;
    data['_id'] = this.sId;
    return data;
  }
}
