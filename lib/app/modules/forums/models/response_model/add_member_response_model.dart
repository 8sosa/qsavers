class AddMemberResponseModel {
  List<Data>? data;

  AddMemberResponseModel({this.data});

  AddMemberResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Data {
  String? profilePic;
  String? name;
  String? email;
  String? sId;
  var isSelected = false;

  Data({this.profilePic, this.name, this.email, this.sId,this.isSelected=false});

  Data.fromJson(Map<String, dynamic> json) {
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