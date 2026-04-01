class DeliveryCheckResponseModel {
  Data? data;

  DeliveryCheckResponseModel({this.data});

  DeliveryCheckResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? deliveryTime;
  bool? isDeliveryAvailable;

  Data({this.deliveryTime, this.isDeliveryAvailable});

  Data.fromJson(Map<String, dynamic> json) {
    deliveryTime = json['delivery_time'];
    isDeliveryAvailable = json['is_delivery_available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['delivery_time'] = this.deliveryTime;
    data['is_delivery_available'] = this.isDeliveryAvailable;
    return data;
  }
}