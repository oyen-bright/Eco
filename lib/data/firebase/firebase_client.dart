import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseClient {
//TODO:implement using a path method to read and write to fireStore
// static Future<void> writeToCollection({
//     required String path,
//     Map<String, dynamic>? data,
//   }) async {
//     try {
//       final List<String> segments =
//           path.split('/').where((element) => element.isNotEmpty).toList();

//       if (segments.isEmpty) {
//         throw ArgumentError('Invalid path provided');
//       }

//       final CollectionReference collectionReference =
//           FirebaseFirestore.instance.collection("collection name");

//       DocumentReference documentReference =
//           collectionReference.doc(segments.removeAt(0));

//       for (final segment in segments) {
//         documentReference = documentReference.collection(segment).doc();
//       }

//       if (data != null) {
//         await documentReference.set(data);
//       }
//     } catch (e) {
//   log(e.toString(), name: "FirebaseClient Write Error");
//       rethrow;
//     }
//   }

  static Future<void> writeToCollection(
    String collectionName,
    String documentId, {
    required Map<String, dynamic> data,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(documentId)
          .collection(collectionName)
          .add(data);
    } catch (e) {
      log(e.toString(), name: "FirebaseClient Write Error");
      rethrow;
    }
  }

  static Stream<List<Map<String, dynamic>>> getCollectionStream(
      String collectionName, String documentId) {
    var query = FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentId)
        .collection(collectionName)
        .snapshots();

    return query.map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  static Future<String?> uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return null;

    File imageFile = File(pickedFile.path);

    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      log('Error uploading image: ${e.toString()}');
      return null;
    }
  }

  static Future<Map<String, dynamic>> readDocument(String documentId) async {
    // TODO: Implement read document logic if required
    throw UnimplementedError();
  }

  static Future<List<Map<String, dynamic>>> readCollection() async {
    // TODO: Implement read collection logic if required

    throw UnimplementedError();
  }

  static Future<void> updateDocument(
      String documentId, Map<String, dynamic> data) async {
    // TODO: Implement update document logic if required

    throw UnimplementedError();
  }

  static Future<void> deleteDocument(String documentId) async {
    // TODO: Implement delete document logic if required

    throw UnimplementedError();
  }
}
