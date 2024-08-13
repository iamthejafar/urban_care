

import 'dart:io';

import 'package:skin_care/src/features/skincare/domain/entity/streak.dart';

abstract class SkincareRepo {
  Future<List<Streak>> getStreaks({required String uid});
  Future<Streak> getStreak({required String uid, required String date});
  Future<String> addStreak({required String uid,required Streak streak});
  Future<void> updateStreak({
    required String uid,
    required String date,
    required Streak streak,
  });

  Future<List<String>> uploadPhotos({required List<File> images});
}