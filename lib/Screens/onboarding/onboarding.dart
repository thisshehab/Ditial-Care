import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:patient_observing/Screens/Registration/Log_In/Log_In_Veiw.dart';
import '../../Animations/animating_widgets.dart';
import '../Home/homebefore.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<OnBoardingPageState>();
  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LogIn()),
    );
  }

  // Widget _buildFullscreenImage() {
  //   return Image.asset(
  //     'assets/fullscreen.jpg',
  //     fit: BoxFit.cover,
  //     height: double.infinity,
  //     width: double.infinity,
  //     alignment: Alignment.center,
  //   );
  // }

  Widget _buildImage(String assetName, [double width = 600]) {
    return Image.asset('images/$assetName', width: width);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isA110wed) async {
      if (!isA110wed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var fontsize = MediaQuery.of(context).textScaleFactor * 17;
    var fontsize2 = fontsize * 2.7;

    TextStyle bodyStyle = TextStyle(fontSize: fontsize);
    var pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, Get.height / 30, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: Get.height / 30),
        child: IntroductionScreen(
          key: introKey,
          globalBackgroundColor: Colors.white,
          globalHeader: Align(
            alignment: Alignment.topRight,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, right: 16),
                child: Container(),
              ),
            ),
          ),
          pages: [
            PageViewModel(
              titleWidget: AnimatedOpacityAndPosition(
                scale: 1,
                delayduration: Duration(milliseconds: 600),
                offset: Offset(0, .1),
                withopacty: true,
                duration: Duration(milliseconds: 600),
                child: Text(
                  "الرعاية الرقمية",
                  style: TextStyle(
                      fontSize: fontsize2, fontWeight: FontWeight.bold),
                ),
              ),
              bodyWidget: AnimatedOpacityAndPosition(
                scale: 1,
                delayduration: Duration(milliseconds: 1000),
                offset: Offset(0, .2),
                withopacty: true,
                duration: Duration(milliseconds: 600),
                child: Text(
                  " نظام هدفه  تسهيل حياة الممرض والدكتور المتابع وتقليل حالات الوفاة التي يُمكن تلافيها عن طريق حساسات توضع على معصم المريض لقياس علاماته الحيوية",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: fontsize2 / 1.9),
                ),
              ),
              image: AnimatedOpacityAndPosition(
                  scale: .8,
                  delayduration: Duration(milliseconds: 200),
                  offset: Offset(0, 0),
                  withopacty: true,
                  duration: Duration(milliseconds: 800),
                  child: Image.asset(
                    "images/lastlogo.png",
                  )),
              decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget: AnimatedOpacityAndPosition(
                scale: 1,
                delayduration: Duration(milliseconds: 600),
                offset: Offset(0, .1),
                withopacty: true,
                duration: Duration(milliseconds: 600),
                child: Text(
                  "آلية العمل",
                  style: TextStyle(
                      fontSize: fontsize2, fontWeight: FontWeight.bold),
                ),
              ),
              bodyWidget: AnimatedOpacityAndPosition(
                scale: 1,
                delayduration: Duration(milliseconds: 1000),
                offset: Offset(0, .2),
                withopacty: true,
                duration: Duration(milliseconds: 600),
                child: Text(
                  "تقوم الحساسات بإرسال علامات المريض الحيوية إلى قاعدة بيانات في الوقت الحقيقي ليتم بعدها فحص حالة المريض وإرسال تنبيهات للمرض في حالة دخول المريض في حالة حرجة",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: fontsize2 / 1.9),
                ),
              ),
              image: AnimatedOpacityAndPosition(
                  scale: .8,
                  delayduration: Duration(milliseconds: 200),
                  offset: Offset(0, .1),
                  withopacty: true,
                  duration: Duration(milliseconds: 800),
                  child: _buildImage('doctorswithpatient.png')),
              decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget: AnimatedOpacityAndPosition(
                scale: 1,
                delayduration: Duration(milliseconds: 600),
                offset: Offset(0, .1),
                withopacty: true,
                duration: Duration(milliseconds: 600),
                child: Text(
                  "طلب الممرض",
                  style: TextStyle(
                      fontSize: fontsize2, fontWeight: FontWeight.bold),
                ),
              ),
              bodyWidget: AnimatedOpacityAndPosition(
                scale: 1,
                delayduration: Duration(milliseconds: 1000),
                offset: Offset(0, .2),
                withopacty: true,
                duration: Duration(milliseconds: 600),
                child: Text(
                  "يمكن للمريض استدعاء الممرض في حالة أراد مساعدة عن طريق زر موجود في الجهاز",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: fontsize2 / 1.9),
                ),
              ),
              image: AnimatedOpacityAndPosition(
                  scale: .8,
                  delayduration: Duration(milliseconds: 200),
                  offset: Offset(0, 0),
                  withopacty: true,
                  duration: Duration(milliseconds: 800),
                  child: _buildImage('calldoctor.png')),
              decoration: pageDecoration,
            ),
            // PageViewModel(
            //   title: "Full Screen Page",
            //   body:
            //       "Pages can be full screen as well.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
            //   image: _buildFullscreenImage(),
            //   decoration: pageDecoration.copyWith(
            //     contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            //     fullScreen: true,
            //     bodyFlex: 2,
            //     imageFlex: 3,
            //     safeArea: 100,
            //   ),
            // ),
          ],
          onDone: () => _onIntroEnd(context),
          //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
          showSkipButton: false,
          skipOrBackFlex: 0,

          nextFlex: 0,
          //rtl: true, // Display as right-to-left
          back: const Icon(Icons.arrow_back),
          skip:
              const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
          next: const Icon(Icons.arrow_forward),
          done:
              const Text('بدء', style: TextStyle(fontWeight: FontWeight.w600)),
          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin:
              EdgeInsets.only(bottom: Get.height / 44, left: Get.width / 8),
          controlsPadding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Color(0xFFBDBDBD),
            activeSize: Size(20.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          dotsContainerDecorator: const ShapeDecoration(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
      ),
    );
  }
}
