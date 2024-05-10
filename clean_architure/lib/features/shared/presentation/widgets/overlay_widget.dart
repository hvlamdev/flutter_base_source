import 'package:flutter/material.dart';

class OverlayWidget extends StatelessWidget {
  const OverlayWidget({
    super.key,
    required this.offset,
    required this.size,
    required this.child,
  });

  final Offset offset;
  final Size size;
  final double sharedButtonWidth = 120;
  final double bottomExtra = 100;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // The top position of the overlay widget
    // This is calculated in ListView case
    var top = offset.dy + kToolbarHeight - 6;
    var left = offset.dx;

    if (top < 0) {
      top = 0;
    }

    var maxHeight = MediaQuery.of(context).size.height - top - bottomExtra;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              top: top,
              left: left,
              child: GestureDetector(
                onTap: () {}, // Prevent the tap event from being propagated to the parent widget
                child: Container(
                  width: size.width,
                  constraints: BoxConstraints(maxHeight: maxHeight),
                  child: child,
                ),
              ),
            ),
            Positioned(
              top: top + (size.height > maxHeight ? maxHeight : size.height),
              left: getSharedButtonLeft(left, context),
              child: MessageOptionMenu(
                label: "Action",
                sharedButtonWidth: sharedButtonWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double getSharedButtonLeft(double left, BuildContext context) {
    var leftPosition = left + size.width / 2 - sharedButtonWidth / 2;
    return left + sharedButtonWidth > MediaQuery.of(context).size.width
        ? MediaQuery.of(context).size.width - sharedButtonWidth
        : leftPosition;
  }
}

class MessageOptionMenu extends StatelessWidget {
  const MessageOptionMenu({
    super.key,
    this.onTap,
    required this.sharedButtonWidth,
    required this.label,
  });

  final VoidCallback? onTap;
  final double sharedButtonWidth;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              Icon(Icons.share, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 10),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
