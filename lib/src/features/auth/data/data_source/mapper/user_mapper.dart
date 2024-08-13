import '../../../domain/entity/user.dart';
import '../../models/user_model.dart';

class UserMapper {
  static UserEntity toEntity(UserModel model) {
    return UserEntity(
      uid: model.uid,
      name: model.name,
      email: model.email,
      profilePicUrl: model.profilePicUrl,
      currentStreak: model.currentStreak,
      longestStreak: model.longestStreak,
    );
  }

  static UserModel fromEntity(UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      name: entity.name,
      email: entity.email,
      profilePicUrl: entity.profilePicUrl,
      currentStreak: entity.currentStreak,
      longestStreak: entity.longestStreak,
    );
  }
}
