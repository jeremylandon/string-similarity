import 'package:string_similarity/string_similarity.dart';
import 'package:test/test.dart';

void main() {
  group('Rating', () {
    test('toString return "target:rating{2}"', () {
      final rating = Rating(rating: 1.23456, target: 'str');

        expect(rating.toString(), 'str[1.23]');
    });
  });
}