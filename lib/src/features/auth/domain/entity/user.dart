import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{

  final String uid;
  final String name;
  final String email;
  final String profilePicUrl;
  final int currentStreak;
  final int longestStreak;

  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.profilePicUrl,
    required this.currentStreak,
    required this.longestStreak
  });

  @override
  List < Object ? > get props {
    return [
      uid,
      name,
      email,
      profilePicUrl,
      currentStreak,
      longestStreak
    ];
  }
}