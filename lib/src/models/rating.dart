/// Dice's Coefficient result
class Rating {
  Rating({this.target, this.rating});

  /// reference text
  String? target;

  /// between 0 and 1. 0 indicates completely different strings, 1 indicates identical strings.
  double? rating;

  @override
  String toString() => '\'$target\'[$rating]';
}
