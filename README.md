# string-similarity

Finds degree of similarity between two strings, based on [Dice's Coefficient](https://en.wikipedia.org/wiki/S%C3%B8rensen%E2%80%93Dice_coefficient), which is mostly better than [Levenshtein distance](https://en.wikipedia.org/wiki/Levenshtein_distance).
## Try it out :
[Click Here 👆](https://dartpad.dev/?id=8dcd21b08f8d6a884fd66470500d8d96)
## :page_facing_up: Table of Contents

- [Usage](#usage)
- [API](#api)
  - ['string'.similarityTo(other)](#stringsimilarityToother)
    - [Arguments](#arguments)
    - [Returns](#returns)
    - [Examples](#examples)
  - ['string'.bestMatch(targetStrings)](#stringbestMatchtargetStrings)
    - [Arguments](#arguments-1)
    - [Returns](#returns-1)
    - [Examples](#examples-1)

## :video_game: Usage

In your code:

```dart
import  'package:string_similarity/string_similarity.dart';

var similarity = 'french'.similarityTo('quebec'); // or StringSimilarity.compareTwoStrings('french', 'quebec');

var matches = 'healed'.bestMatch(['edward', 'sealed', 'theatre']); // or StringSimilarity.findBestMatch('healed', ['edward', 'sealed', 'theatre']);
```

## :books: API

### 'string'.similarityTo(other)

Returns a fraction between 0 and 1, which indicates the degree of similarity between the two strings. 0 indicates completely different strings, 1 indicates identical strings. The comparison is case and diacritic sensitive.

#### Arguments

- other (String): The second string

Order does not make a difference.

#### Returns

(double): A fraction from 0 to 1, both inclusive. Higher number indicates more similarity.

#### Examples

```dart
'healed'.similarityTo('sealed'); // → 0.8

'france'.similarityTo('FrancE'); // → 0.6

'x'.similarityTo(null); // → 0.0

'Olive-green table for sale, in extremely good condition.'.similarityTo('For sale: table in very good  condition, olive green in colour.'); // → 0.6060606060606061
```

or you can use the `StringSimilarity.compareTwoStrings` static method

```dart
StringSimilarity.compareTwoStrings('healed', 'sealed'); // → 0.8
```

### 'string'.bestMatch(targetStrings)

Compares `mainString` against each string in `targetStrings`.

#### Arguments

- targetStrings (List\<String\>): Each string in this array will be matched against the main string.

#### Returns

(BestMatch): An object with a `ratings` property, which gives a similarity rating for each target string, a `bestMatch` property, which specifies which target string was most similar to the main string, and a `bestMatchIndex` property, which specifies the index of the bestMatch in the targetStrings array.

#### Examples

```dart
'Olive-green table for sale, in extremely good condition.'.bestMatch([
  'For sale: green Subaru Impreza, 210,000 miles',
  'For sale: table in very good condition, olive green in colour.',
  'Wanted: mountain bike with at least 21 gears.',
  null
]);
// →
{ ratings:[ 
     { target: 'For sale: green Subaru Impreza, 210,000 miles', rating: 0.2558139534883721 },
     { target: 'For sale: table in very good condition, olive green in colour.', rating: 0.6060606060606061 },
     { target: 'Wanted: mountain bike with at least 21 gears.', rating: 0.1411764705882353 },
     { target: null, rating: 0.0 }
  ],
  bestMatch: { target: 'For sale: table in very good condition, olive green in colour.', rating: 0.6060606060606061 },
  bestMatchIndex: 1
}
```

or you can use the `StringSimilarity.findBestMatch` static method

```dart
StringSimilarity.findBestMatch('Olive-green table for sale, in extremely good condition.', [
  'For sale: green Subaru Impreza, 210,000 miles',
  'For sale: table in very good condition, olive green in colour.',
  'Wanted: mountain bike with at least 21 gears.',
  null
]);
```

## :crystal_ball: Credit

**_based on 'string-similarity' Javascript project_** : [https://github.com/aceakash/string-similarity](https://github.com/aceakash/string-similarity)

thanks [@shinayser](https://github.com/shinayser) and [@nilsreichardt](https://github.com/nilsreichardt)
