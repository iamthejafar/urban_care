import 'package:equatable/equatable.dart';
import 'package:skin_care/src/features/skincare/domain/entity/streak.dart';
import 'package:skin_care/src/features/skincare/domain/repo/skincare_repo.dart';
import '../../../../comman/usecases/usecase.dart';

class GetStreaksUseCase implements UseCase<List<Streak>, GetStreaksParam> {
  final SkincareRepo _repository;

  GetStreaksUseCase(this._repository);

  @override
  Future<List<Streak>> call(GetStreaksParam params) async {
    return await _repository.getStreaks(uid: params.uid);
  }
}

class GetStreaksParam extends Equatable {
  final String uid;

  const GetStreaksParam({required this.uid});

  @override
  List<Object?> get props => [uid];
}
