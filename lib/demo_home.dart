// demo_home.dart

import 'package:components_demo/dynamic_grid_demo/dynamic_grid_demo.dart';

import 'package:components_demo/expandable_card_demo/expansion_card_screen.dart';
import 'package:components_demo/filp_card_demo/flip_card_screen.dart';
import 'package:components_demo/filter_element_tile_demo.dart/filter_element_screen.dart';
import 'package:components_demo/rotaing_progress/rotating_progrss_screen.dart';
import 'package:components_demo/rotating_card_demo/rotating_card_screen.dart';
import 'package:components_demo/sharingan_demo/sharingan_home.dart';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

import 'filter_pages_banner_demo/filter_pages_banner_screen.dart';

class ComponentsHome extends StatefulWidget {
  const ComponentsHome({super.key});

  @override
  State<ComponentsHome> createState() => _ComponentsHomeState();
}

class _ComponentsHomeState extends State<ComponentsHome> {
  int selectedPage = 2;
  Map<String, dynamic> demoMap = {
    "Sharingan Demo": const SharinganHome(),
    "Expandanble Card": const ExpandableCardScreen(),
    "Dynamic Grid": const DynamicGridScreen(),
    "Filter Pages Banner": const FilterPagesBannerScreen(),
    "Filter Element Tile": const FilterElementScreen(),
    "Flip Card Demo": const FlipCardScreen(),
    "Rotating Progress Demo": const RotatingProgressScreen(),
    "Rotating Card Demo ": const RotatingCardScreen()
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar.appBar(context, "Components Demo", noLeading: true),
        body: ListView.builder(
            itemCount: demoMap.length,
            itemBuilder: (context, index) {
              MapEntry item = demoMap.entries.toList()[index];
              return ListTile(
                title: Text(item.key),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => item.value)),
              );
            }));
  }
}




///Filter Elements tile demo
    //Column(
    //   children: [1, 2, 3]
    //       .map((e) => Column(
    //             children: [
    //               FilterElementTile(
    //                 icon: e == 1 ? Icons.abc : null,
    //                 padding: EdgeInsets.zero,
    //                 title: Text("Title $e"),
    //                 trailing: Text("Go To", style: TextStyle(color: Colors.blue)),
    //                 author: Text("Krishna"),
    //                 showAuthor: e == 2 ? false : true,
    //               ),
    //               if (e != 3)
    //                 Divider(
    //                   indent: 5.0,
    //                   endIndent: 5.0,
    //                 )
    //             ],
    //           ))
    //       .toList(),
    // )