# string_similarity

[![pub package](https://img.shields.io/pub/v/string_similarity.svg)](https://pub.dev/packages/string_similarity)
[![license: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/jeremylandon/string-similarity/blob/master/LICENSE)

A fast, dependency-free Dart package for measuring the similarity between two
strings with the Sørensen–Dice coefficient.

Use it for fuzzy search, spelling suggestions, duplicate detection, and ranking
the closest match from a list.

## ✨ Why string_similarity?

- Simple extension methods and static methods
- Scores from `0.0` (completely different) to `1.0` (identical)
- Best-match search with individual ratings and the winning index
- No runtime dependencies
- Works on every platform supported by Dart and Flutter

## 📦 Installation

```console
dart pub add string_similarity
```

Then import the package:

```dart
import 'package:string_similarity/string_similarity.dart';
```

## 🚀 Compare two strings

```dart
final score = 'healed'.similarityTo('sealed');

print(score); // 0.8
```

The equivalent static method is:

```dart
final score = StringSimilarity.compareTwoStrings('healed', 'sealed');
```

## 🏆 Find the best match

```dart
final result = 'healed'.bestMatch([
  'edward',
  'sealed',
  'theatre',
]);

print(result.bestMatch.target); // sealed
print(result.bestMatch.rating); // 0.8
print(result.bestMatchIndex); // 1
```

Every candidate and its score remain available in `result.ratings`.

The equivalent static method is:

```dart
final result = StringSimilarity.findBestMatch(
  'healed',
  ['edward', 'sealed', 'theatre'],
);
```

## 🧠 How it works

The package compares adjacent character pairs (bigrams) using the
[Sørensen–Dice coefficient](https://en.wikipedia.org/wiki/S%C3%B8rensen%E2%80%93Dice_coefficient).
Whitespace is removed before comparison. Letter case and diacritics are kept,
so `Cote`, `cote`, and `côte` are different values.

## 🔡 Case-insensitive comparison

Normalize both strings before comparing them:

```dart
final score = 'DART'.toLowerCase().similarityTo('dart'.toLowerCase());

print(score); // 1.0
```

## 🧩 Available methods

| API | Returns | Description |
| --- | --- | --- |
| `value.similarityTo(other)` | `double` | Compares two nullable strings. |
| `value.bestMatch(targets)` | `BestMatch` | Rates every nullable target and selects the best one. |
| `StringSimilarity.compareTwoStrings(first, second)` | `double` | Static alternative to `similarityTo`. |
| `StringSimilarity.findBestMatch(value, targets)` | `BestMatch` | Static alternative to `bestMatch`. |

`BestMatch` provides:

- `ratings`: every target and its score
- `bestMatch`: the highest-rated target
- `bestMatchIndex`: the winning target's original index

## ⚙️ Behavior and edge cases

| Input | Result |
| --- | --- |
| Two identical values, including `null` or `''` | `1.0` |
| Only one value is `null` or empty | `0.0` |
| Different values where either has fewer than two characters | `0.0` |
| Several targets share the highest score | The first one wins |
| The target list is empty | Throws `ArgumentError` |

## 🔎 Comparison details

- Whitespace is ignored, but punctuation is not.
- Comparison is case-sensitive and diacritic-sensitive.
- The algorithm works on UTF-16 code units rather than grapheme clusters, so
  some emoji and combined Unicode characters may not behave like visible
  characters.
- Sørensen–Dice measures shared bigrams. It is not a drop-in replacement for
  edit-distance algorithms such as Levenshtein distance.

## 📄 License

Licensed under the permissive [MIT License](https://github.com/jeremylandon/string-similarity/blob/master/LICENSE).
