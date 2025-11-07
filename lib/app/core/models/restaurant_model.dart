import 'package:equatable/equatable.dart';

class RestaurantModel extends Equatable {
  @override
  List<Object?> get props => [title, subtitle, imageUrl];
  final String title;
  final String subtitle;
  final String imageUrl;
  final String? videoUrl;
  final bool isSaved;

  const RestaurantModel({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.videoUrl,
    this.isSaved = false,
  });
}
