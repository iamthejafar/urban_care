import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_care/src/comman/dialogs/error_dialog.dart';
import 'package:skin_care/src/comman/dialogs/loading_dialog.dart';
import 'package:skin_care/src/comman/dialogs/success_dialog.dart';
import 'package:skin_care/src/features/auth/domain/entity/user.dart';
import 'package:skin_care/src/features/skincare/data/data_source/mapper/streak_mapper.dart';
import 'package:skin_care/src/features/skincare/data/model/streak_model.dart';
import 'package:skin_care/src/utils/dependency_injection.dart';
import 'package:skin_care/src/utils/user_preferences.dart';
import '../../../../comman/validators/text_validation.dart';
import '../../../../utils/constants.dart';
import '../../../auth/domain/usecase/update_user.dart';
import '../../domain/entity/streak.dart';
import '../../domain/usecase/add_streak.dart';
import '../../domain/usecase/get_streak.dart';
import '../../domain/usecase/update_streak.dart';
import '../../domain/usecase/upload_photos.dart';

final indexProvider = StateProvider<int>((ref) => 0);
final pageController = StateProvider((ref) => PageController());

enum AddSkincareStreakState { initial, loading, success, error }

final addSkincareStreakProvider = StateNotifierProvider<
    AddSkincareStreakStateNotifier, AddSkincareStreakState>(
  (ref) => AddSkincareStreakStateNotifier(
      addStreakUseCase: locator(),
      getStreakUseCase: locator(),
      updateStreakUseCase: locator(),
      uploadPhotosUseCase: locator(),
      updateUserUseCase: locator()),
);

class AddSkincareStreakStateNotifier
    extends StateNotifier<AddSkincareStreakState> {
  final AddStreakUseCase addStreakUseCase;
  final GetStreakUseCase getStreakUseCase;
  final UpdateStreakUseCase updateStreakUseCase;
  final UploadPhotosUseCase uploadPhotosUseCase;
  final UpdateUserUseCase updateUserUseCase;

  AddSkincareStreakStateNotifier(
      {required this.addStreakUseCase,
      required this.getStreakUseCase,
      required this.updateStreakUseCase,
      required this.uploadPhotosUseCase,
      required this.updateUserUseCase})
      : super(AddSkincareStreakState.initial);

  Future<void> addSkincareStreak({
    required BuildContext context,
    required String title,
    required List<File> images,
  }) async {
    showLoading(context);
    state = AddSkincareStreakState.loading;
    List<String> photos =
        await uploadPhotosUseCase.call(UploadPhotosParam(images: images));

    final responseMap = await _getStreak(DateTime.now());

    // if Streak is already present
    // Update Operation
    if (responseMap.containsKey(true)) {
      try {
        if (responseMap.entries.first.value != null) {
          await _updateStreak(title, UserPreferences.userId, photos,
              responseMap.entries.first.value!);
          if (context.mounted) {
            state = AddSkincareStreakState.success;
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        }
      } catch (e) {
        if (kDebugMode) print(e);
        if (context.mounted) {
          state = AddSkincareStreakState.error;
          Navigator.pop(context);
          showErrorDialog(context,
              message: "Unable to upload photos! try again later.");
        }
      }
    } else {
      // Add New Streak
      try {
        _addStreak(UserPreferences.userId, photos, title);
        if (context.mounted) {
          state = AddSkincareStreakState.success;
          Navigator.pop(context);
          Navigator.pop(context);
        }
      } catch (e) {
        if (kDebugMode) print(e.toString());
        if (context.mounted) {
          state = AddSkincareStreakState.error;
          Navigator.pop(context);
          showErrorDialog(context,
              message: "Unable to upload photos! try again later.");
        }
      }
    }
  }

  Future<Map<bool, Streak?>> _getStreak(DateTime date) async {
    try {
      Streak streak = await getStreakUseCase.call(GetStreakParam(
        uid: UserPreferences.userId,
        date: date.toDdmmyyyy(),
      ));
      return {true: streak};
    } catch (e) {
      return {false: null};
    }
  }

  Future<int> _getStreakCount(StreakModel streak) async {
    if (streak.cleanserTime != null &&
        streak.tonerTime != null &&
        streak.moisturizerTime != null &&
        streak.sunscreenTime != null &&
        streak.lipBalmTime != null) {
      DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));

      final responseMap = await _getStreak(yesterday);
      int streakCount = 1;
      if(responseMap.containsKey(true) || responseMap.entries.first.value != null){
        Streak yesterdayStreak = responseMap.entries.first.value!;
        streakCount = yesterdayStreak.streak + 1;
      }
      try {
        if (streakCount > UserPreferences.longestStreak) {
          await updateUserUseCase.call(
            UpdateUserParams(
              uid: UserPreferences.userId,
              userEntity: UserEntity(
                  uid: UserPreferences.userId,
                  name: UserPreferences.userName,
                  email: UserPreferences.email,
                  profilePicUrl: UserPreferences.profilePic ?? "",
                  longestStreak: streakCount,
                  currentStreak: streakCount),
            ),
          );
        }
        return streakCount;
      } catch (e) {
        if (kDebugMode) print(e);
      }
    }
    return 1;
  }

  Future<void> _addStreak(String uid, List<String> photos, String title) async {
    StreakModel model = StreakModel(
        date: DateTime.now(),
        cleanserPhotoUrls: const [],
        tonerPhotoUrls: const [],
        moisturizerPhotoUrls: const [],
        sunscreenPhotoUrls: const [],
        lipBalmPhotoUrls: const [],
        streak: 1);

    model = updateModelValues(model, title, photos);
    await addStreakUseCase
        .call(AddStreakParam(uid: uid, streak: StreakMapper.toEntity(model)));
  }

  Future<void> _updateStreak(
      String title, String uid, List<String> photos, Streak streak) async {
    StreakModel model = StreakMapper.fromEntity(streak);
    print(model.lipBalmTime);

    model = updateModelValues(model, title, photos);
    print(model.lipBalmTime);
    int streakCount = await _getStreakCount(model);

    print(streakCount);
    model.copyWith(streak: streakCount);
    await updateStreakUseCase.call(UpdateStreakParam(
        uid: uid,
        date: DateTime.now().toDdmmyyyy(),
        streak: StreakMapper.toEntity(model)));
  }

  StreakModel updateModelValues(
      StreakModel model, String title, List<String> photos) {
    if (title == skincareProductKeys[0]) {
      model = model.copyWith(
          cleanserTime: DateTime.now(), cleanserPhotoUrls: photos);
    } else if (title == skincareProductKeys[1]) {
      model = model.copyWith(tonerTime: DateTime.now(), tonerPhotoUrls: photos);
    } else if (title == skincareProductKeys[2]) {
      model = model.copyWith(
          moisturizerTime: DateTime.now(), moisturizerPhotoUrls: photos);
    } else if (title == skincareProductKeys[3]) {
      model = model.copyWith(
          sunscreenTime: DateTime.now(), sunscreenPhotoUrls: photos);
    } else if (title == skincareProductKeys[4]) {
      model =
          model.copyWith(lipBalmTime: DateTime.now(), lipBalmPhotoUrls: photos);
    }

    return model;
  }
}
