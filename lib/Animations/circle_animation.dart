import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_observing/AppConstants/color.dart';

class Circule extends StatefulWidget {
 const Circule({super.key, required this.reverse});
  final bool reverse;

  @override
  State<Circule> createState() => _CirculeState();
}

class _CirculeState extends State<Circule> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _positionAnimation;
  late Animation<double> curvedaniamtion;
  late Animation<double> scaleaniamtion;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration:const Duration(milliseconds: 1300),
    );
    curvedaniamtion = CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutQuint);
    _positionAnimation =
        Tween<Offset>(begin: Offset.zero, end:const Offset(.5, -.32))
            .animate(curvedaniamtion);
    scaleaniamtion =
        Tween<double>(begin: 3, end: 1.95).animate(curvedaniamtion);
  }

  bool started = false;
  @override
  Widget build(BuildContext context) {
    if (widget.reverse) {
      Future.delayed(
          const Duration(
            milliseconds: 200,
          ), () {
        _animationController.reverse();
        started = false;
        setState(() {});
      });
    } else {
      Future.delayed(
          const Duration(
            milliseconds: 200,
          ), () {
        _animationController.forward();
        started = true;
        setState(() {});
      });
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AnimatedBuilder(
          animation: curvedaniamtion,
          builder: (context, child) {
            return Transform.scale(
              scale: scaleaniamtion.value,
              child: FractionalTranslation(
                translation: _positionAnimation.value,
                child: AnimatedContainer(
                  alignment: Alignment.topRight,
                  curve: Curves.easeInCubic,
                  height: Get.height,
                  width: Get.width,
                  duration: const Duration(milliseconds: 1300),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.circular(started ? 300 : 0),
                      color: started
                          ? MyColor.blue
                          :const Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            );
          }),
    );
  }
}
