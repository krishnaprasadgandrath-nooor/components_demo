import 'package:flutter/material.dart';

class CActionButton extends StatefulWidget {
  const CActionButton({
    super.key,
    required this.child,
    required this.onClick,
  });

  final Widget child;
  final void Function() onClick;

  @override
  State<CActionButton> createState() => _CActionButtonState();
}

class _CActionButtonState extends State<CActionButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Card(
        color: const Color(0xFF86009e),
        margin: const EdgeInsets.all(3.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: widget.child,
      ),
    );
  }
}
