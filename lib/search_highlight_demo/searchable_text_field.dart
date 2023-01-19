import 'package:flutter/material.dart';

class SearchableTextField extends StatefulWidget {
  final bool isSearchView;
  final TextEditingController controller;
  final void Function(String value)? onChanged;
  final List<String> searchWords;
  final void Function() closeSearch;
  const SearchableTextField(
      {super.key,
      this.isSearchView = false,
      required this.controller,
      this.onChanged,
      this.searchWords = const [],
      required this.closeSearch});

  @override
  State<SearchableTextField> createState() => _SearchableTextFieldState();
}

class _SearchableTextFieldState extends State<SearchableTextField> {
  late String editingValue;
  @override
  void initState() {
    editingValue = widget.controller.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
      widget.isSearchView && widget.searchWords != null && widget.searchWords.isNotEmpty
          ? searchViewText()
          : Expanded(
              child: TextField(
                controller: widget.controller,
                onChanged: (value) {
                  editingValue = value;
                  if (widget.onChanged != null) widget.onChanged!(value);
                },
              ),
            )
    ]);
  }

  TextStyle get highLightStyle => const TextStyle(color: Colors.red);

  Widget searchViewText() {
    List<String> splitList = [];

    for (var element in editingValue.split(" ")) {
      bool canHighlight = false;
      String matchedWord = "";
      for (String word in widget.searchWords) {
        if (element.contains(word)) {
          canHighlight = true;
          matchedWord = word;
          break;
        }
      }
      if (canHighlight) {
        String word = element;
        int index = word.indexOf(matchedWord);
        splitList.add(word.substring(0, index));
        splitList.add(word.substring(index, index + matchedWord.length));
        splitList.add(word.substring(index + matchedWord.length));
        splitList.add(" ");
      } else {
        splitList.add(element);
        splitList.add(" ");
      }
    }

    return InkWell(
      onTap: widget.closeSearch,
      child: Text.rich(
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        maxLines: 100,
        TextSpan(
            text: splitList.first,
            style: widget.searchWords.contains(splitList.first) ? highLightStyle : null,
            children: splitList
                .skip(1)
                .map((e) => TextSpan(
                      text: e,
                      style: widget.searchWords.contains(e) ? highLightStyle : null,
                    ))
                .toList()),
        textScaleFactor: 1,
        textDirection: TextDirection.ltr,
      ),
    );
    // return RichText(

    //   text: TextSpan(text: splits.first, children: splits.skip(1).map((e) => TextSpan(text: e)).toList()),
    // );
  }
}
