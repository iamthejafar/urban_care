import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:skin_care/src/comman/validators/text_validation.dart';
import 'package:skin_care/src/features/skincare/data/data_source/mapper/streak_mapper.dart';
import 'package:skin_care/src/features/skincare/data/model/streak_model.dart';
import 'package:skin_care/src/features/skincare/domain/entity/streak.dart';

abstract interface class StreakRemoteDataSource {
  Future<List<StreakModel>> getStreaks({required String uid});
  Future<StreakModel> getStreak({required String uid, required String date});
  Future<String> addStreak({required String uid, required Streak streak});
  Future<void> updateStreak({
    required String uid,
    required String date,
    required Streak streak,
  });
  Future<List<String>> uploadPhotos({required List<File> images});
}

class StreakRemoteDataSourceImpl implements StreakRemoteDataSource {
  final CollectionReference _streaksCollection =
  FirebaseFirestore.instance.collection('Streaks');

  @override
  Future<List<StreakModel>> getStreaks({required String uid}) async {
    try {
      QuerySnapshot querySnapshot = await _streaksCollection
          .doc(uid)
          .collection('userStreaks')
          .get();

      List<StreakModel> streaks = querySnapshot.docs.map((doc) {
        return StreakModel.fromSnapshot(doc);
      }).toList();

      streaks.sort((b, a) => b.date.compareTo(a.date));
      return streaks;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<StreakModel> getStreak({required String uid, required String date}) async {
    try {
      DocumentSnapshot docSnapshot = await _streaksCollection
          .doc(uid)
          .collection('userStreaks')
          .doc(date)
          .get();

      if (docSnapshot.exists) {
        return StreakModel.fromSnapshot(docSnapshot);
      } else {
        return Future.error("Streak not found.");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<String> addStreak({required String uid, required Streak streak}) async {
    try {
      StreakModel streakModel = StreakMapper.fromEntity(streak);
      final dateString = DateTime.now().toDdmmyyyy();
      await _streaksCollection
          .doc(uid)
          .collection('userStreaks')
          .doc(dateString)
          .set(streakModel.toJson());
      return "Success";
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> updateStreak({
    required String uid,
    required String date,
    required Streak streak,
  }) async {
    try {
      DocumentReference docRef = _streaksCollection
          .doc(uid)
          .collection('userStreaks')
          .doc(date);

      await docRef.update(StreakMapper.fromEntity(streak).toJson());
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<String>> uploadPhotos({required List<File> images}) async {
    List<String> downloadUrls = [];
    FirebaseStorage storage = FirebaseStorage.instance;

    try {
      for (var imageFile in images) {
        String fileName = "${DateTime.now().millisecondsSinceEpoch}_${imageFile.uri.pathSegments.last}";
        Reference storageRef = storage.ref().child('images/$fileName');
        UploadTask uploadTask = storageRef.putFile(imageFile);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('Error uploading images: ${e.message}');
      }
    }

    return downloadUrls;
  }
}
