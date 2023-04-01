import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:patient_observing/Animations/animating_widgets.dart';
import 'package:patient_observing/AppConstants/color.dart';
import 'package:patient_observing/AppConstants/strings.dart';
import 'package:patient_observing/Firebase/doctors_FireBase.dart';
import 'package:patient_observing/Firebase/nurse_FireBase.dart';
import 'package:patient_observing/Screens/Registration/Sign_Up/SignUp_ModelVeiw.dart';
import '../../../Animations/circle_animation.dart';
import '../../../AppConstants/variables.dart';
import '../../../Custom_Widgets/Button.dart';
import '../../../Custom_Widgets/Textfeild.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  String radiogroup = "";
  final SignUpModelVeiw _controller = SignUpModelVeiw(
      doctorRepository: DoctorsFromFirebase(local: Variables.fromLocal),
      nurseRepository: NurseFromFirebase(local: Variables.fromLocal));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            Circule(
              reverse: false,
            ),
            SizedBox(
              height: Get.height,
              child: Form(
                key: formstate,
                child: ListView(children: [
                  SizedBox(
                    height: Get.height / 9,
                  ),
                  Padding(
                    // padding: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.only(right: 20, left: 20),

                    child: AnimatedOpacityAndPosition(
                      scale: 1,
                      delayduration: Duration(milliseconds: 1200),
                      offset: Offset.zero,
                      withopacty: true,
                      child: Text(
                        _controller.pagetitle,
                        style: TextStyle(
                          fontSize: Get.height / 26,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    width: Get.width / 2,
                    child: AnimatedOpacityAndPosition(
                      scale: 1,
                      delayduration: Duration(milliseconds: 1200),
                      offset: Offset(.1, 0),
                      withopacty: true,
                      child: Text(
                        Strings.note,
                        maxLines: 2,
                        style: TextStyle(
                          color: MyColor.grey,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 17,
                  ),
                  Padding(
                    // padding: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.only(right: 20, left: 20),

                    child: AnimatedOpacityAndPosition(
                      scale: 1,
                      delayduration: Duration(milliseconds: 1700),
                      offset: Offset(0, .1),
                      withopacty: true,
                      duration: Duration(milliseconds: 500),
                      child: MyTextFeild(
                          icon: Icon(
                            Icons.person,
                            color: MyColor.orange,
                          ),
                          hintText: _controller.realhint,
                          textController: name,
                          validate: _controller.nameValidation),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: AnimatedOpacityAndPosition(
                      scale: 1,
                      duration: const Duration(milliseconds: 500),
                      delayduration: const Duration(milliseconds: 2100),
                      offset: Offset(0, .1),
                      withopacty: true,
                      child: MyTextFeild(
                        validate: _controller.userNameValidation,
                        icon: Icon(
                          Icons.person,
                          color: MyColor.orange,
                        ),
                        hintText: _controller.username,
                        textController: username,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: AnimatedOpacityAndPosition(
                      scale: 1,
                      duration: const Duration(milliseconds: 500),
                      delayduration: const Duration(milliseconds: 2650),
                      offset: const Offset(0, .1),
                      withopacty: true,
                      child: MyTextFeild(
                        validate: (value) {
                          return null;
                        },
                        icon: Icon(
                          Icons.lock,
                          color: MyColor.orange,
                        ),
                        hintText: _controller.passwrod,
                        textController: password,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 19,
                  ),
                  Padding(
                    // padding: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.only(right: 20, left: 20),

                    child: AnimatedOpacityAndPosition(
                      scale: 1,
                      duration: const Duration(milliseconds: 500),
                      delayduration: const Duration(milliseconds: 3000),
                      offset: const Offset(0, .1),
                      withopacty: true,
                      child: Row(
                        children: [
                          Text(
                            _controller.userTypeString,
                            textScaleFactor: 1,
                          ),
                          Container(
                            width: 90,
                            child: RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                value: _controller.doctor,
                                title: const Text(
                                  "دكتور",
                                  textScaleFactor: 1,
                                ),
                                groupValue: radiogroup,
                                onChanged: (val) {
                                  radiogroup = val!;
                                  setState(() {});
                                }),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                value: _controller.nurse,
                                title: const Text(
                                  "ممرض",
                                  textScaleFactor: 1,
                                ),
                                groupValue: radiogroup,
                                onChanged: (val) {
                                  radiogroup = val!;
                                  setState(() {});
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 16,
                  ),
                  Padding(
                    // padding: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.only(right: 20, left: 20),

                    child: AnimatedOpacityAndPosition(
                      duration: Duration(milliseconds: 450),
                      scale: 0.5,
                      curve: Curves.easeOutQuart,
                      delayduration: const Duration(milliseconds: 3400),
                      offset: Offset.zero,
                      withopacty: true,
                      child: GradientButtonFb4(
                        onPressed: adduser,
                        text: _controller.signUpString,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool loading = false;
  void adduser() async {
    var formdata = formstate.currentState;
    formdata!.save();
    if (formdata.validate()) {
      showloading();
      Map<String, dynamic> user = {
        "Id": 2,
        "Name": name.text,
        "Password": password.text,
        "username": username.text,
      };
      var data = await _controller.insert_User(user, radiogroup);
      if (data["status"] == "success") {
        // Move to other screen>>>>>>>>>>>>>>>>>>>
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      } else if (data["status"] == "no type") {
        // no selected type
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      } else
        // ignore: curly_braces_in_flow_control_structures, use_build_context_synchronously
        Navigator.of(context).pop();
    }
  }

  showloading() {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          child: SpinKitRipple(
            color: MyColor.orange,
            size: Get.width / 3.2,
            duration: const Duration(milliseconds: 1100),
          ),
        );
      },
    );
  }
}
