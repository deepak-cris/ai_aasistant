class ChatModal {
  final String msg;
  final int chatInext;

  ChatModal({required this.msg, required this.chatInext});

  factory ChatModal.fromJson(Map<String, dynamic> json) {
    return ChatModal(msg: json['choices'][0]['text'], chatInext: 1);
  }

  static List<ChatModal> fromJsonSnapShot(List snapshot) {
    return snapshot.map((data) => ChatModal.fromJson(data)).toList();
  }
}
