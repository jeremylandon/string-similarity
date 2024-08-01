import 'rating.dart';

/// Dice's Coefficient results
class BestMatch {
  BestMatch(
      {required this.ratings,
      required this.bestMatch,
      required this.bestMatchIndex});

  /// similarity rating for each target string
  List<Rating> ratings;

  /// specifies which target string was most similar to the main string
  Rating bestMatch;

  /// which specifies the index of the bestMatch in the targetStrings array
  int bestMatchIndex;

  @override
  String toString() => '$bestMatchIndex:${bestMatch.toString()}';
}
