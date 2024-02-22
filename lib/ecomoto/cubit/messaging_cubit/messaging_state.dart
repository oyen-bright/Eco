import 'package:emr_005/ecomoto/cubit/messaging_cubit/messages_model.dart';

class MessagesState {
  final List<Message> messages;
  final bool isLoading;
  final String? error;

  MessagesState({
    required this.messages,
    required this.isLoading,
    this.error,
  });

  factory MessagesState.loading() {
    return MessagesState(messages: [], isLoading: true);
  }

  factory MessagesState.finishLoading(List<Message> messages) {
    return MessagesState(messages: messages, isLoading: false);
  }

  factory MessagesState.error(String error) {
    return MessagesState(messages: [], isLoading: false, error: error);
  }
}
