import 'package:flutter/material.dart';

class AnimatedOpacityAndPosition extends StatefulWidget {
  final Widget? child;
  final Offset offset;
  final Duration delayduration;
  final Duration duration;
  final bool withopacty;
  final double scale;
  final Curve? curve;
  final bool reverse;
  const AnimatedOpacityAndPosition({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    required this.delayduration,
    required this.withopacty,
    required this.offset,
    required this.scale,
    this.curve = Curves.easeInCubic,
    this.reverse = false,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedOpacityAndPositionState createState() =>
      _AnimatedOpacityAndPositionState();
}

class _AnimatedOpacityAndPositionState extends State<AnimatedOpacityAndPosition>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _positionAnimation;
  late Animation<double> curvedaniamtion;
  late Animation<double> scale;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    curvedaniamtion =
        CurvedAnimation(parent: _animationController, curve: widget.curve!);
    _opacityAnimation = Tween<double>(begin: widget.withopacty ? 0 : 1, end: 1)
        .animate(curvedaniamtion);

    scale = Tween<double>(begin: widget.scale, end: 1).animate(curvedaniamtion);
    _positionAnimation = Tween<Offset>(begin: widget.offset, end: Offset.zero)
        .animate(curvedaniamtion);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.reverse) {
      Future.delayed(widget.delayduration, () {
        _animationController.reverse();
      });
    } else {
      Future.delayed(widget.delayduration, () {
        _animationController.forward();
      });
    }
    return AnimatedBuilder(
      animation: curvedaniamtion,
      builder: (context, child) {
        return Transform.scale(
          scale: scale.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: FractionalTranslation(
              translation: _positionAnimation.value,
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}
