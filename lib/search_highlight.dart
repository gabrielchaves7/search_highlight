library search_highlight;

import 'package:flutter/material.dart';
import 'package:search_highlight/convert_enum.dart';

class SearchHighlight {
  final TextStyle? style;
  final TextStyle highlightedStyle;
  final String text;
  final String searchTerm;
  final Convert convert;

  SearchHighlight({
    this.style,
    required this.highlightedStyle,
    required this.text,
    required this.searchTerm,
    this.convert = Convert.lowerCase,
  });

  List<TextSpan> run() {
    List<TextSpan> textSpans = [];
    List<String> searchTerms = searchTerm.split(' ');
    searchTerms.removeWhere((it) => it.trim().isEmpty);
    List<String> phrasesTerms = text.split(' ');

    int searchTermIndex = 0;
    for (var text in phrasesTerms) {
      String term = '';
      if (searchTermIndex <= searchTerms.length - 1) {
        term = searchTerms[searchTermIndex];
      } else {
        textSpans.add(TextSpan(text: '$text ', style: style));
      }

      if (term.trim().isEmpty) continue;
      if (text.to(convert) == term.to(convert)) {
        searchTermIndex++;
        textSpans.add(TextSpan(text: '$text ', style: highlightedStyle));
      } else if (text.to(convert).contains(term.to(convert))) {
        searchTermIndex++;
        int indexM = text.to(convert).indexOf(term.to(convert));

        for (final (index, char) in text.characters.indexed) {
          if (index < indexM) {
            textSpans.add(TextSpan(text: char, style: style));
          } else if (index >= indexM && (index - indexM < term.length)) {
            textSpans.add(TextSpan(text: char, style: highlightedStyle));
          } else {
            textSpans.add(TextSpan(text: char, style: style));
          }
        }

        textSpans.add(TextSpan(text: ' ', style: style));
      } else {
        textSpans.add(TextSpan(text: '$text ', style: style));
      }
    }

    return textSpans;
  }
}

extension _Convert on String {
  String to(Convert convert) {
    if (convert == Convert.lowerCase) {
      return toLowerCase();
    } else if (convert == Convert.upperCase) {
      return toUpperCase();
    }

    return this;
  }
}
