class DealOfDayTimerResponseModel {
  var success;
  var message;
  Data? data;

  DealOfDayTimerResponseModel({this.success, this.message, this.data});

  DealOfDayTimerResponseModel.fromJson(Map<String, dynamic> json) {
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
  var validTill;
  var isActive;
  var updatedAt;
  var createdAt;
  var sId;

  Data(
      {this.validTill,
        this.isActive,
        this.updatedAt,
        this.createdAt,
        this.sId});

  Data.fromJson(Map<String, dynamic> json) {
    validTill = json['valid_till'];
    isActive = json['is_active'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['valid_till'] = this.validTill;
    data['is_active'] = this.isActive;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['_id'] = this.sId;
    return data;
  }
}
