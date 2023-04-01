import 'package:flutter/material.dart';
import 'package:patient_observing/AppConstants/color.dart';

class MyTextFeild extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final Widget icon;
  final TextInputType texttype;
  final bool issecure;
  final Color color;
  final String? Function(String?)? validate;
  String? Function(String?)? onchage;

  MyTextFeild(
      {
        this.color =MyColor.orange,
        this.onchage,
      required this.textController,
      required this.hintText,
      Key? key,
      required this.icon,
      required this.validate,
      this.texttype = TextInputType.text,
      this.issecure = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: const Offset(7, 19),
              blurRadius: 40,
              spreadRadius: 0,
              color: const Color.fromARGB(255, 61, 61, 61).withOpacity(.1)),
        ]),
        child: TextFormField(
          validator: validate,
          controller: textController,
          onChanged: onchage ?? (value) {},
          obscureText: issecure,
          keyboardType: texttype,
          decoration: InputDecoration(
            prefixIcon: icon,
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: .8),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: color, width: .8),
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            ),
          ),
        ),
      ),
    );
  }
}
