import 'package:quantity_savers/app/modules/forums/models/data_model/chat_history_response_model.dart';

class ChatHistoryResponseModel {
  List<ChatHistoryDataModel>? data;

  ChatHistoryResponseModel({this.data});

  ChatHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ChatHistoryDataModel>[];
      json['data'].forEach((v) {
        data!.add(new ChatHistoryDataModel.fromJson(v));
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
