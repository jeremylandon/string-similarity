/// Finds degree of similarity between two strings, based on Dice's Coefficient, which is mostly better than Levenshtein distance.
class StringSimilarity {
  /// Returns a fraction between 0 and 1, which indicates the degree of similarity between the two strings. 0 indicates completely different strings, 1 indicates identical strings. The comparison is case-sensitive.
  ///
  /// ##### Arguments
  /// - first (string): The first string
  /// - second (string): The second string
  ///
  /// (Order does not make a difference)
  ///
  /// ##### Returns
  /// (number): A fraction from 0 to 1, both inclusive. Higher number indicates more similarity.
  static double compareTwoStrings(String first, String second) {
    first = first.replaceAll(RegExp(r'\s+\b|\b\s'), ''); // remove all whitespace
    second = second.replaceAll(RegExp(r'\s+\b|\b\s'), ''); // remove all whitespace

    // if both are empty strings
    if (first.isEmpty && second.isEmpty) {
      return 1;
    }
    // if only one is empty string
    if (first.isEmpty || second.isEmpty) {
      return 0;
    }
    // identical
    if (first == second) {
      return 1;
    }
    // both are 1-letter strings
    if (first.length == 1 && second.length == 1) {
      return 0;
    }
    // if either is a 1-letter string
    if (first.length < 2 || second.length < 2) {
      return 0;
    }

    final Map<String, int> firstBigrams = <String, int>{};
    for (int i = 0; i < first.length - 1; i++) {
      final String bigram = first.substring(i, i + 2);
      final int count = firstBigrams.containsKey(bigram) ? firstBigrams[bigram] + 1 : 1;
      firstBigrams[bigram] = count;
    }

    int intersectionSize = 0;
    for (int i = 0; i < second.length - 1; i++) {
      final String bigram = second.substring(i, i + 2);
      final int count = firstBigrams.containsKey(bigram) ? firstBigrams[bigram] : 0;

      if (count > 0) {
        firstBigrams[bigram] = count - 1;
        intersectionSize++;
      }
    }

    return (2.0 * intersectionSize) / (first.length + second.length - 2);
  }

  /// Compares mainString against each string in targetStrings
  ///
  /// ##### Arguments
  /// - mainString (string): The string to match each target string against.
  /// - targetStrings (Array): Each string in this array will be matched against the main string.
  ///
  /// ##### Returns
  /// (Object): An object with a ratings property, which gives a similarity rating for each target string, a bestMatch property, which specifies which target string was most similar to the main string, and a bestMatchIndex property, which specifies the index of the bestMatch in the targetStrings array.
  static BestMatch findBestMatch(String mainString, List<String> targetStrings) {
    final List<Rating> ratings = <Rating>[];
    int bestMatchIndex = 0;

    for (int i = 0; i < targetStrings.length; i++) {
      final String currentTargetString = targetStrings[i];
      final double currentRating = compareTwoStrings(mainString, currentTargetString);
      ratings.add(Rating(target: currentTargetString, rating: currentRating));
      if (currentRating > ratings[bestMatchIndex].rating) {
        bestMatchIndex = i;
      }
    }

    final Rating bestMatch = ratings[bestMatchIndex];

    return BestMatch(ratings: ratings, bestMatch: bestMatch, bestMatchIndex: bestMatchIndex);
  }
}

class Rating {
  Rating({this.target, this.rating});

  String target;
  double rating;
}

class BestMatch {
  BestMatch({this.ratings, this.bestMatch, this.bestMatchIndex});

  /// similarity rating for each target string
  List<Rating> ratings;

  /// specifies which target string was most similar to the main string
  Rating bestMatch;

  /// which specifies the index of the bestMatch in the targetStrings array
  int bestMatchIndex;
}
