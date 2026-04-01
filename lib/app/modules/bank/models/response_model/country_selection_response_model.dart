class CountrySelectionResponseModel {
  Data? data;

  CountrySelectionResponseModel({this.data});

  CountrySelectionResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? count;
  List<CountryDataModel>? data;

  Data({this.count, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['data'] != null) {
      data = <CountryDataModel>[];
      json['data'].forEach((v) {
        data!.add(new CountryDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CountryDataModel {
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

  CountryDataModel(
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

  CountryDataModel.fromJson(Map<String, dynamic> json) {
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
