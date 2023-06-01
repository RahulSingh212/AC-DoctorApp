// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, use_key_in_widget_constructors, duplicate_import, unused_import, unused_local_variable, must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// import 'package:jitsi_meet/jitsi_meet.dart';
// import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:auth/auth.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../Jitsi_meet.dart';
import '../../models/token_info.dart';
import '../../providers/doctorUser_details.dart';
import 'message_bubble.dart';

class MessageBox extends StatefulWidget {
  String link;
  BookedTokenSlotInformation tokenInfo;
  MessageBox(this.link, this.tokenInfo);

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  bool isLangEnglish = true;
  String duid = "";
  String dName = "";

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    final fbm = FirebaseMessaging.instance;

    fbm.requestPermission();

    isLangEnglish = Provider.of<DoctorUserDetails>(context, listen: false)
        .isReadingLangEnglish;
    duid = Provider.of<DoctorUserDetails>(context, listen: false)
            .mp['doctor_personalUniqueIdentificationId'] ??
        "";
    dName = Provider.of<DoctorUserDetails>(context, listen: false)
            .mp['doctor_FullName'] ??
        "";
  }

  void _sendMessage() async {
    FocusScope.of(context).unfocus();

    // final loggedInUserId = await FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance.collection('${widget.link}').add(
      {
        'text':
            isLangEnglish ? 'Joined the meet' : 'बैठक में शामिल हो गया हूं।',
        // 'text': "https://meet.jit.si/${puid}-${widget.tokenInfo.doctor_personalUniqueIdentificationId}-${widget.tokenInfo.registeredTokenId}",
        'createdAt': Timestamp.now(),
        'doctorUserId': Provider.of<DoctorUserDetails>(context, listen: false)
                .getDoctorUserPersonalInformation()[
            "doctor_personalUniqueIdentificationId"],
        'patientUserId': '',
      },
    );
  }

  void getPatientMobileToken(String patientUserId) async {
    String patientMobileToken = "";

    var response = await FirebaseFirestore.instance
        .collection('PatientUsersPersonalInformation')
        .doc(patientUserId)
        .get()
        .then(
      (DocumentSnapshot ds) {
        patientMobileToken =
            ds.get('patient_MobileMessagingTokenId').toString();

        if (patientMobileToken != "") {
          String doctorName =
              Provider.of<DoctorUserDetails>(context, listen: false)
                  .mp["doctor_FullName"]
                  .toString();
          String notificationTitle = "Doctor: $doctorName joined the meet";
          String notificationBody =
              "Appointment Details:\nTime: ${widget.tokenInfo.bookedTokenTime.format(context).toString()}\nDate: ${DateFormat.yMMMMd('en_US').format(widget.tokenInfo.bookedTokenDate)}";

          sendPushMessage(
            patientMobileToken,
            notificationBody,
            notificationTitle,
          );
        }
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
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var avlScreenHeight = screenHeight - topInsets - bottomInsets;

    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height = (MediaQuery.of(context).size.height) - _padding.top;

    // String patientFullName = Provider.of<DoctorUserDetails>(context, listen: false)
    //             .getDoctorUserPersonalInformation()["doctor_FullName"] ??
    //         "";
    String patientFullName = widget.tokenInfo.patient_FullName;
    String doctorFullName = widget.tokenInfo.doctorFullName;

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(66, 204, 195, 1),
        centerTitle: false,
        title: Row(
          children: <Widget>[
            Container(
              height: screenWidth * 0.085,
              width: screenWidth * 0.085,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
              ),
              child: CircleAvatar(
                radius: screenWidth * 0.6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    screenWidth * 0.6,
                  ),
                  child: ClipOval(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: widget.tokenInfo.patient_ImageUrl == ""
                          ? Image.asset(
                              "assets/images/healthy.png",
                            )
                          : Image.network(
                              widget.tokenInfo.patient_ImageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.03,
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Container(
                width: screenWidth * 0.35,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    widget.tokenInfo.patient_FullName,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Row(
            children: [
              Container(
                child: IconButton(
                  onPressed: () {
                    String roomText =
                        "${widget.tokenInfo.patient_personalUniqueIdentificationId}-${duid}";
                    String subjectText = isLangEnglish
                        ? "Appointment with doctor"
                        : "डॉक्टर के साथ नियुक्ति";
                    String userDisplayNameText =
                        widget.tokenInfo.doctorFullName;
                    String userEmailText = "user@gmail.com";

                    getPatientMobileToken(widget.tokenInfo.patient_personalUniqueIdentificationId);
                    joinMeeting(roomText, subjectText, userDisplayNameText,
                        userEmailText);
                    // _sendMessage();
                  },
                  icon: Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.01,
              ),
              Container(
                child: IconButton(
                  onPressed: () {
                    String roomText =
                        // "WelcomeConstitutionsIntroduceWorldwide";
                        "${widget.tokenInfo.patient_personalUniqueIdentificationId}-${duid}";
                    String subjectText = isLangEnglish
                        ? "Appointment with doctor"
                        : "डॉक्टर के साथ नियुक्ति";
                    String userDisplayNameText =
                        widget.tokenInfo.doctorFullName;
                    String userEmailText = "user@gmail.com";
                    
                    getPatientMobileToken(widget.tokenInfo.patient_personalUniqueIdentificationId);
                    joinMeeting(roomText, subjectText, userDisplayNameText,
                        userEmailText);
                    // _sendMessage();
                  },
                  icon: Icon(
                    Icons.video_call,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.01,
              ),
            ],
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('${widget.link}')
            .orderBy(
              'createdAt',
              descending: true,
            )
            .snapshots(),
        builder: (BuildContext ctx, AsyncSnapshot streamSnapShot) {
          if (streamSnapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final chatDocs = streamSnapShot.data.docs;
            return ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (ctx, index) {
                // return Container(
                //   child: Text(
                //     chatDocs[index]['text'],
                //   ),
                // );
                return MessageBubble(
                  chatDocs[index]['text'],
                  // chatDocs[index]['doctorUserId'] ==
                  //     Provider.of<DoctorUserDetails>(context, listen: false)
                  //             .getDoctorUserPersonalInformation()[
                  //         "doctor_personalUniqueIdentificationId"],
                  chatDocs[index]['doctorUserId'] ==
                      widget.tokenInfo.doctor_personalUniqueIdentificationId,
                  ValueKey(
                    chatDocs[index],
                  ),
                  chatDocs[index]['createdAt'],
                  patientFullName,
                  doctorFullName,
                );
              },
            );
          }
        },
      ),
    );
  }
}
