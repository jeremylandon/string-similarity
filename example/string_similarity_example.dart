import 'package:string_similarity/string_similarity.dart';

void main() {
  final score = 'healed'.similarityTo('sealed');
  print(score); // 0.8

  final result = 'healed'.bestMatch([
    'edward',
    'sealed',
    'theatre',
  ]);

  print(result.bestMatch.target); // sealed
  print(result.bestMatch.rating); // 0.8
  print(result.bestMatchIndex); // 1
  print(result.ratings);
  // ['edward'[0.2], 'sealed'[0.8], 'theatre'[0.36363636363636365]]
}
