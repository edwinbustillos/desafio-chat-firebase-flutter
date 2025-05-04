class Message {
  final String id;
  final String senderId;
  final String text;
  final String senderName;
  final DateTime sentAt;

  Message({
    required this.id,
    required this.senderId,
    required this.text,
    required this.senderName,
    required this.sentAt,
  });

  factory Message.fromMap(Map<String, dynamic> data, String id) {
    return Message(
      id: id,
      senderId: data['senderId'] ?? '',
      text: data['text'] ?? '',
      senderName: data['senderName'] ?? '',
      sentAt: data['sentAt']?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'senderId': senderId,
      'senderName': senderName,
      'sentAt': sentAt,
    };
  }
}
