import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_care/src/comman/validators/text_validation.dart';
import 'package:skin_care/src/features/skincare/domain/entity/streak.dart';
import 'package:skin_care/src/utils/user_preferences.dart';

import '../../../../utils/dependency_injection.dart';
import '../../domain/usecase/get_streak.dart';

enum GetStreakState { initial, loading, success, error }

final getStreakProvider = StateNotifierProvider<GetStreakStateNotifier, GetStreakState>(
      (ref) => GetStreakStateNotifier(locator()),
);

class GetStreakStateNotifier extends StateNotifier<GetStreakState> {
  final GetStreakUseCase getStreakUseCase;
  Streak? streak;

  GetStreakStateNotifier(this.getStreakUseCase) : super(GetStreakState.initial) {
    getStreak(date: DateTime.now());
  }

  Future<void> getStreak({
    required DateTime date,
  }) async {
    try {
      state = GetStreakState.loading;
      String dateString = date.toDdmmyyyy();
      streak = await getStreakUseCase.call(GetStreakParam(uid: UserPreferences.userId, date: dateString));
      state = GetStreakState.success;
    } catch (e) {
      state = GetStreakState.success;
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }


  String getTimeString(String skincareProductKey, Streak? streak) {
    DateTime? time;

    if(streak != null){
      switch (skincareProductKey) {
        case 'Cleanser':
          time = streak.cleanserTime;
          break;
        case 'Toner':
          time = streak.tonerTime;
          break;
        case 'Moisturizer':
          time = streak.moisturizerTime;
          break;
        case 'Sunscreen':
          time = streak.sunscreenTime;
          break;
        case 'Lip Balm':
          time = streak.lipBalmTime;
          break;
        default:
          return "";
      }
    }
    return formatTime(time);
  }

}
