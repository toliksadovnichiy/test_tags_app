import 'package:flutter/material.dart';

class GridItem extends StatefulWidget {
  final int index;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? parentMaxHeight;
  bool isWidgetInvisible;
  final Function(int) onCallback;

  GridItem({
    Key? key,
    required this.text,
    required this.index,
    required this.onCallback,
    this.parentMaxHeight,
    this.backgroundColor,
    this.textColor,
    this.isWidgetInvisible = false,
  }) : super(key: key);

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  @override
  Widget build(BuildContext context) {
    checkOutOfBoundsPostFrame();

    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.teal,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.text,
              style: TextStyle(
                color: widget.textColor ?? Colors.white,
                fontSize: 14,
              )),
        ],
      ),
    );
  }

  void checkOutOfBoundsPostFrame() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        RenderBox box = context.findRenderObject() as RenderBox;
        Offset bottomRightPosition =
        box.localToGlobal(box.size.bottomRight(Offset.zero));
        double yPosition = bottomRightPosition.dy;
        widget.isWidgetInvisible =
            yPosition > (widget.parentMaxHeight ?? MediaQuery.of(context).size.height * 0.95);
        widget.isWidgetInvisible ? widget.onCallback(widget.index) : () {};
      }
    });
  }
}
