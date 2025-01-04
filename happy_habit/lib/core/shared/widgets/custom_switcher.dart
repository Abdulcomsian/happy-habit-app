import 'package:flutter/material.dart';

enum SwitcherTransition {
  sizeTransition,
  scaleTransition,
}

class CustomSwitcher extends StatelessWidget {
  final Widget child;
  final SwitcherTransition? transition;

  const CustomSwitcher({
    super.key,
    this.transition,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        switch (transition) {
          case SwitcherTransition.sizeTransition:
            return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                child: child,
              ),
            );
          case SwitcherTransition.scaleTransition:
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
          default:
            return FadeTransition(
              opacity: animation,
              child: child,
            );
        }
      },
      child: child,
    );
  }
}
