// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_observing/AppConstants/color.dart';
import 'package:velocity_x/velocity_x.dart';

class GradientButtonFb4 extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const GradientButtonFb4(
      {required this.text, required this.onPressed, Key? key})
      : super(key: key);

  final double borderRadius = 30;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: Get.width / 10),
          height: Get.height / 16,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              gradient: LinearGradient(
                  colors: [MyColor.green1.withBlue(150), MyColor.orange])),
        ).shimmer(
            primaryColor: MyColor.orange,
            duration: const Duration(milliseconds: 3200),
            secondaryColor: MyColor.green1.withBlue(150)),
        SizedBox(
          height: Get.height / 18,
          child: Center(
            child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.only(
                        right: Get.width / 7,
                        left: Get.width / 7,
                      ),
                    ),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius)),
                    )),
                onPressed: onPressed,
                child: Text(
                  text,
                  style:
                      TextStyle(color: Colors.white, fontSize: Get.height / 35),
                )),
          ),
        ),
      ],
    );
  }
}
