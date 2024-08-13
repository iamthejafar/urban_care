
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:skin_care/src/features/auth/data/data_source/mapper/user_mapper.dart';
import 'package:skin_care/src/features/auth/data/models/user_model.dart';
import 'package:skin_care/src/features/auth/domain/entity/user.dart';

import '../../domain/repository/auth_repo.dart';
import '../data_source/remote/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _apiService;
  AuthRepositoryImpl(this._apiService);

  @override
  Future <UserCredential> login({required String email, required String password}) async {
    try {
      final res =
      await _apiService.login(email: email,password: password);
      if(kDebugMode) print(res);
      return res;
    } catch (e) {
      if(kDebugMode) print(e);
      return Future.error(e.toString());
    }
  }

  @override
  Future <UserCredential> signUp({required String email, required String password,required String name}) async {
    try {
      final res =
      await _apiService.signUp(email: email,password: password, name: name);
      if(kDebugMode) print(res);
      return res;
    } catch (e) {
      if(kDebugMode) print(e);
      return Future.error(e.toString());
    }
  }

  @override
  Future<UserModel> getUser({required String uid}) async {
    try {
      final res =
          await _apiService.getUser(uid: uid);
      if(kDebugMode) print(res);
      return res;
    } catch (e) {
      if(kDebugMode) print(e);
      return Future.error(e.toString());
    }
  }

  @override
  Future<String> updateUser({required String uid, required UserEntity updatedUser}) async {
    try {
      final res =
          await _apiService.updateUser(uid: uid,updatedUser: UserMapper.fromEntity(updatedUser));
      if(kDebugMode) print(res);
      return res;
    } catch (e) {
      if(kDebugMode) print(e);
      return Future.error(e.toString());
    }
  }
}