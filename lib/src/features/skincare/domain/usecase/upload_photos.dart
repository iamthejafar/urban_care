import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:skin_care/src/features/skincare/domain/repo/skincare_repo.dart';
import '../../../../comman/usecases/usecase.dart';

class UploadPhotosUseCase implements UseCase<List<String>, UploadPhotosParam> {
  final SkincareRepo _repository;

  UploadPhotosUseCase(this._repository);

  @override
  Future<List<String>> call(UploadPhotosParam params) async {
    return await _repository.uploadPhotos(images: params.images);
  }
}

class UploadPhotosParam extends Equatable {
  final List<File> images;

  const UploadPhotosParam({required this.images});

  @override
  List<Object?> get props => [images];
}
