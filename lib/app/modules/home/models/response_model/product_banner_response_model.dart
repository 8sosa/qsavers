import 'package:quantity_savers/app/modules/home/models/data_model/product_banner_data_model.dart';

class ProductBannerResponseModel {
  ProductBannerDataModel? data;

  ProductBannerResponseModel({this.data});

  ProductBannerResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? ProductBannerDataModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
