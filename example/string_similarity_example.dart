import 'package:string_similarity/string_similarity.dart';

void main() {
  print(StringSimilarity.compareTwoStrings('french', 'quebec')); // prints '0'

  //Using the extension form:
  print('healed'.similarityTo('sealed')); // prints '0.8'

  print(StringSimilarity.findBestMatch(
    'Olive-green table for sale, in extremely good condition.',
    <String>[
      'For sale: green Subaru Impreza, 210,000 miles',
      'For sale: table in very good condition, olive green in colour.',
      'Wanted: mountain bike with at least 21 gears.'
    ],
  ));
  /* prints
      [For sale: green Subaru Impreza, 210,000 miles[0.26],
      For sale: table in very good condition, olive green in colour.[0.61],
      Wanted: mountain bike with at least 21 gears.[0.14]]
      */
}
