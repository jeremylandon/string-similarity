import 'package:flutter_test/flutter_test.dart';
import 'package:string_similarity/string_similarity.dart';

class TestData {
  TestData({this.sentenceA, this.sentenceB, required this.expected});

  String? sentenceA;
  String? sentenceB;
  double expected;
}

void main() {
  late List<TestData> testData;
  group('compareTwoStrings', () {
    setUp(() {
      testData = <TestData>[
        TestData(sentenceA: 'french', sentenceB: 'quebec', expected: 0),
        TestData(sentenceA: 'france', sentenceB: 'france', expected: 1),
        TestData(sentenceA: 'fRaNce', sentenceB: 'france', expected: 0.2),
        TestData(
            sentenceA: 'corée du sud',
            sentenceB: 'coree du sud',
            expected: 0.7777777777777778),
        TestData(sentenceA: 'healed', sentenceB: 'sealed', expected: 0.8),
        TestData(
            sentenceA: 'web applications',
            sentenceB: 'applications of the web',
            expected: 0.7878787878787878),
        TestData(
            sentenceA: 'this will have a typo somewhere',
            sentenceB: 'this will huve a typo somewhere',
            expected: 0.92),
        TestData(
          sentenceA: 'Olive-green table for sale, in extremely good condition.',
          sentenceB:
              'For sale: table in very good  condition, olive green in colour.',
          expected: 0.6060606060606061,
        ),
        TestData(
          sentenceA: 'Olive-green table for sale, in extremely good condition.',
          sentenceB: 'For sale: green Subaru Impreza, 210,000 miles',
          expected: 0.2558139534883721,
        ),
        TestData(
          sentenceA: 'Olive-green table for sale, in extremely good condition.',
          sentenceB: 'Wanted: mountain bike with at least 21 gears.',
          expected: 0.1411764705882353,
        ),
        TestData(
            sentenceA: 'this has one extra word',
            sentenceB: 'this has one word',
            expected: 0.7741935483870968),
        TestData(sentenceA: 'A', sentenceB: 'a', expected: 0),
        TestData(sentenceA: 'a', sentenceB: 'a', expected: 1),
        TestData(sentenceA: 'a', sentenceB: 'b', expected: 0),
        TestData(sentenceA: '', sentenceB: '', expected: 1),
        TestData(sentenceA: 'a', sentenceB: '', expected: 0),
        TestData(sentenceA: '', sentenceB: 'a', expected: 0),
        TestData(
            sentenceA: 'apple event', sentenceB: 'apple    event', expected: 1),
        TestData(
            sentenceA: 'iphone',
            sentenceB: 'iphone x',
            expected: 0.9090909090909091),
        TestData(
            sentenceA: '10아이', sentenceB: '10아기', expected: 0.6666666666666666),
        TestData(sentenceA: null, sentenceB: 'b', expected: 0),
        TestData(sentenceA: 'a', sentenceB: null, expected: 0),
        TestData(sentenceA: null, sentenceB: null, expected: 1),
      ];
    });

    test('returns the correct value for different inputs', () {
      for (var td in testData) {
        expect(StringSimilarity.compareTwoStrings(td.sentenceA, td.sentenceB),
            td.expected);
      }
    });

    test(
        'similarityTo extensions method return same result that StringSimilarity.compareTwoStrings',
        () {
      for (var td in testData) {
        final a =
            StringSimilarity.compareTwoStrings(td.sentenceA, td.sentenceB);
        final b = td.sentenceA.similarityTo(td.sentenceB);

        expect(a.toString(), b.toString());
      }
    });
  });

  group('findBestMatch', () {
    setUp(() {
      testData = <TestData>[
        TestData(sentenceA: 'mailed', expected: 0.4),
        TestData(sentenceA: 'edward', expected: 0.2),
        TestData(sentenceA: 'sealed', expected: 0.8),
        TestData(sentenceA: 'theatre', expected: 0.36363636363636365),
      ];
    });

    test('assigns a similarity rating to each string passed in the array', () {
      final matches = StringSimilarity.findBestMatch('healed',
          testData.map((TestData testEntry) => testEntry.sentenceA).toList());

      for (var i = 0; i < matches.ratings.length; i++) {
        expect(testData[i].sentenceA, matches.ratings[i].target);
        expect(testData[i].expected, matches.ratings[i].rating);
      }
    });

    test('returns the best match and its similarity rating', () {
      final matches = StringSimilarity.findBestMatch('healed',
          testData.map((TestData testEntry) => testEntry.sentenceA).toList());

      expect(matches.bestMatch.target, 'sealed');
      expect(matches.bestMatch.rating, 0.8);
    });

    test('returns the index of best match from the target strings', () {
      final matches = StringSimilarity.findBestMatch('healed',
          testData.map((TestData testEntry) => testEntry.sentenceA).toList());

      expect(matches.bestMatchIndex, 2);
    });

    test(
        'bestMatch extensions method return same result that StringSimilarity.findBestMatch',
        () {
      const mainString = 'healed';
      final targetStrings =
          testData.map((TestData testEntry) => testEntry.sentenceA).toList();
      final a = StringSimilarity.findBestMatch(mainString, targetStrings);
      final b = mainString.bestMatch(targetStrings);

      expect(a.toString(), b.toString());
    });

    test('bestMatch extensions method can be call on null anonymous variable',
        () {
      final a = null.bestMatch([null]);
      final b = null.bestMatch(['a']);

      expect(a.bestMatch.rating, 1);
      expect(b.bestMatch.rating, 0);
    });
  });
}
