import 'package:flutter/material.dart';

class BlinkingContainer extends StatefulWidget {
  final Widget child;
  final int duration;

  const BlinkingContainer({
    required this.child,
    this.duration = 500,
    Key? key,
  }) : super(key: key);

  @override
  State<BlinkingContainer> createState() => _BlinkingContainerState();
}

class _BlinkingContainerState extends State<BlinkingContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacity;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );

    opacity = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.linear),
    );

    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: opacity, child: widget.child);
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }
}
