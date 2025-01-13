class ChatMessage {
  DateTime createdAt;
  String text, senderName, senderUid;

  ChatMessage({
    required this.createdAt,
    required this.text,
    required this.senderName,
    required this.senderUid,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> data) {
    return ChatMessage(
      text: data['text'] ?? '',
      senderUid: data['senderUid'] ?? '',
      senderName: data['senderName'] ?? '',
      createdAt: DateTime.parse(data['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'createdAt': createdAt,
      'senderUid': senderUid,
      'senderName': senderName,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ChatMessage &&
              runtimeType == other.runtimeType &&
              senderUid == other.senderUid &&
              createdAt == other.createdAt;

  @override
  int get hashCode => senderUid.hashCode ^ createdAt.millisecondsSinceEpoch;

  int get time => createdAt.millisecondsSinceEpoch;
}