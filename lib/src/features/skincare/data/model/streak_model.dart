import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skin_care/src/features/skincare/domain/entity/streak.dart';

class StreakModel extends Streak {
  const StreakModel({
    required super.date,
    required super.cleanserPhotoUrls,
    required super.tonerPhotoUrls,
    required super.moisturizerPhotoUrls,
    required super.sunscreenPhotoUrls,
    required super.lipBalmPhotoUrls,
    required super.streak,
    super.tonerTime,
    super.cleanserTime,
    super.moisturizerTime,
    super.sunscreenTime,
    super.lipBalmTime,
  });

  factory StreakModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return StreakModel(
      date: (data['date'] as Timestamp).toDate(),
      cleanserPhotoUrls: List<String>.from(data['cleanserPhotoUrls'] ?? []),
      tonerPhotoUrls: List<String>.from(data['tonerPhotoUrls'] ?? []),
      moisturizerPhotoUrls:
          List<String>.from(data['moisturizerPhotoUrls'] ?? []),
      sunscreenPhotoUrls: List<String>.from(data['sunscreenPhotoUrls'] ?? []),
      lipBalmPhotoUrls: List<String>.from(data['lipBalmPhotoUrls'] ?? []),
      streak: data['streak'],
      cleanserTime: data['cleanserTime'] != null
          ? (data['cleanserTime'] as Timestamp).toDate()
          : null,
      tonerTime: data['tonerTime'] != null
          ? (data['tonerTime'] as Timestamp).toDate()
          : null,
      moisturizerTime: data['moisturizerTime'] != null
          ? (data['moisturizerTime'] as Timestamp).toDate()
          : null,
      sunscreenTime: data['sunscreenTime'] != null
          ? (data['sunscreenTime'] as Timestamp).toDate()
          : null,
      lipBalmTime: data['lipBalmTime'] != null
          ? (data['lipBalmTime'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'cleanserPhotoUrls': cleanserPhotoUrls,
      'tonerPhotoUrls': tonerPhotoUrls,
      'moisturizerPhotoUrls': moisturizerPhotoUrls,
      'sunscreenPhotoUrls': sunscreenPhotoUrls,
      'lipBalmPhotoUrls': lipBalmPhotoUrls,
      'streak': streak,
      'cleanserTime': cleanserTime,
      'tonerTime': tonerTime,
      'moisturizerTime': moisturizerTime,
      'sunscreenTime': sunscreenTime,
      'lipBalmTime': lipBalmTime,
    };
  }
  StreakModel copyWith({
    DateTime? date,
    List<String>? cleanserPhotoUrls,
    List<String>? tonerPhotoUrls,
    List<String>? moisturizerPhotoUrls,
    List<String>? sunscreenPhotoUrls,
    List<String>? lipBalmPhotoUrls,
    int? streak,
    DateTime? cleanserTime,
    DateTime? tonerTime,
    DateTime? moisturizerTime,
    DateTime? sunscreenTime,
    DateTime? lipBalmTime,
  }) {
    return StreakModel(
      date: date ?? this.date,
      cleanserPhotoUrls: cleanserPhotoUrls ?? this.cleanserPhotoUrls,
      tonerPhotoUrls: tonerPhotoUrls ?? this.tonerPhotoUrls,
      moisturizerPhotoUrls: moisturizerPhotoUrls ?? this.moisturizerPhotoUrls,
      sunscreenPhotoUrls: sunscreenPhotoUrls ?? this.sunscreenPhotoUrls,
      lipBalmPhotoUrls: lipBalmPhotoUrls ?? this.lipBalmPhotoUrls,
      streak: streak ?? this.streak,
      cleanserTime: cleanserTime ?? this.cleanserTime,
      tonerTime: tonerTime ?? this.tonerTime,
      moisturizerTime: moisturizerTime ?? this.moisturizerTime,
      sunscreenTime: sunscreenTime ?? this.sunscreenTime,
      lipBalmTime: lipBalmTime ?? this.lipBalmTime,
    );
  }
}
