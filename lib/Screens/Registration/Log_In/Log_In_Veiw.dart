import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:patient_observing/Animations/animating_widgets.dart';
import 'package:patient_observing/AppConstants/color.dart';
import 'package:patient_observing/Firebase/doctors_FireBase.dart';
import 'package:patient_observing/Firebase/nurse_FireBase.dart';
import 'package:patient_observing/Other/awsomenoti.dart';
import 'package:patient_observing/Screens/Home/homebefore.dart';
import 'package:patient_observing/Screens/Registration/Log_In/Log_In_ModelVeiw.dart';
import '../../../Animations/circle_animation.dart';
import '../../../AppConstants/variables.dart';
import '../../../Custom_Widgets/Button.dart';
import '../../../Custom_Widgets/Textfeild.dart';
import 'package:page_transition/page_transition.dart';

import '../../../Other/Local_Notification.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  String radiogroup = "";
  bool reverse = false;
  final LogInModelVeiw _controller = LogInModelVeiw(
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
              reverse: reverse,
            ),
            Container(
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
                      reverse: reverse,
                      scale: 1,
                      delayduration: Duration(milliseconds: 1000),
                      offset: Offset.zero,
                      withopacty: true,
                      child: Text(
                        "تسجيل الدخول",
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
                      reverse: reverse,
                      delayduration: Duration(milliseconds: 1000),
                      offset: Offset(.1, 0),
                      withopacty: true,
                      child: Text(
                        "֍ ملاحضة: لا يمكن الدخول إلا لمن تم تسجيلهم من قبل مدير النظام",
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
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: AnimatedOpacityAndPosition(
                      reverse: reverse,
                      scale: 1,
                      duration: const Duration(milliseconds: 500),
                      delayduration: const Duration(milliseconds: 1500),
                      offset: Offset(0, .1),
                      withopacty: true,
                      child: MyTextFeild(
                        validate: (value) {
                          return null;
                        },
                        icon: Icon(
                          Icons.person,
                          color: MyColor.orange,
                        ),
                        hintText: "اسم المستخدم",
                        textController: username,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    // padding: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.only(right: 20, left: 20),

                    child: AnimatedOpacityAndPosition(
                      reverse: reverse,
                      scale: 1,
                      duration: const Duration(milliseconds: 500),
                      delayduration: const Duration(milliseconds: 1700),
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
                        issecure: true,
                        hintText: "كلمة المرور",
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
                      reverse: reverse,
                      scale: 1,
                      duration: const Duration(milliseconds: 500),
                      delayduration: const Duration(milliseconds: 1900),
                      offset: const Offset(0, .1),
                      withopacty: true,
                      child: Row(
                        children: [
                          const Text(
                            "نوع المستخدم :",
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
                      reverse: reverse,
                      duration: Duration(milliseconds: 450),
                      scale: 0.5,
                      curve: Curves.easeOutQuart,
                      delayduration: const Duration(milliseconds: 2100),
                      offset: Offset.zero,
                      withopacty: true,
                      child: GradientButtonFb4(
                        onPressed: adduser,
                        text: "تسجيل الدخول",
                      ),
                    ),
                  ),
                  wrong != null
                      ? Container(
                          margin: EdgeInsets.only(top: Get.height / 24),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              wrong!,
                              style: TextStyle(fontSize: 14, color: Colors.red),
                            ),
                          ),
                        )
                      : Container()
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? wrong;
  bool loading = false;
  void adduser() async {
    showloading();
    Map<String, String> user = {
      "Password": password.text,
      "username": username.text,
    };
    var resualt = await _controller.isAvialble(user, radiogroup);
    if (resualt["status"] == "success") {
      print("ok>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      reverse = true;
      setState(() {});
      await Future.delayed(
          Duration(milliseconds: 3300), () => Navigator.of(context).pop());
      //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> go to home page;
      wrong = null;
      Navigator.pushReplacement(context,
          PageTransition(type: PageTransitionType.fade, child: HomePage()));
    } else {
      Navigator.of(context).pop();
      //
      wrong = "اسم مستخدم أو كلمة مرور خاطئة";
      setState(() {});
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
