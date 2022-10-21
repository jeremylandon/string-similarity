import 'package:flutter/foundation.dart';
import 'package:string_similarity/string_similarity.dart';

void main() {
  // compare two strings
  final comparison = 'healed'.similarityTo(
      'sealed'); // or StringSimilarity.compareTwoStrings('healed', 'sealed')
  if (kDebugMode) {
    print(comparison); // → 0.8
    print(null.similarityTo(null)); // -> 1.0
    print('france'.similarityTo(null)); // -> 0.0
  }

  // get the best match
  const mainString = 'Olive-green table for sale, in extremely good condition.';
  const targetStrings = <String?>[
    'For sale: green Subaru Impreza, 210,000 miles',
    'For sale: table in very good condition, olive green in colour.',
    'Wanted: mountain bike with at least 21 gears.',
    null
  ];
  final bestMatch = mainString.bestMatch(
      targetStrings); // or StringSimilarity.findBestMatch(mainString, targetStrings)
  if (kDebugMode) {
    print(
        bestMatch); // → 1:'For sale: table in very good condition, olive green in colour.'[0.6060606060606061]
    print(bestMatch.ratings);
  }
}
