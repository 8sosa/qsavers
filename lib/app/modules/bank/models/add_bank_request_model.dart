import 'package:quantity_savers/app/core/values/app_strings.dart';

class BankRequestModel {
  /*================================================== Add Bank Request Model==============================================*/
  static addBankRequestModel({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? address,
    String? city,
    String? state,
    String? postalCode,
    String? country,
    String? currency,
    String? accountHolderName,
    String? ssnLastFour,
    String? routingNumber,
    String? accountNumber,
    String? mcc,
    int? day,
    int? month,
    int? year,
    String? taxId,
    String? frontImage,
    String? backImage,
    String? language,
    String?countryId
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (firstName != null && firstName != "") {
      data["first_name"] = firstName;
    }
    if (lastName != null && lastName != "") {
      data["last_name"] = lastName;
    }
    if (email != null && email != "") {
      data["email"] = email;
    }
    if (phoneNumber != null && phoneNumber != "") {
      data["phone_number"] = phoneNumber;
    }
    if (address != null && address != "") {
      data["address"] = address;
    }
    if (city != null && city != "") {
      data["city"] = city;
    }
    if (postalCode != null && postalCode != "") {
      data["postal_code"] = postalCode;
    }

    data["country"] = country;
    data["currency"] = currency;
    data["account_holder_name"] = accountHolderName;
    if (ssnLastFour != null && ssnLastFour != "") {
      data["ssn_last_4"] = ssnLastFour;
    }
    if (routingNumber != null && routingNumber != "") {
      data["routing_number"] = routingNumber;
    }
    data["account_number"] = accountNumber;
    if (mcc != null && mcc != "") {
      data["mcc"] = mcc;
    }
    if (day != null && day != 0) {
      data["day"] = day;
    }
    if (month != null && month != 0) {
      data["month"] = month;
    }
    if (year != null && year != 0) {
      data["year"] = year;
    }
    if (taxId != null && taxId != "") {
      data["tax_id"] = taxId;
    }
    if (backImage != null && backImage != "") {
      data["back_image"] = backImage;
    }
    if (frontImage != null && frontImage != "") {
      data["front_image"] = frontImage;
    }
    if(countryId!=null && countryId!="")
    {
      data["country_id"]=countryId;
    }

    data["language"] = strLanguageEnglish;
    return data;
  }

  static addFlwPayPalContactAdminBankRequestModel({
    String? accountHolderName,
    String? accountNumber,
    String? ssn,
    String? accountDetail,
    String? type,
    String? payPalEmail,
    String? country,
    String?countryId
})
  {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(accountHolderName!=null && accountHolderName!="")
      {
        data["account_holder_name"]=accountHolderName;
      }
    if(accountNumber!=null && accountNumber!="")
      {
        data["account_number"]=accountNumber;
      }
    if(ssn!=null && ssn!="")
      {
        data["ssn"]=ssn;
      }
    if(accountDetail!=null && accountDetail!="")
      {
        data["account_detail"]=accountDetail;
      }
    if(type!=null && type!="")
      {
        data["type"]= type;
      }
    if(payPalEmail!=null && payPalEmail!="")
      {
        data["paypal_email"]=payPalEmail;
      }
    if(country!=null && country!="")
      {
        data["country"]=country;
      }
    if(countryId!=null && countryId!="")
    {
      data["country_id"]=countryId;
    }
    return data;
  }
}
