// q_line_height_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

Map<String, String> lineHeights = {"1": "1", "2": "2", "3": "3"};

class QLineHeightButton extends StatelessWidget {
  final QuillController controller;
  const QLineHeightButton(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return QuillLineHeightButton(
      items: lineHeights.entries
          .map(
            (e) => PopupMenuItem<String>(
              key: ValueKey(e.key),
              value: e.value,
              child: Text(e.key.toString(), style: TextStyle(color: e.value == '0' ? Colors.red : null)),
            ),
          )
          .toList(),
      rawItemsMap: lineHeights,
      attribute: Attribute.height,
      controller: controller,
      onSelected: (newHeight) {
        controller
            .formatSelection(Attribute.fromKeyValue('height', newHeight == '0' ? null : null /*getFontSize(newSize)*/));
      },
    );
  }
}

class QuillLineHeightButton extends StatefulWidget {
  const QuillLineHeightButton({
    required this.items,
    required this.rawItemsMap,
    required this.attribute,
    required this.controller,
    required this.onSelected,
    this.iconSize = 40,
    this.fillColor,
    this.hoverElevation = 1,
    this.highlightElevation = 1,
    this.iconTheme,
    this.afterButtonPressed,
    Key? key,
  }) : super(key: key);

  final double iconSize;
  final Color? fillColor;
  final double hoverElevation;
  final double highlightElevation;
  final List<PopupMenuEntry<String>> items;
  final Map<String, String> rawItemsMap;
  final ValueChanged<String> onSelected;
  final QuillIconTheme? iconTheme;
  final Attribute attribute;
  final QuillController controller;
  final VoidCallback? afterButtonPressed;

  @override
  _QuillLineHeightButtonState createState() => _QuillLineHeightButtonState();
}

class _QuillLineHeightButtonState extends State<QuillLineHeightButton> {
  late String _defaultDisplayText;
  late String _currentValue;
  Style get _selectionStyle => widget.controller.getSelectionStyle();

  @override
  void initState() {
    super.initState();
    _currentValue = _defaultDisplayText = 'Line height';
    widget.controller.addListener(_didChangeEditingValue);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_didChangeEditingValue);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant QuillLineHeightButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_didChangeEditingValue);
      widget.controller.addListener(_didChangeEditingValue);
    }
  }

  void _didChangeEditingValue() {
    final attribute = _selectionStyle.attributes[widget.attribute.key];
    if (attribute == null) {
      setState(() => _currentValue = _defaultDisplayText);
      return;
    }
    final keyName = _getKeyName(attribute.value);
    setState(() => _currentValue = keyName ?? _defaultDisplayText);
  }

  String? _getKeyName(dynamic value) {
    for (final entry in widget.rawItemsMap.entries) {
      if (getLineHeight(entry.value) == getLineHeight(value)) {
        return entry.key;
      }
    }
    return null;
  }

  getLineHeight(String value) {}

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: widget.iconSize * 1.81),
      child: RawMaterialButton(
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.iconTheme?.borderRadius ?? 2)),
        fillColor: widget.fillColor,
        elevation: 0,
        hoverElevation: widget.hoverElevation,
        highlightElevation: widget.hoverElevation,
        onPressed: () {
          _showMenu();
          widget.afterButtonPressed?.call();
        },
        child: _buildContent(context),
      ),
    );
  }

  void _showMenu() {
    final popupMenuTheme = PopupMenuTheme.of(context);
    final button = context.findRenderObject() as RenderBox;
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomLeft(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    showMenu<String>(
      context: context,
      elevation: 4,
      items: widget.items,
      position: position,
      shape: popupMenuTheme.shape,
      color: popupMenuTheme.color,
    ).then((newValue) {
      if (!mounted) return;
      if (newValue == null) {
        return;
      }
      final keyName = _getKeyName(newValue);
      setState(() {
        _currentValue = keyName ?? _defaultDisplayText;
        if (keyName != null) {
          widget.onSelected(newValue);
        }
      });
    });
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_currentValue,
              style: TextStyle(
                  fontSize: widget.iconSize / 1.15,
                  color: widget.iconTheme?.iconUnselectedColor ?? theme.iconTheme.color)),
          const SizedBox(width: 3),
          Icon(Icons.arrow_drop_down,
              size: widget.iconSize / 1.15, color: widget.iconTheme?.iconUnselectedColor ?? theme.iconTheme.color)
        ],
      ),
    );
  }
}
