import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_care/src/features/skincare/domain/entity/streak.dart';
import 'package:skin_care/src/utils/user_preferences.dart';
import '../../../../utils/dependency_injection.dart';
import '../../domain/usecase/get_streaks.dart';

enum GetStreaksState { initial, loading, success, error }

final getStreaksProvider = StateNotifierProvider<GetStreaksStateNotifier, GetStreaksState>(
      (ref) => GetStreaksStateNotifier(locator()),
);

class GetStreaksStateNotifier extends StateNotifier<GetStreaksState> {
  final GetStreaksUseCase getStreaksUseCase;
  List<Streak> streaks = [];

  GetStreaksStateNotifier(this.getStreaksUseCase) : super(GetStreaksState.initial) {
    getStreaks();
  }

  Future<void> getStreaks() async {
    try {
      state = GetStreaksState.loading;
      streaks = await getStreaksUseCase.call(GetStreaksParam(uid: UserPreferences.userId));
      state = GetStreaksState.success;
    } on Exception catch (e) {
      state = GetStreaksState.error;
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}


final selectedPeriodProvider = StateProvider<String>((ref)=>"1W");