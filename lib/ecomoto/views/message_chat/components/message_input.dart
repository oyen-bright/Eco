part of '../message_chat.dart';

class MessageInputWidget extends StatefulWidget {
  final String senderId;
  final String receiverId;
  final String tripId;

  const MessageInputWidget({
    Key? key,
    required this.senderId,
    required this.receiverId,
    required this.tripId,
  }) : super(key: key);

  @override
  MessageInputWidgetState createState() => MessageInputWidgetState();
}

class MessageInputWidgetState extends State<MessageInputWidget> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: _buildTextField(),
          ),
          const SizedBox(width: 8.0),
          _buildSendButton(),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: _textController,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: const Icon(Icons.camera_alt_outlined),
          onPressed: _onCameraPressed,
        ),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        hintText: Strings.chatInputHint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none,
        ),
      ),
      maxLines: null,
      textInputAction: TextInputAction.newline,
    );
  }

  Widget _buildSendButton() {
    return IconButton(
      icon: const Icon(Icons.send_rounded),
      onPressed: _onSendPressed,
    );
  }

  void _onCameraPressed() async {
    var imageUrl = await context.read<MessagesCubit>().uploadImage();
    if (imageUrl != null) {
      var message = Message(
        receiverId: widget.receiverId,
        senderId: widget.senderId,
        text: '',
        imageUrl: imageUrl,
        timestamp: DateTime.now().toUtc(),
      );
      if (mounted) {
        context.read<MessagesCubit>().sendMessage(message, widget.tripId);
      }
    }
  }

  void _onSendPressed() async {
    var message = Message(
      receiverId: widget.receiverId,
      senderId: widget.senderId,
      text: _textController.text.trim(),
      timestamp: DateTime.now().toUtc(),
    );
    if (_textController.text.isNotEmpty) {
      await context.read<MessagesCubit>().sendMessage(message, widget.tripId);
    }
    _textController.clear();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
