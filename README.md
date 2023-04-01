# 2023 GDSC Solution Challenge

## Welcome to the Digital Care system repository!
<a href="https://youtu.be/bBWRyaHUc8M" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/youtube.svg" alt="youtube" height="30" width="40" /> Watch System Discription Vedio</a>

The Digital Care system is a sophisticated architecture that consists of three interconnected components, including a dashboard, a vital signs measurement device, and an Android system. These components are connected to  firebase databases via Google Cloud and communicate with each other using IoT and firebase APIs. The system is built using various programming languages such as Dart for flutter framework and C language, and it utilizes various hardware components such as sensors, microcontrollers, LCD screens, and buttons.

Digital Care, used in this code 3.3.1 version of flutter and MVVM architecture design pattern, with GETX for state management, it contains Signup screen, Login screen, Home screen, patients history list screen,patient list screen, for the backend used firebase real-time, firebase firestore this system for now will get only the Temperature, Heart Rate and SPO2 for the patient, it could be more in future like blood pressure, if these vital signs goes beyond the normal range it gives alarm with a notification that the alarm speaks of the room number and the bed number the same of the notification, when the notification is tapped it Navigate to the patient details page (in case that the nurse didn't tab the notification within 1 minute it will insert the patient Id to the dashboard node in firebase real-time database so it transfer to the dashboard to notify who is in charge to send another nurse, if the nurse tapped the notification it won't transfer it).
and contains a property to call the nurse in case if the patient wants a hand, it will send a notification to the nurse with the name of the patient and the room number with the bed number, when the notification is tapped it navigate to the patient details page.

## installing, front-end: 
First install flutter in your environment and also install the JDK, ensure that its installed successfully by running flutter doctor in cmd, create new project then replace the files of the project that I provided in Application repository, then go to the terminal of your Development environment and run the following command “flutter pub get” to install the packages to the project the packages are already in pubspec.yaml. 

## installing, back-end: 
Create account in firebase, then go to console, from there create a project then create an android project, when you get the file named google-services replace it with the one in my android->src, you almost done, then in the main file make the initial route to the “/SignUp” so you create a user (doctor or nurse) close reinstall it with “/LogIn” screen so U login to the project with the user name and the email you have submitted.


## SignUp screen:
this screen use to create account for the users doctors or nurses by the admin. 

## Login screen:
screen that the user (nurse or doctor) will insert his information (that was created by the admin) to log in into the Homepage. 

## Homepage:
screen that contains a QR code section to scan the bed QR code to insert a ptient or show the patient vital signs or modifiy the information in case the patient changed from the bed. 

## patient list screen:
screen that shows all the patients that the nurse or the doctor took in his list that contains the patient's information (name and age), and vital signs that is in realtime.

## patients history list screen: 
this screen shows all the patients that the nurse hvae taken even if the patient leave the hospital,
this screen contains their information, and genrateing report that is contains the patient signs in each hour that he came into the hospital, and contains another report that contains only the vital signs that goes beyond the normal range,

* the vital signs of the normal range of each age is beside the main file so if there is any changes to vital signs you can go ahead and change them *

## the third party packages used in this programm:

  get: ^4.6.5 : used as state management
  
  firebase_core: ^2.6.1 : to initialize firebase
  
  shared_preferences: ^2.0.17 : store the nurse information
  
  firebase_database: ^10.0.13 : real-time data base for the vital signs
  
  flutter_spinkit: ^5.1.0 : loading UI
  
  flutter_tts: ^3.6.3 : to speak the room number and the bed number that is the patient is in an emargency case
  
  lottie: ^2.2.0 : to show some animation
  
  flutter_barcode_scanner: to scan the QR code 
  
  page_transition: ^2.0.9 : some animation transition 
  
  flutter_staggered_animations: ^1.1.1 : animation to the list 
  
  introduction_screen: ^3.1.4 : onboarding screen
  
  audioplayers: ^0.19.1 : to start the alarm sound when the patient call the nurse
  
  printing: ^5.0.0 : Used to deal with the reports the is generated by the vital signs that saved hourly
  
  cloud_firestore: ^4.4.5 : used to store the information of the reports
  
  awesome_notifications: ^0.7.4+1 : to send notification to the nurse


![image](https://drive.google.com/uc?export=view&id=1ifEp_qQZm7AuVc3XTu83zJxZGFvRY6_7)

![image](https://drive.google.com/uc?export=view&id=1corMaspN9rwv9NIv1DHPXu3Hzibzn2h2)


![image](https://drive.google.com/uc?export=view&id=1R1QqH3O_GQ4-Eq5LTN40PZMTtuUJkH02)


![image](https://drive.google.com/uc?export=view&id=1Y5X30-TbwfLSI-hj6bHhTRMwbi4eHfD0)




