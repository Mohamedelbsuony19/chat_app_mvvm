class Message {
  static const String collictionName = 'messagemodel';
  String id;
  String roomId;
  String content;
  int dateTime;
  String senderName;
  String senderId;
  Message(
      {this.id = '',
      required this.roomId,
      required this.content,
      required this.dateTime,
      required this.senderName,
      required this.senderId});

  Message.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          roomId: json['roomId'],
          content: json['content'],
          dateTime: json['dateTime'],
          senderName: json['senderName'],
          senderId: json['senderId'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'roomId': roomId,
      'content': content,
      'dateTime': dateTime,
      'senderName': senderName,
      'senderId': senderId,
    };
  }
}
