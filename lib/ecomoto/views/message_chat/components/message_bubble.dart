part of '../message_chat.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final String receiverId;
  final Color backgroundColor;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.receiverId,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isReceived = receiverId == message.senderId;
    final textColor = isReceived ? Colors.white : Colors.black;

    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment:
            isReceived ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(
            message.text,
            style: TextStyle(color: textColor),
          ),
          const SizedBox(height: 2.0),
          Text(
            formatTimestamp(message.timestamp),
            style: const TextStyle(color: Colors.white, fontSize: 10.0),
          ),
        ],
      ),
    );
  }

  String formatTimestamp(DateTime timestamp) {
    return '${timestamp.hour}:${timestamp.minute < 10 ? '0' : ''}${timestamp.minute} ${timestamp.hour >= 12 ? 'PM' : 'AM'}';
  }
}
