// demo_home.dart

import 'c_slider_demo/c_slider_demo.dart';
import 'canvas_vertices_demo/canvas_vertices_demo.dart';
import 'clip_animation_demo.dart';
import 'colorful_loader/colorful_loader_Demo.dart';
import 'connected_nodes_demo/connected_nodes_demo.dart';
import 'decoration_editor.dart/decoration_editor_screen.dart';
import 'expanding_image_gallery/expanding_image_screen.dart';
import 'flow_demo/flow_demo_screen.dart';
import 'gesture_detector_behavior_demo/gesture_detector_demo_screen.dart';
import 'honey_comb_tiles/honey_comb_images_demo.dart';
import 'int_video_views/int_video_screen.dart';
import 'interactive__yt_video_demo/simple_yt_controls.dart';
import 'interactive_video_demo/interactive_video_demo.dart';
import 'mouse_clip_demo/animated_bezier_demo.dart';
import 'mouse_clip_demo/mouse_clip_screen.dart';
import 'pong_demo/pong_screen.dart';
import 'timings_editor_demo/timings_editor_screen.dart';
import 'web_demo/web_demo_screen.dart';
import 'package:flutter/material.dart';
import 'animated_switch_demo/animated_switch_screen.dart';
import 'audio_player_demo/audio_player_demo.dart';
import 'binary_tree_problems/btree_demo_screen.dart';
import 'binary_tree_problems/triangle_demo_screen.dart';
import 'comp_place_holder.dart';
import 'device_info_web/device_info_web_demo_screen.dart';
import 'dynamic_grid_demo/dynamic_grid_demo.dart';
import 'expandable_card_demo/expansion_card_screen.dart';
import 'filp_card_demo/flip_card_screen.dart';
import 'filter_element_tile_demo.dart/filter_element_screen.dart';
import 'filter_pages_banner_demo/filter_pages_banner_screen.dart';
import 'future_provider_demo/future_provider_demo.dart';
import 'graphx_fun_demo/graphx_fun_demo.dart';
import 'index_page_list_tile_demo/index_list_tile_screen.dart';
import 'inherited_widget_demo/inherited_widget_base_screen.dart';
import 'inherited_widget_variant_demo/inherited_widget_base_screen_variabt.dart';
import 'interactive__yt_video_demo/interactive_yt_video_screen.dart';
import 'interfaces_demo/vehicles_demo_screen.dart';
import 'isolate_bytes_demo/isolate_network_call_demo_screen.dart';
import 'isolates_demo/isolates_demo_screen.dart';
import 'particle_deflect_demo/particle_deflect_demo.dart';
import 'quill_custsomised_toolbar_demo/animations_screen.dart';
import 'quill_custsomised_toolbar_demo/matrix_transformation_demo.dart';
import 'quill_custsomised_toolbar_demo/quill_toolbar_screen.dart';
import 'rotaing_progress/rotating_progrss_screen.dart';
import 'rotating_card_demo/rotating_card_screen.dart';
import 'scale_demo/scale_demo_screen.dart';
import 'search_highlight_demo/search_highlight_screen.dart';
import 'selective_provider/custom_provider_demo.dart';
import 'shadow_demo.dart';
import 'sharingan_demo/sharingan_home.dart';
import 'sliver_demo/sliver_demo_screen.dart';
import 'state_notifier_demo/state_notifier_demo_screen.dart';
import 'stream_provider_demo/stream_provider_demo.dart';
import 'utils/default_appbar.dart';

class ComponentsHome extends StatefulWidget {
  const ComponentsHome({super.key});

  @override
  State<ComponentsHome> createState() => _ComponentsHomeState();
}

class _ComponentsHomeState extends State<ComponentsHome> {
  int selectedPage = 2;
  Map<String, dynamic> demoMap = {
    "Shadow Demo": const ShadowDemo(),
    "Flow Demo": const FlowDemo(),
    "Pong Demo": const PongDemo(),
    "Web Demo": const WebDemoScreen(),
    "Canvas Vertices Demo": const CanvasVerticesDemo(),
    "Aniamted Bezier Demo": const AnimatedBezierDemo(),
    "Particle Deflect Demo": const ParticleDeflectDemo(),
    "Mouse Clip Demo": const MouseClipScreen(),
    "Colorful Loader Demo": const ColorfulLoaderDemo(),
    "Connected Nodes Demo": const ConnectedNodesDemo(),
    "Graphx Fun Demo": const GraphxFunDemo(),
    "Animated Switch Demo": const AnimatedSwitchScreen(),
    "Honey Comb Layout Demo": const HoneyCombDemoScreen(),
    "Expanding On Hover Demo": const ExpandingImageGalleryScreen(),
    "Decoration Editor Demo": const DecoreationEditorScreen(),
    "Int Edit Views Demo": const IntVideoEditScreen(),
    "Duration Change View": const TimingsEditorScreen(),
    "Gesture Detector Demo": const GestureDetectorDemo(),
    "Comp Place Holder": const CompPlaceHolder(),
    "YT Controls": const SimpleYTControls(),
    "C Slider Demo": const CSliderDemo(),
    "Clip Anim Demo": const ClipAnimDemo(),
    "Interactive  Video Screen": const InteractiveVideoDemo(),
    "Interactive Youtube Video Screen": const InteractiveYTVideoScreen(),
    "Matrix Transformation demo": const MatrixTransformDemo(),
    "3d Animations Demo": const AnimationsDemoScreen(),
    "Quill Tool bar Demo": const QuillToolbarScreen(),
    "AudioPlayer Demo": const AudioPlayerDemo(),
    "TRIANGLE ART DEMO": const TriangleArtScreen(),
    "Tree Demo Screen": const TreeVisualizerScreen(),
    "Stream Provider Demo": const StreamProviderScreen(),
    "Future Provider Demo": const FutureProviderScreen(),
    "Iherited Widget Variant Demo": const InheritedWidgetVariantScreen(),
    "Iherited Widget Demo": const InheritedWidgetScreen(),
    "Sliver List Demo": const SliverDemoScreen(),
    /* "Network Isolate Demo": const IsolateBytesDemoScreen(), */ ///Android Not supported
    "Isolate Demo": const IsolateDemoScreen(),
    "Sharingan Demo": const SharinganHome(),
    "Expandanble Card": const ExpandableCardScreen(),
    "Dynamic Grid": const DynamicGridScreen(),
    "Filter Pages Banner": const FilterPagesBannerScreen(),
    "Filter Element Tile": const FilterElementScreen(),
    "Flip Card Demo": const FlipCardScreen(),
    "Rotating Progress Demo": const RotatingProgressScreen(),
    "Rotating Card Demo ": const RotatingCardScreen(),
    "Interfaces Demo ": const VehiclesDemoScreen(),
    "Index Tile Demo": const IndexTileDemo(),
    "Custom Provider DemoScreen": const CustomProviderDemoScreen(),
    "Search Highlight Demo": const SearchHighlightScreen(),
    "Scale Demo": const ScaleDemoScreen(),
    "Device Info Demo": const DeviceInfoWebDemoScreen(),
    "State Notifier Demo": StateNotiferDemoScreen(),
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
