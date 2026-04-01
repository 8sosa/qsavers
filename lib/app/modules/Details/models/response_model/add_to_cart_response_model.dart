import 'package:quantity_savers/app/modules/Details/models/data_models/add_to_cart_data_model.dart';

class AddToCartResponseModel {
  bool? success;
  Message? message;
  AddToCartData? data;

  AddToCartResponseModel({this.success, this.message, this.data});

  AddToCartResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
    json['message'] != null ? new Message.fromJson(json['message']) : null;
    data = json['data'] != null ? new AddToCartData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Message {
  String? title;
  String? desc;

  Message({this.title, this.desc});

  Message.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['desc'] = this.desc;
    return data;
  }
}