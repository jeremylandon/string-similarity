# string-similarity

Finds degree of similarity between two strings, based on [Dice's Coefficient](http://en.wikipedia.org/wiki/S%C3%B8rensen%E2%80%93Dice_coefficient), which is mostly better than [Levenshtein distance](http://en.wikipedia.org/wiki/Levenshtein_distance).

## Table of Contents

- [Usage](#usage)
- [API](#api)
  - [compareTwoStrings(first, second)](#comparetwostringsfirst-second)
    - [Arguments](#arguments)
    - [Returns](#returns)
    - [Examples](#examples)
  - [findBestMatch(mainString, targetStrings)](#findbestmatchmainstring-targetstrings)
    - [Arguments](#arguments-1)
    - [Returns](#returns-1)
    - [Examples](#examples-1)

## Usage

Add this to your package's pubspec.yaml file:

```shell
dependencies:
	string-similarity: ^1.0.0
```

In your code:

```dart
import  'package:string_similarity/string_similarity.dart';

var similarity = StringSimilarity.compareTwoStrings('french', 'quebec');

var matches = StringSimilarity.findBestMatch('healed', ['edward', 'sealed', 'theatre']);
```

## API

Requiring the module gives an object with two methods:

### compareTwoStrings(first, second)

Returns a fraction between 0 and 1, which indicates the degree of similarity between the two strings. 0 indicates completely different strings, 1 indicates identical strings. The comparison is case-sensitive.

##### Arguments

1. first (String): The first string
2. second (String): The second string

Order does not make a difference.

##### Returns

(double): A fraction from 0 to 1, both inclusive. Higher number indicates more similarity.

##### Examples

```dart
stringSimilarity.compareTwoStrings('healed', 'sealed');
// → 0.8

stringSimilarity.compareTwoStrings('Olive-green table for sale, in extremely good condition.',
  'For sale: table in very good  condition, olive green in colour.');
// → 0.6060606060606061

stringSimilarity.compareTwoStrings('Olive-green table for sale, in extremely good condition.',
  'For sale: green Subaru Impreza, 210,000 miles');
// → 0.2558139534883721

stringSimilarity.compareTwoStrings('Olive-green table for sale, in extremely good condition.',
  'Wanted: mountain bike with at least 21 gears.');
// → 0.1411764705882353
```

### findBestMatch(mainString, targetStrings)

Compares `mainString` against each string in `targetStrings`.

##### Arguments

1. mainString (String): The string to match each target string against.
2. targetStrings (List\<String\>): Each string in this array will be matched against the main string.

##### Returns

(BestMatch): An object with a `ratings` property, which gives a similarity rating for each target string, a `bestMatch` property, which specifies which target string was most similar to the main string, and a `bestMatchIndex` property, which specifies the index of the bestMatch in the targetStrings array.

##### Examples

```javascript
stringSimilarity.findBestMatch('Olive-green table for sale, in extremely good condition.', [
  'For sale: green Subaru Impreza, 210,000 miles',
  'For sale: table in very good condition, olive green in colour.',
  'Wanted: mountain bike with at least 21 gears.'
]);
// →
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
```

#

**_based on 'string-similarity' Javascript project_** : [https://github.com/aceakash/string-similarity](https://github.com/aceakash/string-similarity)
