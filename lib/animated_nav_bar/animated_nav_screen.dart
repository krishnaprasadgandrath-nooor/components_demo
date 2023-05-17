import 'package:flutter/material.dart';

import '../utils/default_appbar.dart';
import 'anim_nav_bar.dart';

class AnimatedNavScreen extends StatelessWidget {
  const AnimatedNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(
        context,
        'AnimatedNavScreen',
      ),
      backgroundColor: const Color.fromARGB(255, 228, 159, 159),
      bottomNavigationBar: const AnimatedBottomNavBar(),
    );
  }
}
