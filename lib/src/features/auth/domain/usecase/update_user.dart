
import 'package:equatable/equatable.dart';
import 'package:skin_care/src/features/auth/domain/entity/user.dart';


import '../../../../comman/usecases/usecase.dart';
import '../repository/auth_repo.dart';

class UpdateUserUseCase implements UseCase<dynamic,UpdateUserParams> {
  final AuthRepository _repository;

  UpdateUserUseCase(this._repository);

  @override
  Future<String> call(UpdateUserParams params) async {
    return await _repository.updateUser(uid: params.uid, updatedUser: params.userEntity);
  }
}


class UpdateUserParams extends Equatable {
  final String uid;
  final UserEntity userEntity;

  const UpdateUserParams({required this.uid, required this.userEntity});

  @override
  List<Object?> get props => [uid];
}