import 'package:hive/hive.dart';

part 'restaurant.g.dart';

@HiveType(typeId: 1)
class Restaurant extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String cuisine;

  @HiveField(2)
  final String location;

  @HiveField(3)
  final double rating;

  @HiveField(4)
  final String imageUrl;

  @HiveField(5)
  bool isFavorite;

  Restaurant({
    required this.name,
    required this.cuisine,
    required this.location,
    required this.rating,
    required this.imageUrl,
    this.isFavorite = false,
  });
}
