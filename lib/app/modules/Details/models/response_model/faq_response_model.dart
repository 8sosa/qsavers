class FAQResponseModel {
  bool? success;
  String? message;
  Data? data;

  FAQResponseModel({this.success, this.message, this.data});

  FAQResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? faqId;
  String? userId;
  String? type;
  String? updatedAt;
  String? createdAt;
  String? sId;
  int? iV;

  Data(
      {this.faqId,
        this.userId,
        this.type,
        this.updatedAt,
        this.createdAt,
        this.sId,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    faqId = json['faq_id'];
    userId = json['user_id'];
    type = json['type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['faq_id'] = this.faqId;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}