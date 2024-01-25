import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signup(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
              password.isNotEmpty ||
              username.isNotEmpty ||
              bio.isNotEmpty
          // ||
          // file != null
          ) {
        //register user
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential.user!.uid);

        String photoURL = await FirebaseStorageMethods()
            .uploadImagetoFirebaseStorage('usersProfilePictures', file, false);

        //add user to our database
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': username,
          'uid': userCredential.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoURL': photoURL
        });

        // await _firestore.collection('users').add({
        //   'username': username,
        //   'uid': userCredential.user!.uid,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        // });

        res = "success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        res = "The email is badly formatted";
      } else if (e.code == 'weak-password') {
        res = "Password should be at least 6 characters";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //logging in user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
