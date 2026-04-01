class RemoveFromWishlistData {
  Message? message;

  RemoveFromWishlistData({this.message});

  RemoveFromWishlistData.fromJson(Map<String, dynamic> json) {
    message =
    json['message'] != null ? Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (message != null) {
      data['message'] = message!.toJson();
    }
    return data;
  }
}

class Message {
  String? title;
  String? desc;

  Message({this.title, this.desc});

  Message.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['desc'] = desc;
    return data;
  }
}