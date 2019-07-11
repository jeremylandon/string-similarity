import 'package:string_similarity/string_similarity.dart';

void main() {
  StringSimilarity.compareTwoStrings('french', 'quebec'); // -> 0

  StringSimilarity.compareTwoStrings('healed', 'sealed'); // → 0.8

  StringSimilarity.findBestMatch('Olive-green table for sale, in extremely good condition.', <String>[
    'For sale: green Subaru Impreza, 210,000 miles',
    'For sale: table in very good condition, olive green in colour.',
    'Wanted: mountain bike with at least 21 gears.'
  ]);
/* ->
{ ratings:
   [ { target: 'For sale: green Subaru Impreza, 210,000 miles',
       rating: 0.2558139534883721 },
     { target: 'For sale: table in very good condition, olive green in colour.',
       rating: 0.6060606060606061 },
     { target: 'Wanted: mountain bike with at least 21 gears.',
       rating: 0.1411764705882353 } ],
  bestMatch:
   { target: 'For sale: table in very good condition, olive green in colour.',
     rating: 0.6060606060606061 },
  bestMatchIndex: 1 
}
*/
}
