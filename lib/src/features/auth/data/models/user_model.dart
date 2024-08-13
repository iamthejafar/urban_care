import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entity/user.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required super.uid,
      required super.name,
      required super.email,
      required super.profilePicUrl,
      required super.currentStreak,
      required super.longestStreak});

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshot.id,
      name: data['name'],
      email: data['email'],
      profilePicUrl: data['profilePicUrl'],
      longestStreak: data['longestStreak'] ?? 0,
      currentStreak: data['currentStreak'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'profilePicUrl': profilePicUrl,
      'longestStreak' : longestStreak,
      'currentStreak' : currentStreak
    };
  }

  UserModel copyWith({
    String? uid,
    String? about,
    String? name,
    String? email,
    String? profilePicUrl,
    int? currentStreak,
    int? longestStreak
  }) {
    return UserModel(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        profilePicUrl: profilePicUrl ?? this.profilePicUrl,
        currentStreak: currentStreak ?? this.currentStreak,
        longestStreak: longestStreak ?? this.longestStreak);
  }
}
