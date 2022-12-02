import 'dart:async';
import 'dart:collection';

import 'dart:io';

import 'package:components_demo/utils/default_appbar.dart';

import 'package:flutter/material.dart';

const List<String> staticImages = [
  'https://cdn.pixabay.com/photo/2013/02/01/18/14/url-77169__340.jpg',
  'https://cdn.pixabay.com/photo/2020/09/19/19/37/landscape-5585247__340.jpg',
  'https://cdn.pixabay.com/photo/2013/03/01/18/40/crispus-87928__340.jpg',
  'https://cdn.pixabay.com/photo/2013/03/01/18/40/crispus-87928__340.jpg',
  'https://cdn.pixabay.com/photo/2016/03/08/20/03/flag-1244648__340.jpg',
  'https://cdn.pixabay.com/photo/2015/09/30/01/48/turkey-964831__340.jpg',
  'https://cdn.pixabay.com/photo/2017/01/28/17/43/fish-2016013__340.jpg',
  'https://media.istockphoto.com/id/973139084/photo/man-hands-using-online-banking-and-icon-on-tablet-screen-device-in-coffee-shop-technology-e.jpg?b=1&s=170667a&w=0&k=20&c=2q3XDOLiLSwTAC-zyxHm7BCs9EtejOe0RH1nJ3juAVA=',
  'https://cdn.pixabay.com/photo/2018/04/26/16/39/beach-3352363__340.jpg',
  'https://cdn.pixabay.com/photo/2018/04/26/16/31/marine-3352341__340.jpg',
];

class DynamicGridScreen extends StatefulWidget {
  const DynamicGridScreen({super.key});

  @override
  State<DynamicGridScreen> createState() => _DynamicGridScreenState();
}

class _DynamicGridScreenState extends State<DynamicGridScreen> {
  List<String> _imagesList = [];

  TextEditingController _copyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Dynamic Grid Demo"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
              flex: 5,
              fit: FlexFit.tight,
              child: DyanamicGridView(
                source: UnmodifiableListView(_imagesList),
              )),
          Flexible(
              child: Center(
            child: Text("Displaying ${_imagesList.length} images"),
          ))
        ],
      ),
      floatingActionButton: InkWell(
        onTap: showCopyDialog,
        onLongPress: addImageToList,
        child: Icon(Icons.add),
      ),
    );
  }

  void addImageToList() {
    if (_imagesList.length == staticImages.length) return;
    _imagesList.add(staticImages[_imagesList.length]);
    setState(() {});
  }

  void showCopyDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "CopyLabel",
      barrierColor: Colors.grey.withAlpha(100),
      pageBuilder: (context, animation, secondaryAnimation) => Center(
        child: Card(
          child: SizedBox(
            height: 200,
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(3.0), border: Border.all(color: Colors.grey)),
                  margin: EdgeInsets.all(
                    3.0,
                  ),
                  child: TextField(
                    controller: _copyController,
                  ),
                ),
                ElevatedButton(onPressed: addCopiedText, child: Text("Add"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addCopiedText() {
    String text = _copyController.text;
    if (text.isNotEmpty) {
      _imagesList.add(text);
      setState(() {});
    }
    Navigator.pop(context);
  }
}

class DyanamicGridView extends StatelessWidget {
  final UnmodifiableListView<String> source;
  const DyanamicGridView({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    List<Future<Size>> _nSizes = [];
    source.forEach((element) {
      _nSizes.add(_calculateImageDimension(element));
    });

    return LayoutBuilder(
      builder: (context, konstraints) => FutureBuilder<List<Size>>(
        future: Future.wait(_nSizes),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Icon(Icons.error),
            );
          } else {
            List<String> initImages = [];
            List<String> remainingImages = [];
            int remainder = source.length % 3;
            if (remainder != 0) {
              initImages.addAll(source.getRange(source.length - remainder, source.length));
              remainingImages.addAll(source.getRange(0, source.length - remainder));
            } else {
              remainingImages.addAll(source);
            }
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (initImages.isNotEmpty)
                    Container(
                      constraints: initImages.length == 1
                          ? BoxConstraints.loose(Size(1024, 500))
                          : BoxConstraints.expand(height: 200),
                      height: initImages.length == 1
                          ? (snapshot.data![source.indexOf(initImages.first)].width * konstraints.maxWidth) /
                              snapshot.data![source.indexOf(initImages.first)].height
                          : null,
                      width: konstraints.maxWidth,
                      child: initImages.length == 1
                          ? Image.network(
                              initImages.first,
                              fit: BoxFit.fill,
                            )
                          : Flex(
                              direction: Axis.horizontal,
                              children: initImages
                                  .map((e) => Flexible(
                                      flex: snapshot.data![source.indexOf(e)].width.toInt(),
                                      fit: FlexFit.tight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Image.network(
                                          e,
                                          fit: BoxFit.fill,
                                        ),
                                      )))
                                  .toList(),
                            ),
                    ),
                  ListView.builder(
                    itemCount: remainingImages.length ~/ 3,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      int start = 3 * index;
                      int end = start + 3;
                      List<String> items = remainingImages.getRange(start, end).toList();
                      return Container(
                        constraints: BoxConstraints.expand(height: 200),
                        margin: EdgeInsets.only(bottom: 3.0),
                        child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: items
                              .map((e) => Flexible(
                                  flex: snapshot.data![source.indexOf(e)].width.toInt(),
                                  fit: FlexFit.tight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Image.network(
                                      e,
                                      fit: BoxFit.fill,
                                    ),
                                  )))
                              .toList(),
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<Size> _calculateImageDimension(String url) {
    Completer<Size> completer = Completer();
    Image image;
    UriData? _uriData = Uri.parse(url).data;
    if (url.contains('http')) {
      image = Image.network(url);
    } else if (_uriData?.isBase64 ?? false) {
      image = Image.memory(_uriData!.contentAsBytes());
    } else {
      image = Image.file(File(url));
    }
    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(size);
        },
      ),
    );
    return completer.future;
  }

  // return GridView.builder(
  //     itemCount: source.length,
  //     gridDelegate:
  //         SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
  //     itemBuilder: (context, index) {
  //       return Image.network(source[index]);
  //     });
}
