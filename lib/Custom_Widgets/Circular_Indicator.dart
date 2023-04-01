// ignore: file_names
import 'package:flutter/material.dart';
import 'dart:math';

class CircularIndicator extends StatefulWidget {
  final double padding;
  final double max;
  final double min;
  final double input;
  final String sign;
  final String title;
  getpercentage() {
    double range = max - min;
    double correctedstartvalue = input - min;
    double percentage = (correctedstartvalue * 100) / range;
    return percentage;
  }

  const CircularIndicator({
    super.key,
    required this.padding,
    required this.max,
    required this.min,
    required this.input,
    required this.sign,
    required this.title,
  });
  @override
  _CircularIndicator createState() => _CircularIndicator();
}

class _CircularIndicator extends State<CircularIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation1;
  late Animation<double> _animation2;

  double _oldPercentage = 10;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    _animation1 =
        Tween<double>(begin: _oldPercentage, end: widget.getpercentage())
            .animate(_animationController);
    _animationController.forward();
    _animation1.addListener(() {
      setState(() {});
    });
    _animation2 = Tween<double>(begin: _oldPercentage, end: widget.input)
        .animate(_animationController);
    _animationController.forward();
    _animation2.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(CircularIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.getpercentage() != widget.getpercentage()) {
      _oldPercentage = oldWidget.getpercentage();

      _animation1 =
          Tween<double>(begin: _oldPercentage, end: widget.getpercentage())
              .animate(_animationController);

      _animationController.reset();
      _animationController.forward();
      _animation2 = Tween<double>(begin: _oldPercentage, end: widget.input)
          .animate(_animationController);

      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double getthehu(percent) {
    if (_animation1.value > 50) {
      if (_animation1.value - 50 >= 0) {
        return 100.toDouble() - _animation1.value + 10;
      }
      return 0;
    }
    if (_animation1.value + _animation1.value - 30 >= 0) {
      return _animation1.value + _animation1.value - 30;
    }
    return 0;
  }

  reverseOperation(insertedvalue, maxvalue, percent) {
    double value = insertedvalue - maxvalue;
    if (percent <= value) {
      return value - percent;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CirclePainter(
          _animation1.value, widget.input, getthehu(widget.getpercentage())),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: widget.padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${widget.sign} ',
                style: const TextStyle(fontSize: 18.0),
              ),
              Text(
                ' ${_animation2.value.toInt()} ',
                style: const TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  final double percentage;
  final double inputvalue;
  final double myhue;

  _CirclePainter(this.percentage, this.inputvalue, this.myhue);

  Color _getColorFromPercentage(double percentage) {
    // final hue = (120 * percentage / 100).round();
    return HSVColor.fromAHSV(1.0, myhue + 20, 1.0, 1.0).toColor();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    final arcAngle = 3 * pi / 2 * (percentage / 100);

    final activePaint = Paint()
      ..color = _getColorFromPercentage(percentage)
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final inactivePaint = Paint()
      ..color = Color.fromARGB(255, 218, 218, 218)
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 4,
        arcAngle, false, activePaint);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        arcAngle - pi / 4, 3 * pi / 2 - arcAngle, false, inactivePaint);
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) {
    return oldDelegate.percentage != percentage;
  }
}
