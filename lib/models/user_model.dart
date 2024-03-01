// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String uid;
  final String email;
  final String bio;
  final String photoURL;
  final List followers;
  final List following;

  const User(
      {required this.email,
      required this.username,
      required this.uid,
      required this.bio,
      required this.photoURL,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "bio": bio,
        "photoURL": photoURL,
        "followers": followers,
        "following": following
      };

  static User fromSnapshot(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      bio: snapshot["bio"],
      photoURL: snapshot["photoURL"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }
}
