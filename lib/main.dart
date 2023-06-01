  // ignore_for_file: unnecessary_this, use_key_in_widget_constructors, unused_field, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, prefer_const_literals_to_create_immutables, unused_import, must_be_immutable, unused_local_variable, duplicate_import, unused_element

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:doctor/providers/doctorPatient_details.dart';
import 'package:doctor/providers/doctorPrescriptionPdf_details.dart';
import 'package:doctor/providers/doctorQualification_details.dart';
import 'package:doctor/screens/My_Calendar_Screen/EditSlot_Screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:doctor/screens/signup_Screens/EnterPhoneNumber_Screen.dart';
import 'package:doctor/screens/signup_Screens/EnterPhoneOtp_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:flutter/services.dart";

import '../providers/doctorAuth_details.dart';
import '../providers/doctorUser_details.dart';
import '../providers/doctorCalendar_details.dart';
import '../providers/doctorUpcomingAppointments_details.dart';
import "../providers/doctorFirebaseLinks_details.dart";

import 'StarterScreens/langpicker.dart';

import './screens/signup_Screens/SelectSignInSignUp.dart';
import './screens/signup_Screens/SelectLanguage_Screen.dart';
import './screens/signup_Screens/SelectQualification_Screen.dart';
import './screens/signup_Screens/SelectMedicineType_Screen.dart';
import './screens/signup_Screens/SelectDepartmentType.dart';
import './screens/signup_Screens/EnterPersonalDetailsScreen.dart';
import './screens/signup_Screens/EnterPhoneNumber_Screen.dart';
import './screens/signup_Screens/EnterPhoneOtp_Screen.dart';

import './screens/Tabs_Screen.dart';
import './screens/Home_Screen.dart';
import './screens/My_Patients_Screen/MyPatients_Screen.dart';
import './screens/My_Patients_Screen/Patient_Section.dart';
import './screens/My_Patients_Screen/Recent_Section.dart';
import './screens/My_Calendar_Screen/MyCalendar_Screen.dart';
import './screens/My_Calendar_Screen/Doctor_Appointment_Slots.dart';
import './screens/UpcomingAppointments_Screen.dart';
import './screens/MyProfile_Screen.dart';
import './screens/MySettings_Screen.dart';

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel',
//   'High Importance Notifications',
//   // 'This channel is used for important notifications.',
//   importance: Importance.high,
//   playSound: true,
// );

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('A bg message just showed up: ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );

  // runApp(const MyApp());
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  late UserCredential userCred;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: DoctorFirebaseDetails(),
        ),
        ChangeNotifierProvider.value(
          value: DoctorAuthDetails(),
        ),
        ChangeNotifierProvider.value(
          value: DoctorUserDetails(),
        ),
        ChangeNotifierProvider.value(
          value: DoctorCalendarDetails(),
        ),
        ChangeNotifierProvider.value(
          value: DoctorPatientDetails(),
        ),
        ChangeNotifierProvider.value(
          value: DoctorUpcomingAppointmentDetails(),
        ),
        ChangeNotifierProvider.value(
          value: DoctorPrescriptionPdfDetails(),
        ),
        ChangeNotifierProvider.value(
          value: DoctorQualificationDetails(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Doctor Application',

        theme: ThemeData(
          primaryColor: const Color(0xFFfbfcff),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          canvasColor: Color.fromRGBO(255, 254, 229, 0.9),
          hoverColor: Colors.transparent,
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline6: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              ),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
          ).copyWith(
            secondary: Color.fromARGB(255, 84, 83, 77),
          ),
        ),
        home: StreamBuilder(
          stream: _auth.authStateChanges(),
          builder: (ctx, userSnapShot) {
            if (userSnapShot.hasData) {
              return TabsScreenDoctor();
            } else {
              return SelectLanguageScreenDoctor();
              // return SelectSignInSignUpScreenDoctor();
            }
          },
        ),
        // initialRoute: ,
        // home: HomeScreenDoctor(),
        routes: {
          SelectSignInSignUpScreenDoctor.routeName: (ctx) =>
              SelectSignInSignUpScreenDoctor(),
          SelectLanguageScreenDoctor.routeName: (ctx) =>
              SelectLanguageScreenDoctor(),
          SelectQualificationScreenDoctor.routeName: (ctx) =>
              SelectQualificationScreenDoctor(),
          SelectMedicineTypeScreen.routeName: (ctx) =>
              SelectMedicineTypeScreen(),
          SelectDepartmentTypeScreen.routeName: (ctx) =>
              SelectDepartmentTypeScreen(),
          EnterUserPersonalDetailsScreen.routeName: (ctx) =>
              EnterUserPersonalDetailsScreen(),
          EnterPhoneNumberScreen.routeName: (ctx) => EnterPhoneNumberScreen(),
          EnterPhoneOtpScreen.routeName: (ctx) => EnterPhoneOtpScreen(),
          TabsScreenDoctor.routeName: (ctx) => TabsScreenDoctor(),
          HomeScreenDoctor.routeName: (ctx) => HomeScreenDoctor(),
          MyPatientsScreenDoctor.routeName: (ctx) => MyPatientsScreenDoctor(),
          MyPatients_PatientSectionTab.routeName: (ctx) =>
              MyPatients_PatientSectionTab(),
          MyPatients_RecentSectionTab.routeName: (ctx) =>
              MyPatients_RecentSectionTab(),
          MyCalendarScreenDoctor.routeName: (ctx) => MyCalendarScreenDoctor(),
          DoctorAppointmentSlot.routeName: (ctx) => DoctorAppointmentSlot(),
          UpcomingAppointmentsScreenDoctor.routeName: (ctx) =>
              UpcomingAppointmentsScreenDoctor(),
          MyProfileScreen.routeName: (ctx) => MyProfileScreen(),
          MySettingsScreen.routeName: (ctx) => MySettingsScreen(),
        },
      ),
    );
  }
}
