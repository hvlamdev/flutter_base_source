import 'package:flutter/material.dart';

class FloatingActionButtonCustom extends StatefulWidget {
  const FloatingActionButtonCustom({
    super.key,
    this.toolTip,
    this.onTap,
    this.icon,
    this.radius = 50,
    this.animatedIconData,
    this.enabled = true,
    this.iconSize = 30,
    this.backgroundColor = Colors.blue,
    this.disabledColor = Colors.grey,
  }) : assert((icon != null && animatedIconData == null) || (icon == null && animatedIconData != null));

  final String? toolTip;
  final Function()? onTap;
  final IconData? icon;
  final double iconSize;
  final AnimatedIconData? animatedIconData;
  final double radius;
  final bool enabled;
  final Color? backgroundColor;
  final Color? disabledColor;

  @override
  State<FloatingActionButtonCustom> createState() => FloatingActionButtonCustomState();
}

class FloatingActionButtonCustomState extends State<FloatingActionButtonCustom> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool isForward = false;

  @override
  void initState() {
    super.initState();
    if (widget.animatedIconData != null) {
      controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
      animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    }
  }

  @override
  void dispose() {
    if (widget.animatedIconData != null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.radius * 2,
      height: widget.radius * 2,
      child: FloatingActionButton(
        backgroundColor: widget.enabled ? widget.backgroundColor : widget.disabledColor,
        onPressed: () => onTap(),
        tooltip: widget.toolTip,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(widget.radius))),
        child: getIcon(context),
      ),
    );
  }

  Widget getIcon(BuildContext context) {
    if (widget.icon != null) {
      return Icon(widget.icon, size: widget.iconSize, color: Colors.white);
    }
    return AnimatedIcon(
      icon: widget.animatedIconData!,
      progress: animation,
      size: widget.iconSize,
      color: Colors.white,
    );
  }

  void onTap() {
    if (!widget.enabled) return;

    if (widget.animatedIconData != null) {
      if (isForward) {
        reverse();
      } else {
        forward();
      }
    }
    widget.onTap?.call();
  }

  void reverse() {
    controller.reverse();
    isForward = !isForward;
  }

  void forward() {
    controller.forward();
    isForward = !isForward;
  }
}
