import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:skin_care/src/features/skincare/domain/entity/streak.dart';

import '../../domain/repo/skincare_repo.dart';
import '../data_source/remote/skincare_remote_data_source.dart';
import '../model/streak_model.dart';


class SkinCareRepoImpl implements SkincareRepo {
  final StreakRemoteDataSource _remoteDataSource;

  SkinCareRepoImpl(this._remoteDataSource);

  @override
  Future<List<StreakModel>> getStreaks({required String uid}) async {
    try {
      final streaks = await _remoteDataSource.getStreaks(uid: uid);
      if (kDebugMode) print(streaks);
      return streaks;
    } catch (e) {
      if (kDebugMode) print(e);
      return Future.error(e.toString());
    }
  }

  @override
  Future<StreakModel> getStreak({required String uid, required String date}) async {
    try {
      final streak = await _remoteDataSource.getStreak(uid: uid, date: date);
      if (kDebugMode) print(streak);
      return streak;
    } catch (e) {
      if (kDebugMode) print(e);
      return Future.error(e.toString());
    }
  }

  @override
  Future<String> addStreak({required String uid, required Streak streak}) async {
    try {
      final streakId = await _remoteDataSource.addStreak(uid: uid, streak: streak);
      if (kDebugMode) print(streakId);
      return streakId;
    } catch (e) {
      if (kDebugMode) print(e);
      return Future.error(e.toString());
    }
  }

  @override
  Future<void> updateStreak({
    required String uid,
    required String date,
    required Streak streak,
  }) async {
    try {
      await _remoteDataSource.updateStreak(uid: uid, date: date, streak: streak);
      if (kDebugMode) print('Streak updated');
    } catch (e) {
      if (kDebugMode) print(e);
      return Future.error(e.toString());
    }
  }

  @override
  Future<List<String>> uploadPhotos({required List<File> images}) async {
    try{
      final res = await _remoteDataSource.uploadPhotos(images: images);
      if(kDebugMode) print("Upload success");
      return res;
    } catch (e) {
      if(kDebugMode) print(e);
      return Future.error(e.toString());
    }
  }
}
