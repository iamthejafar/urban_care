

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:skin_care/src/features/auth/domain/entity/user.dart';

abstract class AuthRepository {

  Future <UserCredential> login({required String email, required String password});
  Future <UserCredential> signUp({required String email, required String password, required String name,});
  Future <UserEntity> getUser({required String uid});
  Future<String> updateUser({required String uid, required UserEntity updatedUser});

}