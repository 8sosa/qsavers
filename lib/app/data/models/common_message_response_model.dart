class CommonMessageResponseModel {
  CommonMessageData? data;

  CommonMessageResponseModel({this.data});

  CommonMessageResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CommonMessageData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CommonMessageData {
  String? message;

  CommonMessageData({this.message});

  CommonMessageData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
