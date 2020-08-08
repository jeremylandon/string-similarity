
class Rating {
  Rating({this.target, this.rating});

  String target;
  double rating;

  @override
  String toString() => '$target[${rating.toStringAsFixed(2)}]';
}