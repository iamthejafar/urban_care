import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:skin_care/src/features/auth/data/models/user_model.dart';
import 'package:skin_care/src/utils/user_preferences.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserCredential> login(
      {required String email, required String password});

  Future<UserCredential> signUp(
      {required String email, required String password, required String name});

  Future<UserModel> getUser({required String uid});

  Future<String> updateUser(
      {required String uid, required UserModel updatedUser});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  FirebaseAuth firebaseAuth;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('Users');
  AuthRemoteDataSourceImpl(this.firebaseAuth);

  @override
  Future<UserCredential> login(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      return Future.error(e.message ?? "an unexpected  error occurred");
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<UserCredential> signUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel userModel = UserModel(
          uid: userCredential.user!.uid,
          name: name,
          email: email,
          profilePicUrl: "",
          currentStreak: 0,
          longestStreak: 0);

      await _usersCollection.doc(userModel.uid).set(userModel.toJson());
      return userCredential;
    } on FirebaseAuthException catch (e) {
      return Future.error(e.message ?? "an unexpected  error occurred");
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<UserModel> getUser({required String uid}) async {
    try {
      final userDoc = await _usersCollection.doc(uid).get();
      if (userDoc.exists) {
        UserModel userModel = UserModel.fromSnapshot(userDoc);
        UserPreferences.setUser(
            userId: uid,
            userName: userModel.name,
            email: userModel.email,
            profilePic: userModel.profilePicUrl,
            longestStreak: userModel.longestStreak,
            currentStreak: userModel.currentStreak);
        return userModel;
      } else {
        return Future.error("User not found");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<String> updateUser(
      {required String uid, required UserModel updatedUser}) async {
    try {
      print(updatedUser.toJson().toString());
      await _usersCollection.doc(uid).update(updatedUser.toJson());
      print("Suucess");
      return "Success";
    } catch (e) {
      if (kDebugMode) print(e);
      return Future.error(e.toString());
    }
  }
}
