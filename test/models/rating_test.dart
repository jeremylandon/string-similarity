import 'package:flutter_test/flutter_test.dart';
import 'package:string_similarity/string_similarity.dart';

void main() {
  group('Rating', () {
    test('toString return "target:rating{complete}"', () {
      final rating = Rating(rating: 1 / 3, target: 'str');

      expect(rating.toString(), '\'str\'[0.3333333333333333]');
    });

    test('toString return "target:rating" without useless numbers', () {
      final rating = Rating(rating: 0.10000000000, target: 'str');

      expect(rating.toString(), '\'str\'[0.1]');
    });

    test('toString with null target return "null:rating"', () {
      final rating = Rating(rating: 0.1, target: null);

      expect(rating.toString(), '\'null\'[0.1]');
    });
  });
}
