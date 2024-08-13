import 'package:equatable/equatable.dart';
import 'package:skin_care/src/features/skincare/domain/entity/streak.dart';
import 'package:skin_care/src/features/skincare/domain/repo/skincare_repo.dart';
import '../../../../comman/usecases/usecase.dart';

class UpdateStreakUseCase implements UseCase<void, UpdateStreakParam> {
  final SkincareRepo _repository;

  UpdateStreakUseCase(this._repository);

  @override
  Future<void> call(UpdateStreakParam params) async {
    return await _repository.updateStreak(
      uid: params.uid,
      date: params.date,
      streak: params.streak,
    );
  }
}

class UpdateStreakParam extends Equatable {
  final String uid;
  final String date;
  final Streak streak;

  const UpdateStreakParam({
    required this.uid,
    required this.date,
    required this.streak,
  });

  @override
  List<Object?> get props => [uid, date, streak];
}
