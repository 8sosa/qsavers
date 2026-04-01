
import 'package:quantity_savers/app/core/values/app_strings.dart';


class PaymentsRequestsModel {
  static makePaymentRequestModel({
    required List<Map<String, dynamic>> products,
    int? limit,
    String? language,
    String? addressId,
    String? campaignId,
    String? cardId,
    String? couponCode,
    int?  totalQuantity,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (couponCode != null && couponCode != "") {
      data["coupon_code"] = couponCode;
    }
    data["products"] = products; // Corrected from addressId to productsData
    data["address_id"] = addressId;
    if (campaignId != null && campaignId != "") {
      data["campaign_id"] = campaignId;
    }
    if (totalQuantity != null && totalQuantity != 0) {
      data[ "total_quantity"] =  totalQuantity;
    }
    data["card_id"] = cardId;
    data["payment_mode"] = strByCard; // Placeholder, replace with appropriate value
    data["language"] = strLanguageEnglish.toUpperCase(); // Placeholder, replace with appropriate value
    return data;
  }

  static Map<String, dynamic> products({
    String? productId,
    String? shipmentId,
    int? quantity,
    var deliveryPrice,
    String? transactionsId,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shipmentId != null && shipmentId != "") {
      data["shipment_id"] = shipmentId;
    }
    if (transactionsId != null && transactionsId != "") {
      data["transaction_id"] = transactionsId;
    }
    data["product_id"] = productId;
    data["quantity"] = quantity;
    data["delivery_price"] = deliveryPrice; // Corrected from productId to deliveryPrice
    return data;
  }
}

