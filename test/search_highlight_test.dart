import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search_highlight/convert_enum.dart';

import 'package:search_highlight/search_highlight.dart';

void main() {
  group('Highlight logic', () {
    test("When text is  'Fed' and searchTerm is 'Fed', should highlight 'Fed'", () {
      final searchHighlight = SearchHighlight(
          text: 'Fed', searchTerm: 'Fed', highlightedStyle: const TextStyle(fontWeight: FontWeight.bold));
      final result = searchHighlight.run();
      expect(result.length, 1);
      expect(result.first, const TextSpan(text: 'Fed ', style: TextStyle(fontWeight: FontWeight.bold)));
    });

    test("When text is 'Fed meeting' and searchTerm is 'Fed', should highlight 'Fed'", () {
      final searchHighlight = SearchHighlight(
          text: 'Fed meeting', searchTerm: 'Fed', highlightedStyle: const TextStyle(fontWeight: FontWeight.bold));
      final result = searchHighlight.run();
      expect(result.length, 3);
      expect(result.first, const TextSpan(text: 'Fed ', style: TextStyle(fontWeight: FontWeight.bold)));
      expect(result[1], const TextSpan(text: 'is '));
      expect(result[2], const TextSpan(text: 'crazy '));
    });

    test("When text is 'Fed meeting' and searchTerm is 'Fed m', should highlight 'Fed m'", () {
      final searchHighlight = SearchHighlight(
          text: 'Fed meeting', searchTerm: 'Fed m', highlightedStyle: const TextStyle(fontWeight: FontWeight.bold));
      final result = searchHighlight.run();
      expect(result.length, 9);
      expect(result[0], const TextSpan(text: 'Fed ', style: TextStyle(fontWeight: FontWeight.bold)));
      expect(result[1], const TextSpan(text: 'm', style: TextStyle(fontWeight: FontWeight.bold)));
      expect(result[2], const TextSpan(text: 'e'));
      expect(result[3], const TextSpan(text: 'e'));
      expect(result[4], const TextSpan(text: 't'));
      expect(result[5], const TextSpan(text: 'i'));
      expect(result[6], const TextSpan(text: 'n'));
      expect(result[7], const TextSpan(text: 'g'));
      expect(result[8], const TextSpan(text: ' '));
    });

    test("When text is 'Fed mmm' and searchTerm is 'Fed m', should highlight 'Fed' and first 'm' occurence", () {
      final searchHighlight = SearchHighlight(
          text: 'Fed mmm', searchTerm: 'Fed m', highlightedStyle: const TextStyle(fontWeight: FontWeight.bold));
      final result = searchHighlight.run();
      expect(result.length, 5);
      expect(result[0], const TextSpan(text: 'Fed ', style: TextStyle(fontWeight: FontWeight.bold)));
      expect(result[1], const TextSpan(text: 'm', style: TextStyle(fontWeight: FontWeight.bold)));
      expect(result[2], const TextSpan(text: 'm'));
      expect(result[3], const TextSpan(text: 'm'));
      expect(result[4], const TextSpan(text: ' '));
    });

    test("When text is 'Number of meetings' and searchTerm is 'Fed m', shouldnt highlight anything", () {
      final searchHighlight = SearchHighlight(
          text: 'Number of meetings',
          searchTerm: 'Fed m',
          highlightedStyle: const TextStyle(fontWeight: FontWeight.bold));
      final result = searchHighlight.run();
      expect(result.length, 3);
      expect(result[0], const TextSpan(text: 'Number '));
      expect(result[1], const TextSpan(text: 'of '));
      expect(result[2], const TextSpan(text: 'meetings '));
    });
  });

  group('When compare is none', () {
    test("When text is  'Fed' and searchTerm is 'fed', shouldnt highlight anything", () {
      final searchHighlight = SearchHighlight(
        text: 'Fed',
        searchTerm: 'fed',
        convert: Convert.none,
        highlightedStyle: const TextStyle(fontWeight: FontWeight.bold),
      );
      final result = searchHighlight.run();
      expect(result.length, 1);
      expect(result.first, const TextSpan(text: 'Fed '));
    });
  });
}
