import "../../../export.dart";

class AddressesRequestModel {
  /*=================================================== Product Details Request Model==============================================*/

  static addAddressRequestModel({
    String? id,
    String? language,
    String? name,
    String? countryCode,
    String? phoneNo,
    String? company,
    String? country,
    String? state,
    String? city,
    String? pinCode,
    String? apartmentNumber,
    String? fullAddress,
    String? addressType,
    String? lng,
    String? lat,
    
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if ((id != null) && (id != "")) {
      data["_id"] = id;
    }
    data["language"] = strLanguageEnglish;
    data["name"] = name;
    data["country_code"] = countryCode;
    data["phone_no"] = phoneNo;
    if ((company != null) && (company != "")){
      data["company"] = company;
    }
    data["country"] = country;
    data["state"] = state;
    data["city"] = city;
    data["pin_code"] = pinCode;
    if ((apartmentNumber != null) && (apartmentNumber != "")){
      data["apartment_number"] = apartmentNumber;
    }
    data["full_address"] = fullAddress;
    data["address_type"] = addressType;
    data["lng"] = lng;
    data["lat"] = lat;
    return data;
  }

 static deleteAddressRequestModel({
     String?id})
  {
  final Map<String, dynamic> data = <String, dynamic>{};
  data["_id"]=id;
  return data;
 }

}