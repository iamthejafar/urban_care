

import 'package:skin_care/src/features/skincare/domain/entity/streak.dart';

import '../../model/streak_model.dart';

class StreakMapper {
  static Streak toEntity(StreakModel model) {
    return Streak(
      date: model.date,
      cleanserPhotoUrls: model.cleanserPhotoUrls,
      tonerPhotoUrls: model.tonerPhotoUrls,
      moisturizerPhotoUrls: model.moisturizerPhotoUrls,
      sunscreenPhotoUrls: model.sunscreenPhotoUrls,
      lipBalmPhotoUrls: model.lipBalmPhotoUrls,
      streak: model.streak,
      cleanserTime: model.cleanserTime,
      tonerTime: model.tonerTime,
      moisturizerTime: model.moisturizerTime,
      sunscreenTime: model.sunscreenTime,
      lipBalmTime: model.lipBalmTime
    );
  }

  static StreakModel fromEntity(Streak entity) {
    return StreakModel(
      date: entity.date,
      cleanserPhotoUrls: entity.cleanserPhotoUrls,
      tonerPhotoUrls: entity.tonerPhotoUrls,
      moisturizerPhotoUrls: entity.moisturizerPhotoUrls,
      sunscreenPhotoUrls: entity.sunscreenPhotoUrls,
      lipBalmPhotoUrls: entity.lipBalmPhotoUrls,
      streak: entity.streak,
        cleanserTime: entity.cleanserTime,
        tonerTime: entity.tonerTime,
        moisturizerTime: entity.moisturizerTime,
        sunscreenTime: entity.sunscreenTime,
        lipBalmTime: entity.lipBalmTime
    );
  }
}
