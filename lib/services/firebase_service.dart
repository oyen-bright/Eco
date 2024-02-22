import 'dart:developer';

import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/data/firebase/firebase_client.dart';
import 'package:emr_005/data/firebase/firebase_collections.dart';
import 'package:emr_005/ecomoto/cubit/messaging_cubit/messages_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  void anonymousSignIn() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      log(e.toString(), name: "FirebaseService Error");
      //TODO: handle failed signIn appropriately
      rethrow;
    }
  }

  Future<String?> uploadImage() async {
    try {
      String? imageUrl = await FirebaseClient.uploadImage();
      if (imageUrl != null) {
        return imageUrl;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<String?> writeToMessageCollection(
      Message message, String tripID) async {
    final Map<String, dynamic> data = {
      'senderID': message.senderId,
      'receiverID': message.receiverId,
      'text': message.text,
      'imageUrl': message.imageUrl,
      'timestamp': message.timestamp,
    };
    try {
      await FirebaseClient.writeToCollection(
          FirestoreCollections.messages, tripID,
          data: data);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Stream<List<Message>> getMessages(
      String userId, String tripID, UserCubit user) {
    return FirebaseClient.getCollectionStream(
            FirestoreCollections.messages, tripID)
        .map(((List<Map<String, dynamic>> data) {
      var allMessages = data.map((doc) => Message.fromJson(doc)).toList();

      allMessages.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      return allMessages;
    }));
  }
}
