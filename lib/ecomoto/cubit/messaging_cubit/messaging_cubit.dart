import 'dart:async';

import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/ecomoto/cubit/messaging_cubit/messaging_state.dart';
import 'package:emr_005/services/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'messages_model.dart';

class MessagesCubit extends Cubit<MessagesState> {
  final FirebaseService firebaseService;
  final UserCubit userCubit;
  StreamSubscription<List<Message>>? _messagesSubscription;

  MessagesCubit(this.firebaseService, this.userCubit)
      : super(MessagesState(messages: [], isLoading: false));

  void loadMessages(String userId, String tripID) async {
    try {
      emit(MessagesState.loading());
      _messagesSubscription = streamMessages(userId, tripID).listen(
        (List<Message> messages) {
          emit(MessagesState.finishLoading(messages));
        },
        onError: (dynamic error) {
          emit(MessagesState.error('Error loading messages: $error'));
        },
      );
    } catch (e) {
      emit(MessagesState.error('Failed to load messages: $e'));
    }
  }

  Future<String?> sendMessage(Message message, String tripID) async {
    return await firebaseService.writeToMessageCollection(message, tripID);
  }

  Future<String?> uploadImage() async {
    String? imageUrl = await firebaseService.uploadImage();
    return imageUrl;
  }

  Stream<List<Message>> streamMessages(
    String userId,
    String tripID,
  ) {
    return firebaseService.getMessages(userId, tripID, userCubit);

    //TODO: relevant for ecobook message service
    /*var query = FirebaseFirestore.instance
        .collection('messages')
        .where('senderID', isEqualTo: userId)
        .snapshots();

    var query2 = FirebaseFirestore.instance
        .collection('messages')
        .where('receiverID', isEqualTo: userId)
        .snapshots();

    return Rx.combineLatest2(
      query,
      query2,
      (QuerySnapshot<Map<String, dynamic>> snapshot1,
          QuerySnapshot<Map<String, dynamic>> snapshot2) {
        var messages1 =
            snapshot1.docs.map((doc) => Message.fromJson(doc.data()!)).toList();
        var messages2 =
            snapshot2.docs.map((doc) => Message.fromJson(doc.data()!)).toList();

        var allMessages = [...messages1, ...messages2];

        allMessages.sort((a, b) => b.timestamp.compareTo(a.timestamp));

        return allMessages;
      },
    );*/
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
