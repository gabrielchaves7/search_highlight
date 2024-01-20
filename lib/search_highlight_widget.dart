import 'package:flutter/material.dart';
import 'package:search_highlight/convert_enum.dart';
import 'package:search_highlight/search_highlight.dart';

class SearchHighlightWidget extends StatefulWidget {
  final TextStyle? style;
  final TextStyle highlightedStyle;
  final String text;
  final String searchTerm;
  final Convert convert;

  const SearchHighlightWidget({
    super.key,
    required this.text,
    required this.searchTerm,
    this.style,
    required this.highlightedStyle,
    this.convert = Convert.lowerCase,
  });
  @override
  State<SearchHighlightWidget> createState() => SearchHighlightWidgetState();
}

class SearchHighlightWidgetState extends State<SearchHighlightWidget> {
  List<TextSpan> textSpans = [];
  late SearchHighlight searchHighlight;

  @override
  void didUpdateWidget(SearchHighlightWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.searchTerm != widget.searchTerm) {
      textSpans = searchHighlight.run();
    }
  }

  @override
  void initState() {
    searchHighlight = SearchHighlight(
      searchTerm: widget.searchTerm,
      text: widget.text,
      style: widget.style,
      highlightedStyle: widget.highlightedStyle,
    );
    textSpans = searchHighlight.run();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(text: TextSpan(children: textSpans));
  }
}
