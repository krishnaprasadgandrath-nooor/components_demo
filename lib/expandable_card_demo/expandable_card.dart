// expandable_card.dart

import 'package:flutter/material.dart';

class ExpandableCard extends StatefulWidget {
  final String title;
  final Widget trailing;
  final Duration? animDuration;
  final BoxConstraints constraints;
  final EdgeInsets childPadding;

  final List<Widget> children;
  const ExpandableCard({
    super.key,
    required this.title,
    this.children = const [],
    this.trailing = const Icon(Icons.downhill_skiing),
    this.constraints = const BoxConstraints(minHeight: 50, maxHeight: 500),
    this.childPadding = const EdgeInsets.all(8.0),
    this.animDuration,
  });

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> with TickerProviderStateMixin {
  late final Duration _animDuration = widget.animDuration ?? kThemeAnimationDuration;
  late final AnimationController _animController = AnimationController(vsync: this, duration: _animDuration * 2);
  late final Animation<double> _expandAnimation =
      Tween<double>(begin: 0.0, end: 0.5).animate(CurvedAnimation(parent: _animController, curve: Curves.easeIn));
  late final Animation<double> _sizeAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animController, curve: Curves.easeIn));

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: _animDuration,
      alignment: Alignment.topCenter,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: toggleExpansion,
              child: Row(
                children: [
                  Text(widget.title),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: RotationTransition(
                        turns: _expandAnimation,
                        child: widget.trailing,
                      ))
                ],
              ),
            ),
            SizeTransition(
                sizeFactor: _sizeAnimation,
                child: _isExpanded
                    ? Padding(
                        padding: widget.childPadding,
                        child: ConstrainedBox(
                          constraints: widget.constraints,
                          child: SingleChildScrollView(
                            child: Column(children: widget.children),
                          ),
                        ),
                      )
                    : Container())
          ],
        ),
      ),
    );
  }

  void toggleExpansion() {
    if (_isExpanded) {
      _animController.reverse().whenComplete(() {
        _isExpanded = false;
        setState(() {});
      });
    } else {
      _animController.forward();
      _isExpanded = true;
    }
    setState(() {});
  }
}
