import 'package:equatable/equatable.dart';
import 'package:skin_care/src/features/skincare/domain/entity/streak.dart';
import 'package:skin_care/src/features/skincare/domain/repo/skincare_repo.dart';

import '../../../../comman/usecases/usecase.dart';

class AddStreakUseCase implements UseCase<dynamic,AddStreakParam> {
  final SkincareRepo _repository;

  AddStreakUseCase(this._repository);

  @override
  Future <String> call(AddStreakParam params) async {
    return await _repository.addStreak(uid: params.uid, streak: params.streak);
  }
}


class AddStreakParam extends Equatable {
  final String uid;
  final Streak streak;

  const AddStreakParam({required this.uid,required this.streak});

  @override
  List<Object?> get props => [uid,streak];
}