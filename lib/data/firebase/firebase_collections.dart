import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCollections {
  static const String messages = 'messages/';
  static const String users = 'users';

  //Might be redundant
  static CollectionReference getCollection(String collectionName) {
    return FirebaseFirestore.instance.collection(collectionName);
  }
}
