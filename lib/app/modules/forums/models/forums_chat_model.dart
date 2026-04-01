enum ChatMessageType { sent, received }

class ForumsChat {
  String message;
  final String messageType;
  final String mediaUrl;
  final ChatMessageType type;
  final DateTime time;
  final String sId;
  var sentBy;

  ForumsChat(
      {required this.message,
      required this.messageType,
      required this.type,
      required this.time,
      required this.sId,
      required this.sentBy,
      required this.mediaUrl});

  factory ForumsChat.sent(
          {required message,
          required messageType,
          messageTime,
          required sentBy,
          required mediaUrl,
          required sId}) =>
      ForumsChat(
          sId: sId,
          message: message ?? "",
          messageType: messageType ?? "",
          mediaUrl: mediaUrl ?? "",
          type: ChatMessageType.sent,
          time: messageTime ?? DateTime.now(),
          sentBy: sentBy);

  factory ForumsChat.received(
          {required message,
          required messageType,
          messageTime,
          required sentBy,
          required mediaUrl,
          required sId}) =>
      ForumsChat(
          sId: sId,
          message: message ?? "",
          messageType: messageType ?? "",
          mediaUrl: mediaUrl ?? "",
          type: ChatMessageType.received,
          time: messageTime ?? DateTime.now(),
          sentBy: sentBy);

  static List<ForumsChat> generate() {
    return [];
  }
}
