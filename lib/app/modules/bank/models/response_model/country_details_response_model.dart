class CountryDetailResponseModel {
  DataContainer? data;

  CountryDetailResponseModel({this.data});

  CountryDetailResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? DataContainer.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataContainer {
  Data? data;

  DataContainer({this.data});

  DataContainer.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}


class Data {
  String? sId;
  bool? paypal;
  bool? flutterwave;
  bool? stripe;
  bool? contactAdmin;
  String? country;
  String? currency;
  String? countryCode;
  var imageUrl;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.sId,
        this.paypal,
        this.flutterwave,
        this.stripe,
        this.contactAdmin,
        this.country,
        this.currency,
        this.countryCode,
        this.imageUrl,
        this.updatedAt,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    paypal = json['paypal'];
    flutterwave = json['flutterwave'];
    stripe = json['stripe'];
    contactAdmin = json['contact_admin'];
    country = json['country'];
    currency = json['currency'];
    countryCode = json['country_code'];
    imageUrl = json['image_url'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['paypal'] = this.paypal;
    data['flutterwave'] = this.flutterwave;
    data['stripe'] = this.stripe;
    data['contact_admin'] = this.contactAdmin;
    data['country'] = this.country;
    data['currency'] = this.currency;
    data['country_code'] = this.countryCode;
    data['image_url'] = this.imageUrl;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
