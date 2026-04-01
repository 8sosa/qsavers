
class CartData {
  var totalCount;
  List<CartSubData>? data;

  CartData({this.totalCount, this.data});

  CartData.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <CartSubData>[];
      json['data'].forEach((v) {
        data!.add(new CartSubData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartSubData {
  var sId;
  var userId;
  ProductId? productId;
  var quantity;
  var updatedAt;
  var createdAt;
  var availableQuantity;
  List<ProductHighlights>? productHighlights;
  List<ProductServices>? productServices;
  bool? wishlist;

  CartSubData(
      {this.sId,
        this.userId,
        this.productId,
        this.quantity,
        this.updatedAt,
        this.createdAt,
        this.availableQuantity,
        this.productHighlights,
        this.productServices,
        this.wishlist});

  CartSubData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    productId = json['product_id'] != null
        ? new ProductId.fromJson(json['product_id'])
        : null;
    quantity = json['quantity'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    availableQuantity = json['available_quantity'];
    if (json['product_highlights'] != null) {
      productHighlights = <ProductHighlights>[];
      json['product_highlights'].forEach((v) {
        productHighlights!.add(new ProductHighlights.fromJson(v));
      });
    }
    if (json['product_services'] != null) {
      productServices = <ProductServices>[];
      json['product_services'].forEach((v) {
        productServices!.add(new ProductServices.fromJson(v));
      });
    }
    wishlist = json['wishlist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    if (this.productId != null) {
      data['product_id'] = this.productId!.toJson();
    }
    data['quantity'] = this.quantity;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['available_quantity'] = this.availableQuantity;
    if (this.productHighlights != null) {
      data['product_highlights'] =
          this.productHighlights!.map((v) => v.toJson()).toList();
    }
    if (this.productServices != null) {
      data['product_services'] =
          this.productServices!.map((v) => v.toJson()).toList();
    }
    data['wishlist'] = this.wishlist;
    return data;
  }
}

class ProductId {
  var sId;
  var name;
  AddedBy? addedBy;
  List<String>? images;
  var quantity;
  var price;
  var discountPercantage;
  var discount;
  var discountPrice;
  bool? isDeleted;

  ProductId(
      {this.sId,
        this.name,
        this.addedBy,
        this.images,
        this.quantity,
        this.price,
        this.discountPercantage,
        this.discount,
        this.discountPrice,
        this.isDeleted});

  ProductId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    addedBy = json['added_by'] != null
        ? new AddedBy.fromJson(json['added_by'])
        : null;
    images = json['images'].cast<String>();
    quantity = json['quantity'];
    price = json['price'];
    discountPercantage = json['discount_percantage'];
    discount = json['discount'];
    discountPrice = json['discount_price'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.addedBy != null) {
      data['added_by'] = this.addedBy!.toJson();
    }
    data['images'] = this.images;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['discount_percantage'] = this.discountPercantage;
    data['discount'] = this.discount;
    data['discount_price'] = this.discountPrice;
    data['is_deleted'] = this.isDeleted;
    return data;
  }
}

class AddedBy {
  var sId;
  var name;

  AddedBy({this.sId, this.name});

  AddedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class ProductHighlights {
  var content;

  ProductHighlights({this.content});

  ProductHighlights.fromJson(Map<String, dynamic> json) {
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    return data;
  }
}

class ProductServices {
  var content;

  ProductServices({this.content});

  ProductServices.fromJson(Map<String, dynamic> json) {
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    return data;
  }
}




class PriceDetailsData {
  var price;
  var discount;
  var totalPrice;

  PriceDetailsData({this.price, this.discount, this.totalPrice});

  PriceDetailsData.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    discount = json['discount'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['total_price'] = this.totalPrice;
    return data;
  }
}