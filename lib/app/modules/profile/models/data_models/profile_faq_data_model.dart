class ProfileFaqDataModel {
  var totalCount;
  List<ProfileFaqSubDataModel>? data;

  ProfileFaqDataModel({this.totalCount, this.data});

  ProfileFaqDataModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <ProfileFaqSubDataModel>[];
      json['data'].forEach((v) {
        data!.add(new ProfileFaqSubDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileFaqSubDataModel {
  var sId;
  var question;
  var answer;
  var isDeleted;
  var language;
  var createdAt;

  ProfileFaqSubDataModel(
      {this.sId,
      this.question,
      this.answer,
      this.isDeleted,
      this.language,
      this.createdAt});

  ProfileFaqSubDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    question = json['question'];
    answer = json['answer'];
    isDeleted = json['is_deleted'];
    language = json['language'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['is_deleted'] = this.isDeleted;
    data['language'] = this.language;
    data['created_at'] = this.createdAt;
    return data;
  }
}
