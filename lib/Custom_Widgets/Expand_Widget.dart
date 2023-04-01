import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_widget_cache.dart';
import 'dart:math';

import 'package:patient_observing/AppConstants/color.dart';

class ExpandWidget extends StatefulWidget {
  Widget child;
  Widget title;
  Color color;
  EdgeInsets padding;
  ExpandWidget(
      {super.key,
      required this.child,
      required this.color,
      required this.title,
      required this.padding});

  @override
  State<ExpandWidget> createState() => _ExpandWidgetState();
}

class _ExpandWidgetState extends State<ExpandWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> rotate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    rotate = Tween<double>(begin: 1, end: 2).animate(_animationController);
  }

  bool isexpand = false;
  bool isexpand2 = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: widget.padding,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 255, 255, 255),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(7, 19),
                    blurRadius: 40,
                    spreadRadius: 0,
                    color:
                        const Color.fromARGB(255, 61, 61, 61).withOpacity(.1)),
              ]),
          child: Container(
            child: ListTile(
              onTap: () {
                isexpand2 = !isexpand2;
                setState(() {});
                if (isexpand) {
                  _animationController.reverse();
                } else {
                  _animationController.forward();
                }
                Future.delayed(Duration(milliseconds: !isexpand ? 0 : 400))
                    .then((value) {
                  isexpand = !isexpand;
                  setState(() {});
                });
              },
              title: widget.title,
              trailing: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.rotate(
                        angle: pi * rotate.value,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isexpand
                                  ? widget.color
                                  : Color.fromARGB(255, 239, 239, 239)),
                          child: Icon(
                            Icons.expand_more,
                            color: isexpand ? Colors.white : Colors.black,
                            size: Get.height / 30,
                          ),
                        ));
                  }),
            ),
          ),
        ),
        Visibility(
            visible: isexpand,
            maintainState: true,
            child: AnimatedOpacity(
                duration: Duration(milliseconds: 400),
                opacity: isexpand2 ? 1 : 0,
                child: widget.child))
      ],
    );
  }
}
