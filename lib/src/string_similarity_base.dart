import 'models/best_match.dart';
import 'models/rating.dart';

/// Finds degree of similarity between two strings, based on Dice's Coefficient, which is mostly better than Levenshtein distance.
class StringSimilarity {
  static final RegExp _whitespaceRegex = RegExp(r'\s+');

  /// Returns a fraction between 0 and 1, which indicates the degree of similarity between the two strings. 0 indicates completely different strings, 1 indicates identical strings. The comparison is case-sensitive.
  ///
  /// _(same as 'string'.similarityTo extension method)_
  ///
  /// ##### Arguments
  /// - first (String?): The first string
  /// - second (String?): The second string
  ///
  /// (Order does not make a difference)
  ///
  /// ##### Returns
  /// (number): A fraction from 0 to 1, both inclusive. Higher number indicates more similarity.
  static double compareTwoStrings(String? first, String? second) {
    final normalizedFirst = _normalize(first);
    final normalizedSecond = _normalize(second);
    return _compareNormalizedStrings(normalizedFirst, normalizedSecond);
  }

  /// Compares mainString against each string in targetStrings
  ///
  /// _(same as 'string'.bestMatch extension method)_
  ///
  /// ##### Arguments
  /// - mainString (String?): The string to match each target string against.
  /// - targetStrings (`List<String?>`): Each string in this array will be matched against the main string.
  ///
  /// ##### Returns
  /// (BestMatch): An object with a ratings property, which gives a similarity rating for each target string, a bestMatch property, which specifies which target string was most similar to the main string, and a bestMatchIndex property, which specifies the index of the bestMatch in the targetStrings array.
  static BestMatch findBestMatch(String? mainString, List<String?> targetStrings) {
    if (targetStrings.isEmpty) {
      throw ArgumentError.value(
          targetStrings, 'targetStrings', 'must not be empty');
    }

    final targetCount = targetStrings.length;
    final ratings = List<Rating>.filled(targetCount, Rating(), growable: false);
    final normalizedMainString = _normalize(mainString);
    var bestMatchIndex = 0;
    var bestMatchRating = -1.0;

    for (var i = 0; i < targetCount; i++) {
      final currentTargetString = targetStrings[i];
      final currentRating = _compareNormalizedStrings(normalizedMainString, _normalize(currentTargetString));
      ratings[i] = Rating(target: currentTargetString, rating: currentRating);
      if (currentRating > bestMatchRating) {
        bestMatchRating = currentRating;
        bestMatchIndex = i;
      }
    }

    final bestMatch = ratings[bestMatchIndex];

    return BestMatch(ratings: ratings, bestMatch: bestMatch, bestMatchIndex: bestMatchIndex);
  }

  static String? _normalize(String? value) => value?.replaceAll(_whitespaceRegex, '');

  static double _compareNormalizedStrings(String? first, String? second) {
    // if both are null
    if (first == null && second == null) {
      return 1;
    }
    // as both are not null if one of them is null then return 0
    if (first == null || second == null) {
      return 0;
    }

    final firstLength = first.length;
    final secondLength = second.length;

    // if both are empty strings
    if (firstLength == 0 && secondLength == 0) {
      return 1;
    }
    // if only one is empty string
    if (firstLength == 0 || secondLength == 0) {
      return 0;
    }
    // identical
    if (first == second) {
      return 1;
    }
    // if either is a 1-letter string
    if (firstLength < 2 || secondLength < 2) {
      return 0;
    }

    final firstUnits = first.codeUnits;
    final firstBigrams = <int, int>{};
    final firstBigramLimit = firstUnits.length - 1;

    for (var i = 0; i < firstBigramLimit; i++) {
      final key = (firstUnits[i] << 16) | firstUnits[i + 1];
      firstBigrams[key] = (firstBigrams[key] ?? 0) + 1;
    }

    var intersectionSize = 0;
    final secondUnits = second.codeUnits;
    final secondBigramLimit = secondUnits.length - 1;

    for (var i = 0; i < secondBigramLimit; i++) {
      final key = (secondUnits[i] << 16) | secondUnits[i + 1];
      final count = firstBigrams[key] ?? 0;

      if (count > 0) {
        firstBigrams[key] = count - 1;
        intersectionSize++;
      }
    }

    return (2.0 * intersectionSize) / (firstLength + secondLength - 2);
  }
}
