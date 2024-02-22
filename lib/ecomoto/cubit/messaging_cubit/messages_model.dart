class Message {
  final String receiverId;
  final String senderId;
  final String text;
  final String? imageUrl;
  final DateTime timestamp;

  Message({required this.receiverId, required this.senderId, required this.text, this.imageUrl, required this.timestamp});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      receiverId: json['receiverID'] ?? '',
      senderId: json['senderID'] ?? '',
      text: json['text'] ?? '',
      imageUrl: json['imageUrl'],
      timestamp: json['timestamp'].toDate() ?? DateTime.now(),
    );
  }

 
}