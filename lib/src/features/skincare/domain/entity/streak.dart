import 'package:equatable/equatable.dart';

class Streak extends Equatable {
  final DateTime date;
  final List<String> cleanserPhotoUrls;
  final List<String> tonerPhotoUrls;
  final List<String> moisturizerPhotoUrls;
  final List<String> sunscreenPhotoUrls;
  final List<String> lipBalmPhotoUrls;
  final DateTime? cleanserTime;
  final DateTime? tonerTime;
  final DateTime? moisturizerTime;
  final DateTime? sunscreenTime;
  final DateTime? lipBalmTime;
  final int streak;
  const Streak({
    required this.date,
    required this.cleanserPhotoUrls,
    required this.tonerPhotoUrls,
    required this.moisturizerPhotoUrls,
    required this.sunscreenPhotoUrls,
    required this.lipBalmPhotoUrls,
    required this.streak,
    this.cleanserTime,
    this.tonerTime,
    this.moisturizerTime,
    this.sunscreenTime,
    this.lipBalmTime,
  });

  @override
  List<Object?> get props {
    return [
      date,
      cleanserPhotoUrls,
      tonerPhotoUrls,
      moisturizerPhotoUrls,
      sunscreenPhotoUrls,
      lipBalmPhotoUrls,
      streak,
      cleanserTime,
      tonerTime,
      moisturizerTime,
      sunscreenTime,
      lipBalmTime,
    ];
  }
}
