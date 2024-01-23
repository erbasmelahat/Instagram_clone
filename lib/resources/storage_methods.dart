import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageMethods {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //adding image to firebase storage
  Future<String> uploadImagetoFirebaseStorage(
      String childName, Uint8List file, bool isPost) async {
    Reference ref =
        _firebaseStorage.ref().child(childName).child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }
}
