import 'package:quantity_savers/app/modules/payment/models/data_models/cardlist_data_model.dart';

class CardsListResponseModel {
  bool? success;
  String? message;
  CardListData? data;

  CardsListResponseModel({this.success, this.message, this.data});

  CardsListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new CardListData.fromJson(json['data']) : null;
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