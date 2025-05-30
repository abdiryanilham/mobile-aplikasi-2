class Food {
  final String name;
  final String city;
  final String difficulty;
  final String rating;

  Food({
    required this.name,
    required this.city,
    required this.difficulty,
    required this.rating,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Food &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          city == other.city &&
          difficulty == other.difficulty &&
          rating == other.rating;

  @override
  int get hashCode =>
      name.hashCode ^ city.hashCode ^ difficulty.hashCode ^ rating.hashCode;
}
