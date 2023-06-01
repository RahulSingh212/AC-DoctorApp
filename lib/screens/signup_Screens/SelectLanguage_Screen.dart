// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_final_fields, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, file_names, unnecessary_import, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, avoid_unnecessary_containers, sort_child_properties_last, unused_import, duplicate_import, unused_local_variable, must_be_immutable, unused_element

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:doctor/screens/signup_Screens/SelectQualification_Screen.dart';
import 'package:doctor/screens/signup_Screens/SelectSignInSignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../HelperStuff/circle_painter.dart';
import '../../HelperStuff/rounded_rectangle.dart';
import '../../StarterScreens/qualifications.dart';

import '../../providers/doctorAuth_details.dart';
import '../../providers/doctorUser_details.dart';

class SelectLanguageScreenDoctor extends StatefulWidget {
  static const routeName = '/doctor-select-language-screen';

  @override
  State<SelectLanguageScreenDoctor> createState() =>
      _SelectLanguageScreenDoctorState();
}

class _SelectLanguageScreenDoctorState extends State<SelectLanguageScreenDoctor> {
  bool ispressed_eng = false;
  bool ispressed_hindi = false;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provisional permission");
    } else {
      print("User declined or has not accepted permission");
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then(
      (token) {
        Provider.of<DoctorUserDetails>(context, listen: false)
            .mobileMessagingToken = token.toString();
        print(token);
      },
    );
  }

  initInfo() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var IOSInitialize = const IOSInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: IOSInitialize);

    flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
      onSelectNotification: (String? payload) async {
        try {
          if (payload != null && payload.isNotEmpty) {
          } else {}
        } catch (errorVal) {
          print(errorVal);
        }
      },
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        print(".....onMessage.......");
        print(
            "onMessage: ${message.notification?.title}/${message.notification!.body}");

        BigTextStyleInformation bigTextStyleInformation =
            BigTextStyleInformation(
          message.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: message.notification!.title.toString(),
          htmlFormatContentTitle: true,
        );

        AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          "aurigaCare",
          "aurigaCare",
          "",
          importance: Importance.high,
          styleInformation: bigTextStyleInformation,
          priority: Priority.high,
          playSound: true,
        );

        NotificationDetails platformChannelSpecifies = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: const IOSNotificationDetails(),
        );
        await flutterLocalNotificationsPlugin.show(
            0,
            message.notification!.title,
            message.notification!.body,
            platformChannelSpecifies,
            payload: message.data['body']);
      },
    );
  }

  void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAJf9Zzxw:APA91bG2byLOz03IcaNF5kfF9jeEj9hudr-VbWCNfBBuGdi6GYToR_rutgKIynxNfeNjKzSBC2JFMZ1xX_e6wVBgL-5yihEtdxcMWMshW8fggjQRxyBuR5QabafIUBpC3iAA9gpHxzSG',
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              'title': title,
              "body": body,
              "android_channel_id": "aurigaCare",
            },
            "to": token,
          },
        ),
      );
    } catch (errorVal) {}
  }

  @override
  void initState() {
    super.initState();

    // requestPermission();
    // getToken();
    // initInfo();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    double width = (MediaQuery.of(context).size.width);
    double height = (MediaQuery.of(context).size.height);

    return Scaffold(
      backgroundColor: Color(0xFFfbfcff),
      body: Container(
        // width: screenWidth,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(screenWidth, screenHeight),
              painter: CirclePainter(),
            ),
            Container(
              width: screenWidth,
              padding: EdgeInsets.only(top: 0.09 * screenHeight),
              child: Text(
                "AURIGA CARE DOCTOR",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  fontStyle: FontStyle.normal,
                  color: Color(0xFFfbfcff),
                  // height: ,
                ),
              ),
            ),
            Container(
              width: width,
              padding: EdgeInsets.only(top: 0.159846 * height),
              child: Text(
                '24/7 Video Consultations,\nexclusively on app',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  color: Color(0xFFfbfcff),
                  // height: ,
                ),
              ),
            ),

            CustomPaint(
              size: Size(
                0.785 * width,
                0.65 * height,
              ),
              painter: RoundedRectangle(),
            ),
            Container(
              width: width,
              padding: EdgeInsets.only(top: 0.36828 * height),
              child: Text(
                "Select Language\nभाषा चुने",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  color: Color(0xff2c2c2c),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0.45 * height),
              alignment: Alignment.topCenter,
              child: TextButton(
                onPressed: () {
                  Provider.of<DoctorUserDetails>(context, listen: false)
                      .setDoctorLanguageType(true);
                  Provider.of<DoctorUserDetails>(context, listen: false)
                      .isReadingLangEnglish = true;
                  // Navigator.of(context).pushNamed(SelectQualificationScreenDoctor.routeName);
                  Navigator.of(context)
                      .pushNamed(SelectSignInSignUpScreenDoctor.routeName);
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      ispressed_eng ? Color(0xff42ccc3) : Color(0xFFfbfcff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(27.5),
                    ),
                  ),
                  side: BorderSide(
                    color: Color(0xffebebeb),
                    width: 1,
                  ),
                  padding: EdgeInsets.fromLTRB(
                    0.208333 * width,
                    0.016624 * height,
                    0.205555 * width,
                    0.016624 * height,
                  ),
                  minimumSize: Size(221, 55),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.center,
                ),
                child: Text(
                  "English",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    color:
                        ispressed_eng ? Color(0xFFfbfcff) : Color(0xff2c2c2c),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0.56393 * height),
              alignment: Alignment.topCenter,
              child: TextButton(
                onPressed: () {
                  Provider.of<DoctorUserDetails>(context, listen: false)
                      .setDoctorLanguageType(false);
                  Provider.of<DoctorUserDetails>(context, listen: false)
                      .isReadingLangEnglish = false;
                  Navigator.of(context)
                      .pushNamed(SelectSignInSignUpScreenDoctor.routeName);
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      ispressed_hindi ? Color(0xff42ccc3) : Color(0xFFfbfcff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(27.5),
                    ),
                  ),
                  side: BorderSide(
                    color: Color(0xffebebeb),
                    width: 1,
                  ),
                  padding: EdgeInsets.fromLTRB(
                    0.208333 * width,
                    0.016624 * height,
                    0.205555 * width,
                    0.016624 * height,
                  ),
                  minimumSize: Size(221, 55),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.center,
                ),
                child: Text(
                  "हिन्दी",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    color:
                        ispressed_hindi ? Color(0xFFfbfcff) : Color(0xff2c2c2c),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0.65 * height),
              alignment: Alignment.topCenter,
              child: Align(
                child: Container(
                  height: screenHeight * 0.175,
                  width: screenWidth * 0.35,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: screenWidth,
                    child: CircleAvatar(
                      radius: screenWidth * 0.6,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          screenWidth * 0.2,
                        ),
                        child: ClipOval(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              "assets/images/agLogo.png",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Align(
            //   child: Container(
            //     height: screenHeight * 0.175,
            //     width: screenWidth * 0.35,
            //     child: CircleAvatar(
            //       backgroundColor: Colors.transparent,
            //       radius: screenWidth,
            //       child: CircleAvatar(
            //         radius: screenWidth * 0.6,
            //         child: ClipRRect(
            //           borderRadius: BorderRadius.circular(
            //             screenWidth * 0.2,
            //           ),
            //           child: ClipOval(
            //             child: Container(
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(100),
            //               ),
            //               child: Image.asset(
            //                 "assets/images/agLogo.png",
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkForError(
      BuildContext context, String titleText, String contextText,
      {bool popVal = false}) async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${titleText}'),
        content: Text('${contextText}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check_circle_rounded,
              color: Color(0xff42ccc3),
            ),
            iconSize: 50,
            color: Colors.brown,
            onPressed: () {
              setState(() {
                if (popVal == false) {
                  Navigator.pop(ctx);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
