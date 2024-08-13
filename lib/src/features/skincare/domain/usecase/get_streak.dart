
import 'package:equatable/equatable.dart';
import 'package:skin_care/src/features/skincare/domain/entity/streak.dart';
import 'package:skin_care/src/features/skincare/domain/repo/skincare_repo.dart';

import '../../../../comman/usecases/usecase.dart';

class GetStreakUseCase implements UseCase<Streak, GetStreakParam> {
  final SkincareRepo _repository;

  GetStreakUseCase(this._repository);

  @override
  Future<Streak> call(GetStreakParam params) async {
    return await _repository.getStreak(uid: params.uid, date: params.date);
  }
}

class GetStreakParam extends Equatable {
  final String uid;
  final String date;

  const GetStreakParam({required this.uid, required this.date});

  @override
  List<Object?> get props => [uid, date];
}
