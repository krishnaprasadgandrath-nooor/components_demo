// index_list_tile_screen.dart

import 'package:components_demo/index_page_list_tile_demo/index_page_list_tile.dart';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class IndexTileDemo extends StatefulWidget {
  const IndexTileDemo({super.key});

  @override
  State<IndexTileDemo> createState() => _IndexTileDemoState();
}

class _IndexTileDemoState extends State<IndexTileDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Index List Tile Demo"),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(
            width: 220,
            child: IndexPageListTile(
              pageNo: 1,
              isBookMark: true,
              enrichCount: 10,
              linksCount: 5,
              notesCount: 2,
              hasDrawing: true,
              haveAnnotations: true,
            ),
          ),

          ///Second
          SizedBox(
            width: 220,
            child: IndexPageListTile(
              pageNo: 1,
              // isBookMark: true,
              enrichCount: 10,
              linksCount: 5,
              notesCount: 2,
              hasDrawing: true,
              haveAnnotations: true,
            ),
          ),

          ///#rd
          SizedBox(
            width: 220,
            child: IndexPageListTile(
              pageNo: 1,
              isBookMark: true,
              // enrichCount: 10,
              linksCount: 5,
              // notesCount: 2,
              hasDrawing: true,
              haveAnnotations: true,
            ),
          ),
        ],
      ),
    );
  }
}
