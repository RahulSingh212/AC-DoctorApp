// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_import, unnecessary_import, duplicate_import, unused_local_variable, deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:doctor/providers/doctorCalendar_details.dart';
import 'package:doctor/screens/MyProfile_Screen.dart';
import 'package:doctor/screens/Notification_Screens/Notifications_Screen.dart';
import 'package:doctor/screens/doctorAppointment_Screens/PatientAppointmentInformation_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../models/token_info.dart';
import '../providers/doctorAuth_details.dart';
import '../providers/doctorUpcomingAppointments_details.dart';
import '../providers/doctorUser_details.dart';
import '../providers/doctorCalendar_details.dart';

import './Home_Screen.dart';
import './My_Patients_Screen/MyPatients_Screen.dart';
import 'My_Calendar_Screen/MyCalendar_Screen.dart';
import './UpcomingAppointments_Screen.dart';
import 'doctorAppointment_Screens/PatientAppointmentDescription_Screen.dart';

class HomeScreenDoctor extends StatefulWidget {
  static const routeName = '/doctor-home-screen';

  @override
  State<HomeScreenDoctor> createState() => _HomeScreenDoctorState();
}

class _HomeScreenDoctorState extends State<HomeScreenDoctor> {
  bool isLangEnglish = true;

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
        Provider.of<DoctorUserDetails>(context, listen: false).mobileMessagingToken = token.toString();
        print(token);
        updateMobileMessagingToken(token.toString());
      },
    );
  }

  void updateMobileMessagingToken(String token) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("DoctorUsersPersonalInformation");

    var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    var loggedInUserId = currLoggedInUser?.uid as String;

    db.collection("DoctorUsersPersonalInformation")
        .doc(loggedInUserId)
        .update({"doctor_MobileMessagingTokenId": token});
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
          importance: Importance.max,
          styleInformation: bigTextStyleInformation,
          priority: Priority.max,
          sound: RawResourceAndroidNotificationSound('notification'),
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

    requestPermission();
    getToken();
    initInfo();

    Provider.of<DoctorUserDetails>(context, listen: false).setDoctorUserInfo(context);
    // Provider.of<DoctorCalendarDetails>(context, listen: false).removeExpiredAppointmentsSlots();

    // FirebaseFirestore db = FirebaseFirestore.instance;
    // CollectionReference usersRef = db.collection("DoctorsUserPhoneNumberList");
    isLangEnglish = Provider.of<DoctorUserDetails>(context, listen: false).isReadingLangEnglish;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<DoctorUpcomingAppointmentDetails>(context)
        .fetchDoctorActiveUpcomingTokens(context);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    var userInfoDetails = Provider.of<DoctorUserDetails>(context);
    Map<String, String> userMapping =
        userInfoDetails.getDoctorUserPersonalInformation();

    String imageNetworkUrl = userMapping['doctor_ProfilePicUrl'] ?? "";

    return SafeArea(
      child: ListView(
        children: [
          SizedBox(
            height: screenHeight * 0.015,
          ),
          Align(
            child: Container(
              alignment: Alignment.center,
              height: screenHeight * 0.05,
              width: screenWidth * 0.925,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DoctorNotificationsScreen(
                            0,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      child: Icon(
                        Icons.notifications_none,
                        size: 0.095 * screenWidth,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(MyProfileScreen.routeName);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      height: screenWidth * 0.1125,
                      width: screenWidth * 0.1125,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: screenWidth,
                        child: CircleAvatar(
                          radius: screenWidth,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              screenWidth,
                            ),
                            child: ClipOval(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1000),
                                ),
                                child: imageNetworkUrl == ""
                                    ? Image.asset(
                                        "assets/images/surgeon.png",
                                      )
                                    : Image.network(
                                        imageNetworkUrl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          // Name of the User
          Align(
            child: Container(
              width: screenWidth * 0.925,
              alignment: Alignment.centerLeft,
              child: Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: isLangEnglish ? 'Hello, ' : "नमस्ते, ",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    TextSpan(
                      text: '${userMapping['doctor_FullName']}!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.0150,
          ),
          // Image of the "know more"
          Align(
            child: Container(
              width: screenWidth * 0.925,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(66, 204, 195, 1),
                image: DecorationImage(
                  image: AssetImage("assets/ScreenImages/HomeImg.png"),
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.001,
                horizontal: screenWidth * 0.05,
              ),
              height: screenHeight * 0.235,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: screenWidth * 0.3,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.005,
                    ),
                    child: Text(
                      isLangEnglish
                          ? 'Schedule your availability to your patients !'
                          : 'अपने रोगियों के लिए अपनी उपलब्धता निर्धारित करें!',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.025,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.0125,
                      horizontal: screenWidth * 0.045,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: RichText(
                      textAlign: TextAlign.right,
                      text: TextSpan(
                        children: [
                          // TextSpan(
                          //   text: "Developer: ",
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     // fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          // WidgetSpan(
                          //   child: Icon(
                          //     Icons.ads_click_rounded,
                          //   ),
                          // ),
                          TextSpan(
                            // style: linkText,
                            text: isLangEnglish ? "Know More" : "अधिक जानिए",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(
                                0xff42ccc3,
                              ),
                              // decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                var url =
                                    "https://www.youtube.com/watch?v=Afy9yv6DQZU";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                          ),
                        ],
                      ),
                    ),

                    // Text(
                    //   isLangEnglish ? "Know More" : "अधिक जनिये",
                    //   style: TextStyle(
                    //     fontSize: 15,
                    //     fontWeight: FontWeight.w500,
                    //     color: Color(
                    //       0xff42ccc3,
                    //     ),
                    //   ),
                    // ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.0150,
          ),
          // Functionalities: My Patients, My Schedule, My Consulting
          Align(
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Color.fromRGBO(242, 242, 242, 1),
                  width: 1,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white70,
                  border: Border.all(
                    width: 1,
                    color: Color.fromRGBO(242, 242, 242, 1),
                  ),
                ),
                height: screenHeight * 0.17,
                width: screenWidth * 0.925,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.01,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // My Patients
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(MyPatientsScreenDoctor.routeName);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.001,
                          vertical: screenHeight * 0.0005,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              enableFeedback: false,
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    MyPatientsScreenDoctor.routeName);
                              },
                              icon: Icon(
                                Icons.person_pin_rounded,
                                color: Color(0xff42ccc3),
                                size: 40,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text(
                                isLangEnglish ? "My Patients" : "मेरे मरीज़",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    VerticalDivider(
                      color: Colors.black,
                      thickness: 0.15,
                    ),

                    // My Schedule
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(MyCalendarScreenDoctor.routeName);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.001,
                          vertical: screenHeight * 0.0005,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              enableFeedback: false,
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    MyCalendarScreenDoctor.routeName);
                              },
                              icon: Icon(
                                Icons.calendar_month,
                                color: Color(0xff42ccc3),
                                size: 40,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text(
                                isLangEnglish ? "My Schedule" : "मेरे अनुसूची",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    VerticalDivider(
                      color: Colors.black,
                      thickness: 0.15,
                    ),

                    // My Consulting
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            UpcomingAppointmentsScreenDoctor.routeName);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.001,
                          vertical: screenHeight * 0.0005,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              enableFeedback: false,
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    UpcomingAppointmentsScreenDoctor.routeName);
                              },
                              icon: Icon(
                                Icons.message_outlined,
                                color: Color(0xff42ccc3),
                                size: 40,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text(
                                isLangEnglish ? "Appointments" : "नियुक्ति",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.015,
          ),

          // Heading Row: "Appointments & View All"
          Align(
            child: Container(
              width: screenWidth * 0.925,
              margin: EdgeInsets.only(
                bottom: screenHeight * 0.0025,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text.rich(
                      TextSpan(
                        text: isLangEnglish ? 'Appointments' : "नियुक्ति",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                    ),
                  ),
                  Provider.of<DoctorUpcomingAppointmentDetails>(context,
                              listen: false)
                          .items
                          .isNotEmpty
                      ? Container(
                          height: screenHeight * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.5),
                            color: Color.fromRGBO(196, 196, 196, 1),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 0.025 * screenWidth,
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: TextStyle(fontSize: 18),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                UpcomingAppointmentsScreenDoctor.routeName,
                              );
                            },
                            child: Text(
                              isLangEnglish ? "View All" : "सभी को देखें",
                              style: TextStyle(
                                color: Color(0xff9B9B9B),
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          Provider.of<DoctorUpcomingAppointmentDetails>(context, listen: false)
                  .items
                  .isEmpty
              ? Align(
                  child: Card(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      width: screenWidth * 0.95,
                      height: screenHeight * 0.2,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.075,
                        vertical: screenHeight * 0.025,
                      ),
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(25),
                      //   color: Colors.white70,
                      // ),
                      child: Text(
                        "\"No appointments for today\"",
                        style: TextStyle(
                          color: Color.fromRGBO(196, 207, 238, 1),
                          fontSize: screenWidth * 0.0425,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              : Align(
                  child: Container(
                    height: screenHeight * 0.25,
                    width: screenWidth * 0.95,
                    child: ListView.builder(
                      itemCount: Provider.of<DoctorUpcomingAppointmentDetails>(
                              context,
                              listen: false)
                          .items
                          .length,
                      itemBuilder: (ctx, index) {
                        return patientAppointmentWidget(
                          context,
                          Provider.of<DoctorUpcomingAppointmentDetails>(context,
                                  listen: false)
                              .items[index],
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget patientAppointmentWidget(
    BuildContext context,
    BookedTokenSlotInformation tokenInfo,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return InkWell(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => PatientAppointmentDescriptionScreen(
        //       0,
        //       tokenInfo,
        //     ),
        //   ),
        // );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PatientAppointmentInformationScreen(
              0,
              tokenInfo,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          top: screenHeight * 0.01,
        ),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Color.fromRGBO(242, 242, 242, 1),
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.01,
              horizontal: screenWidth * 0.025,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: screenWidth * 0.2,
                  height: screenWidth * 0.2,
                  decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: Color.fromARGB(255, 233, 218, 218),
                    //   width: 1,
                    // ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: (tokenInfo.patient_ImageUrl == "" ||
                              tokenInfo.patient_ImageUrl.toString() == 'null')
                          ? Image.asset(
                              'assets/images/healthy.png',
                              fit: BoxFit.fill,
                              width: screenWidth * 0.2,
                            )
                          : Image.asset(
                              'assets/images/healthy.png',
                              fit: BoxFit.fill,
                              width: screenWidth * 0.2,
                            ),
                      // : Image.network(
                      //     tokenInfo.patient_ImageUrl,
                      //     fit: BoxFit.fill,
                      //     width: screenWidth * 0.2,
                      //   ),
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.03,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          '${tokenInfo.patient_FullName}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.0525,
                            color: Colors.black,
                          ),
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.005,
                      ),
                      Container(
                        child: Text(
                          '${tokenInfo.bookedTokenTime.format(context)}',
                          style: TextStyle(
                            fontSize: screenWidth * 0.0475,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(114, 114, 114, 1),
                          ),
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.0001,
                ),
                Container(
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            _dateShowerInCalendar(
                              context,
                              tokenInfo.bookedTokenDate,
                            );
                          },
                          child: Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.0065,
                            ),
                            height: screenHeight * 0.05,
                            width: screenHeight * 0.040,
                            decoration: BoxDecoration(
                                // color: Color.fromRGBO(66, 204, 195, 1),
                                ),
                            child: Image(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                "assets/images/Calendar.png",
                              ),
                              color: Color.fromRGBO(108, 117, 125, 1),
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.19,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02,
                            vertical: screenWidth * 0.01,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.5),
                            color: Color.fromRGBO(66, 204, 195, 1),
                          ),
                          child: Text(
                            "${DateFormat.MMMd().format(tokenInfo.bookedTokenDate).toString()}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _dateShowerInCalendar(BuildContext context, DateTime givenTime) {
    showDatePicker(
      context: context,
      firstDate: givenTime,
      initialDate: givenTime,
      lastDate: givenTime,
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        } else {}
      },
    );
  }
}
