import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';

import 'package:components_demo/utils/default_appbar.dart';

const placeHolderText =
    '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.

Why do we use it?
It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).


Where does it come from?
Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.''';

class WebDemoScreen extends StatefulWidget {
  const WebDemoScreen({super.key});

  @override
  State<WebDemoScreen> createState() => _WebDemoScreenState();
}

class _WebDemoScreenState extends State<WebDemoScreen> {
  // Rect imageRect = Rect.fromCenter(center: Offset.zero, width: 200, height: 200);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Web Demo"),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) => const WebComponent(),
      ),
    );
  }
}

class WebComponent extends StatefulWidget {
  const WebComponent({
    super.key,
  });

  @override
  State<WebComponent> createState() => _WebComponentState();
}

class _WebComponentState extends State<WebComponent> {
  final Signal mouseExitSignal = Signal();
  /* final EventSignal<Rect> imagePosSignal = EventSignal<Rect>(); */
  Rect imageRect = Rect.zero;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipBehavior: Clip.hardEdge,
      child: SceneBuilderWidget(
        builder: () => SceneController(
            back: WebScene(
              mouseExitSignal, /* imagePosSignal */
            ),
            config: SceneConfig.interactive),
        child: MouseRegion(
          onExit: (event) {
            mouseExitSignal.dispatch();
          },
          child: SizedBox(
            height: 400.0,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ImageHolder(
                            updatePos: (rect) {
                              if (imageRect != rect) {
                                imageRect = rect;
                                /* Future.delayed(const Duration(seconds: 2), () => imagePosSignal.dispatch(imageRect)); */
                              }
                            },
                          )),
                    )),
                const Flexible(
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      placeHolderText,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageHolder extends StatefulWidget {
  final Function(Rect rect) updatePos;
  const ImageHolder({
    super.key,
    required this.updatePos,
  });

  @override
  State<ImageHolder> createState() => _ImageHolderState();
}

class _ImageHolderState extends State<ImageHolder> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => calculateAndUpdatePos());
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/modi.png');
  }

  void calculateAndUpdatePos() {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset boxOffset = box.globalToLocal(Offset.zero);
    Size boxSize = box.size;
    widget.updatePos(Rect.fromLTWH(boxOffset.dx, boxOffset.dy, boxSize.width, boxSize.height));
  }
}

class WebScene extends GSprite {
  final Signal mouseExitSignal;
  /* final EventSignal<Rect> imagePosSignal; */
  WebScene(
    this.mouseExitSignal,
    /* this.imagePosSignal */
  );

  late GShape bg;
  late GShape hover;
  late Rect imagePos =
      Rect.fromCenter(center: Offset((stageWidth / 2) - 100, stageHeight / 2), width: 100, height: 100);
  double hoverX = 0.0;
  double hoverY = 0.0;

  double get stageWidth => stage!.stageWidth;
  double get stageHeight => stage!.stageHeight;
  late double hoverRadius = stageHeight * 2;
  final twn = 0.0.twn;

  @override
  void addedToStage() {
    mouseExitSignal.add(moveBackToImage);

    mouseChildren = true;
    initUi();
    super.addedToStage();
    onMouseMove.add((event) => updatePosition());
  }

  @override
  void update(double delta) {
    hover.x = hoverX;
    hover.y = hoverY;
    super.update(delta);
  }

  void initUi() {
    bg = GShape();
    bg.x = 0;
    bg.y = 0;
    final bGrx = bg.graphics;
    bGrx.beginFill(Colors.black).drawRect(0, 0, stageWidth, stageHeight).endFill();

    hover = GShape();
    hover.graphics.beginFill(Colors.orangeAccent.withAlpha(100)).drawCircle(0, 0, hoverRadius / 4).endFill();
    // hover.graphics.beginFill(Colors.orange.withAlpha(100)).drawCircle(0, 0, hoverRadius / 6).endFill();
    hover.graphics.beginFill(Colors.orange.withAlpha(100)).drawCircle(0, 0, hoverRadius / 6).endFill();
    // hover.graphics.beginFill(Colors.orange.withAlpha(100)).drawCircle(0, 0, hoverRadius / 16).endFill();
    hover.graphics.beginFill(Colors.deepOrangeAccent.withAlpha(100)).drawCircle(0, 0, hoverRadius / 10).endFill();
    hover.graphics.beginFill(Colors.deepOrange.withAlpha(100)).drawCircle(0, 0, hoverRadius / 20).endFill();
    hover.filters = [GBlurFilter(30.0, 30.0)];

    addChild(bg);
    addChild(hover);
  }

  void updatePosition() {
    GTween.killTweensOf(this);
    hoverX = mouseX;
    hoverY = mouseY;
  }

  void moveBackToImage() {
    twn.tween(1.0, duration: 2, onUpdate: () {
      hoverX = hoverX * (1 - twn.value) + imagePos.center.dx * twn.value;
      hoverY = hoverY * (1 - twn.value) + imagePos.center.dy * twn.value;
    }, onComplete: () {
      twn.value = 0;
    });
  }
}
