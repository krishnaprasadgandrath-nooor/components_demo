import 'package:components_demo/search_highlight_demo/searchable_text_field.dart';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class SearchHighlightScreen extends StatefulWidget {
  const SearchHighlightScreen({super.key});

  @override
  State<SearchHighlightScreen> createState() => _SearchHighlightScreenState();
}

class _SearchHighlightScreenState extends State<SearchHighlightScreen> {
  Map<int, String> sampleTextMap = {
    11: 'Lorem Ipsum is simply dummy text of the printing',
    12: ' and typesetting industry',
    13: 'Lorem Ipsum has been the industry"s standard dummy text ever since the 1500s',
    14: "when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    15: "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
  };

  Map<int, TextEditingController> ctrlMap = {};

  bool isSearchView = false;
  List<String> searchWords = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    generateControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Searcxh Highlight Demo"),
      body: Column(
        children: [
          SizedBox(
              child: TextFormField(
            controller: searchController,
            onEditingComplete: (/*value*/) {
              String value = searchController.text;
              if (value.isNotEmpty) {
                searchWords = value.split(" ");
                if (!isSearchView && searchWords.isNotEmpty) isSearchView = true;
                setState(() {});
              }
            },
            decoration: const InputDecoration(border: OutlineInputBorder()),
          )),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                  children: sampleTextMap.entries
                      .map((e) => SizedBox(
                            height: 40,
                            child: SearchableTextField(
                              controller: ctrlMap[e.key]!,
                              isSearchView: isSearchView,
                              onChanged: (value) => sampleTextMap[e.key] = value,
                              closeSearch: () {
                                if (isSearchView) {
                                  isSearchView = !isSearchView;
                                  searchController.clear();
                                  setState(() {});
                                }
                              },
                              searchWords: searchWords,
                            ),
                          ))
                      .toList()),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        child: const Icon(Icons.search),
      ),
    );
  }

  void generateControllers() {
    for (var element in sampleTextMap.entries) {
      TextEditingController controller = TextEditingController(text: element.value);
      ctrlMap[element.key] = controller;
    }
  }
}
