class AddAddressData {
  Location? location;
  String? name;
  String? userId;
  String? countryCode;
  int? phoneNo;
  String? company;
  String? country;
  String? state;
  String? city;
  String? pinCode;
  String? apartmentNumber;
  String? fullAddress;
  String? shippoUserAddressId;
  String? addressType;
  String? lat;
  String? lng;
  String? language;
  bool? isDefault;
  bool? isDeleted;
  String? createdAt;
  String? sId;
  int? iV;

  AddAddressData(
      {this.location,
        this.name,
        this.userId,
        this.countryCode,
        this.phoneNo,
        this.company,
        this.country,
        this.state,
        this.city,
        this.pinCode,
        this.apartmentNumber,
        this.fullAddress,
        this.shippoUserAddressId,
        this.addressType,
        this.lat,
        this.lng,
        this.language,
        this.isDefault,
        this.isDeleted,
        this.createdAt,
        this.sId,
        this.iV});

  AddAddressData.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    name = json['name'];
    userId = json['user_id'];
    countryCode = json['country_code'];
    phoneNo = json['phone_no'];
    company = json['company'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    pinCode = json['pin_code'];
    apartmentNumber = json['apartment_number'];
    fullAddress = json['full_address'];
    shippoUserAddressId = json['shippo_user_address_id'];
    addressType = json['address_type'];
    lat = json['lat'];
    lng = json['lng'];
    language = json['language'];
    isDefault = json['is_default'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['country_code'] = this.countryCode;
    data['phone_no'] = this.phoneNo;
    data['company'] = this.company;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['pin_code'] = this.pinCode;
    data['apartment_number'] = this.apartmentNumber;
    data['full_address'] = this.fullAddress;
    data['shippo_user_address_id'] = this.shippoUserAddressId;
    data['address_type'] = this.addressType;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['language'] = this.language;
    data['is_default'] = this.isDefault;
    data['is_deleted'] = this.isDeleted;
    data['created_at'] = this.createdAt;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}