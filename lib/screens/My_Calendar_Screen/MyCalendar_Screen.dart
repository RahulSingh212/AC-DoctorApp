// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, dead_code, unnecessary_string_interpolations, avoid_unnecessary_containers, unnecessary_this, sized_box_for_whitespace, unused_element, unused_local_variable, unused_import

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:doctor/models/slot_info.dart';
import 'package:doctor/screens/MyCalender_ClinicSlots.dart';
import 'package:doctor/screens/My_Calendar_Screen/Doctor_Appointment_Slots.dart';
import 'package:doctor/screens/My_Calendar_Screen/EditSlot_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weekday_selector/weekday_selector.dart';

import '../../providers/doctorAuth_details.dart';
import '../../providers/doctorUser_details.dart';
import '../../../providers/doctorCalendar_details.dart';

class MyCalendarScreenDoctor extends StatefulWidget {
  static const routeName = '/doctor-my-calendar-screen';

  @override
  State<MyCalendarScreenDoctor> createState() => _MyCalendarScreenDoctorState();
}

class _MyCalendarScreenDoctorState extends State<MyCalendarScreenDoctor> {
  bool isLangEnglish = true;
  late BuildContext updatedContext;
  int? currentselectedIndex;
  List<MyCalendar_ClinicSlots> arr = [];

  var _isInit = true;

  @override
  void initState() {
    super.initState();

    isLangEnglish = Provider.of<DoctorUserDetails>(context, listen: false)
        .isReadingLangEnglish;
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<DoctorCalendarDetails>(context)
          .fetchDoctorAvailableSlots(context);
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  Future<void> _refreshDoctorAvailableSlots(BuildContext context) async {
    await Provider.of<DoctorCalendarDetails>(context, listen: false)
        .fetchDoctorAvailableSlots(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = (MediaQuery.of(context).size.width);
    double screenHeight = (MediaQuery.of(context).size.height);

    var userInfoDetails = Provider.of<DoctorUserDetails>(context);
    Map<String, String> userMapping =
        userInfoDetails.getDoctorUserPersonalInformation();
    var slotsInfoData = Provider.of<DoctorCalendarDetails>(context);

    String imageNetworkUrl = userMapping["doctor_ProfilePicUrl"] ?? "";

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: screenHeight * 0.035,
                bottom: screenHeight * 0.01,
                left: screenWidth * 0.06,
                right: screenWidth * 0.06,
              ),
              height: screenHeight * 0.245,
              width: screenWidth,
              // color: AppColors.AppmainColor,
              color: Color.fromRGBO(66, 204, 195, 1),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.005,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            right: screenWidth * 0.005,
                          ),
                          height: screenHeight * 0.165,
                          width: screenWidth * 0.325,
                          child: CircleAvatar(
                            radius: screenWidth,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 7.5,
                                  color: Colors.white,
                                ),
                                borderRadius:
                                    BorderRadius.circular(2 * screenWidth),
                                // image: DecorationImage(
                                //   image: AssetImage("assets/images/surgeon.png"),
                                //   fit: BoxFit.cover,
                                // ),
                              ),
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
                                          borderRadius:
                                              BorderRadius.circular(100),
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
                        ),
                        Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  // decoration: BoxDecoration(
                                  //   color: Colors.white,
                                  //   borderRadius: BorderRadius.circular(6),
                                  // ),
                                  child: Center(
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Container(
                                        width: screenWidth * 0.5,
                                        height: screenHeight * 0.075,
                                        child: DefaultTextStyle(
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                          child: Text(
                                            "${userMapping['doctor_FullName']}",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.01,
                                    horizontal: screenWidth * 0.05,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.5),
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    isLangEnglish
                                        ? "My Schedule"
                                        : 'मेरा शेड्यूल',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color(
                                        0xff42ccc3,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.065,
                vertical: screenHeight * 0.01,
              ),
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: isLangEnglish
                          ? 'Patients will be shown slots you create for '
                          : "मरीजों को आपके द्वारा बनाए गए स्लॉट दिखाए जाएंगे ",
                      style: TextStyle(
                        color: Color.fromRGBO(108, 117, 125, 1),
                      ),
                    ),
                    TextSpan(
                      text: isLangEnglish
                          ? 'the next two weeks.'
                          : "अगले दो सप्ताह।",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(108, 117, 125, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   alignment: Alignment.bottomRight,
            //   padding: EdgeInsets.only(
            //     left: screenWidth * 0.065,
            //     right: screenWidth * 0.065,
            //     top: screenHeight * 0.0025,
            //   ),
            //   child: InkWell(
            //     onTap: () {},
            //     child: Text(
            //       "Edit for specific date",
            //       style: TextStyle(
            //         decoration: TextDecoration.underline,
            //         color: Colors.blue,
            //       ),
            //     ),
            //   ),
            // ),

            slotsInfoData.items.isEmpty
                ? RefreshIndicator(
                    onRefresh: () => _refreshDoctorAvailableSlots(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 254, 229, 0.9),
                      ),
                      // margin: EdgeInsets.only(
                      //   left: screenWidth * 0.0125,
                      //   right: screenWidth * 0.0125,
                      //   top: screenHeight * 0.00625,
                      //   bottom: screenHeight * 0.00625,
                      // ),
                      child: Card(
                        // color: Color.fromRGBO(255, 254, 229, 0.9),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        // elevation: 1.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              height: screenHeight * 0.6,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.1,
                              ),
                              child: Text(
                                isLangEnglish
                                    ? 'No Appointments Available!'
                                    : "कोई अपॉइंटमेंट उपलब्ध नहीं है!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: screenWidth * 0.07,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Align(
                    child: Container(
                    height: screenHeight * 0.605,
                    width: screenWidth,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.01,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: slotsInfoData.items.length + 1,
                      itemBuilder: (ctx, index) {
                        if (index < slotsInfoData.items.length) {
                          return CalendarAppointmentDetailsWidgets(
                            context,
                            slotsInfoData.items[index],
                          );
                        } else {
                          return SizedBox(
                            height: screenHeight * 0.05,
                          );
                        }
                      },
                    ),
                  ))

            // Container(
            //   margin: EdgeInsets.only(
            //     top: screenHeight * 0.005,
            //   ),
            //   height: screenHeight * 0.6,
            //   width: screenWidth,
            //   child: slotsInfoData.items.isEmpty
            //       ? RefreshIndicator(
            //           onRefresh: () => _refreshDoctorAvailableSlots(context),
            //           child: Container(
            //             decoration: BoxDecoration(
            //               color: Color.fromRGBO(255, 254, 229, 0.9),
            //             ),
            //             // margin: EdgeInsets.only(
            //             //   left: screenWidth * 0.0125,
            //             //   right: screenWidth * 0.0125,
            //             //   top: screenHeight * 0.00625,
            //             //   bottom: screenHeight * 0.00625,
            //             // ),
            //             child: Card(
            //               // color: Color.fromRGBO(255, 254, 229, 0.9),
            //               color: Colors.white,
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(15),
            //               ),
            //               // elevation: 1.5,
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 crossAxisAlignment: CrossAxisAlignment.stretch,
            //                 children: <Widget>[
            //                   Container(
            //                     alignment: Alignment.center,
            //                     padding: EdgeInsets.symmetric(
            //                       horizontal: screenWidth * 0.1,
            //                     ),
            //                     child: Text(
            //                       isLangEnglish
            //                           ? 'No Appointments Available!'
            //                           : "कोई अपॉइंटमेंट उपलब्ध नहीं है!",
            //                       textAlign: TextAlign.center,
            //                       style: TextStyle(
            //                         fontWeight: FontWeight.bold,
            //                         fontStyle: FontStyle.italic,
            //                         fontSize: screenWidth * 0.07,
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         )
            //       : Container(
            //           width: screenWidth,
            //           padding: EdgeInsets.symmetric(
            //             horizontal: screenWidth * 0.01,
            //           ),
            //           child: ListView.builder(
            //             itemCount: slotsInfoData.items.length+1,
            //             itemBuilder: (ctx, index) {
            //               if (index < slotsInfoData.items.length) {
            //                 return CalendarAppointmentDetailsWidgets(
            //                 context,
            //                 slotsInfoData.items[index],
            //               );
            //               }
            //               else {
            //                 return SizedBox(
            //                   height: screenHeight * 0.05,
            //                 );
            //               }

            //             },
            //           ),
            //         ),
            // )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(DoctorAppointmentSlot.routeName);
          // CreateNewAppointmentDetails(context);
        },
        backgroundColor: Color.fromRGBO(66, 204, 195, 1),
        child: Icon(
          Icons.add,
          color: Colors.green,
          size: screenWidth * 0.1,
        ),
      ),
    );
  }

  Widget CalendarAppointmentDetailsWidgets(
    BuildContext context,
    DoctorSlotInformation slotInfoDetails,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var avlScreenHeight = screenHeight - topInsets - bottomInsets;

    return InkWell(
      onTap: () {},
      // splashColor: Theme.of(context).primaryColorDark,

      child: Card(
        elevation: 2.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: Color.fromRGBO(242, 242, 242, 1),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.5),
            color: Colors.white70,
          ),
          height: slotInfoDetails.isRepeat
              ? screenHeight * 0.44
              : screenHeight * 0.365,
          width: screenWidth * 0.9,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.0125,
            vertical: screenWidth * 0.025,
          ),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: screenHeight * 0.055,
                width: screenWidth * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Material(
                            color: Colors.white,
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor:
                                    Color.fromRGBO(120, 158, 156, 1),
                              ),
                              child: Checkbox(
                                activeColor: Color.fromRGBO(120, 158, 156, 1),
                                checkColor: Colors.white,
                                value: slotInfoDetails.isClinic,
                                onChanged: (bool? value) {},
                              ),
                            ),
                          ),
                          Text(isLangEnglish ? 'Clinic' : "क्लिनिक"),
                          SizedBox(
                            width: screenWidth * 0.005,
                          ),
                          Material(
                            color: Colors.white,
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor:
                                    Color.fromRGBO(120, 158, 156, 1),
                              ),
                              child: Checkbox(
                                activeColor: Color.fromRGBO(120, 158, 156, 1),
                                checkColor: Colors.white,
                                value: slotInfoDetails.isVideo,
                                onChanged: (bool? value) {},
                              ),
                            ),
                          ),
                          Text(isLangEnglish ? 'Video' : "वीडियो"),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   width: screenWidth * 0.3,
                    // ),
                    InkWell(
                      onTap: () {
                        _dateShowerInCalendar(
                          context,
                          slotInfoDetails.registeredDate,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.0065,
                        ),
                        height: screenHeight * 0.055,
                        width: screenHeight * 0.035,
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
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.025,
                  // vertical: screenHeight * 0.00625,
                ),
                height: screenHeight * 0.1125,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: screenHeight * 0.1,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: screenWidth * 0.325,
                              height: screenHeight * 0.06,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 2,
                                  color: Color(0xffCDCDCD),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: screenWidth * 0.025,
                                horizontal: screenWidth * 0.05,
                              ),
                              child: Text(
                                "${slotInfoDetails.startTime.format(context)}",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.004,
                          ),
                          Container(
                            child: Text(isLangEnglish ? 'Start' : "शुरू"),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 20,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffCDCDCD),
                          width: 1.5,
                        ),
                      ),
                    ),
                    Container(
                      height: screenHeight * 0.1,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: screenWidth * 0.325,
                              height: screenHeight * 0.06,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 2,
                                  color: Color(0xffCDCDCD),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: screenWidth * 0.025,
                                horizontal: screenWidth * 0.05,
                              ),
                              child: Text(
                                "${slotInfoDetails.endTime.format(context)}",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.004,
                          ),
                          Container(
                            child: Text(isLangEnglish ? 'End' : "समाप्त"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.035,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: isLangEnglish
                              ? 'Appointment Fees: '
                              : "अपॉइंटमेंट फीस ",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        TextSpan(
                          text:
                              '₹ ${slotInfoDetails.appointmentFeesPerPatient}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: screenWidth * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: screenWidth * 0.4,
                      child: CheckboxListTile(
                        title: Text(isLangEnglish ? "Repeat" : "दोहराएं"),
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: Color.fromRGBO(120, 158, 156, 1),
                        checkColor: Colors.white,
                        value: slotInfoDetails.isRepeat,
                        onChanged: (bool? value) {},
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.4,
                      child: slotInfoDetails.isRepeat
                          ? SizedBox(width: 0)
                          : Text(
                              "Exp: ${DateFormat.yMMMMd('en_US').format(slotInfoDetails.expiredDate)}",
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                              ),
                              textAlign: ui.TextAlign.right,
                            ),
                    ),
                  ],
                ),
              ),
              slotInfoDetails.isRepeat
                  ? weekDayShowerWidget(
                      context,
                      slotInfoDetails.repeatWeekDaysList,
                    )
                  : SizedBox(
                      height: 0,
                    ),
              SizedBox(
                height: screenHeight * 0.005,
              ),
              Container(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditDoctorAppointmentSlotScreen(
                          docSlotInfo: slotInfoDetails,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: screenWidth * 0.9,
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.0125,
                      horizontal: screenWidth * 0.01,
                    ),
                    decoration: BoxDecoration(
                      // color: Color(0xff42CCC3),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: Color(0xffCDCDCD),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        isLangEnglish ? "Edit" : "एडिट करें",
                        style: TextStyle(
                          color: Colors.black,
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
    );
  }

  Widget weekDayShowerWidget(BuildContext context, List<bool> selectedDays) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    var weekDaySelected = selectedDays;

    return Container(
      child: WeekdaySelector(
        color: Color.fromRGBO(120, 158, 156, 1),
        selectedColor: Color.fromRGBO(120, 158, 156, 1),
        elevation: 3,
        fillColor: Colors.white,
        selectedFillColor: Color.fromRGBO(220, 229, 228, 1),
        onChanged: (int day) {},
        values: weekDaySelected,
      ),
    );
  }

  Widget allWeakdaysWidget(
      BuildContext context, bool isRepeat, bool isClicked, bool isSaved) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    Color blacText = Color(0xff789E9C);
    Color blacweek = Color(0xffDCE5E4);
    Color blacbox = Color(0xff789E9C);
    Map<String, bool> RepeatedDays = {
      "M": false,
      "T": false,
      "W": false,
      "Th": false,
      "F": false,
      "S": false,
      "Su": false
    };
    List<String> days = ["M", "T", "W", "Th", "F", "S", "Su"];

    return isRepeat
        ? Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: screenHeight * 0.07,
                child: Wrap(
                  children: List.generate(
                    7,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isClicked) {
                              if (isSaved == false) {
                                RepeatedDays[days[index]] =
                                    !(RepeatedDays[days[index]]!);
                              }
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(8),
                          child: Text(
                            days[index],
                            style: TextStyle(
                              fontSize: 12.5,
                              color: isClicked ? Color(0xff42CCC3) : blacText,
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffCDCDCD),
                            ),
                            borderRadius: BorderRadius.circular(100),
                            color: ((RepeatedDays[days[index]])!)
                                ? (isClicked
                                    ? Color(0xffdef8f5)
                                    : Color(0xffDCE5E4))
                                : Color(0xffffffff),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              isSaved == false
                  ? Container(
                      padding: EdgeInsets.only(
                        right: screenWidth * 0.025,
                        left: screenWidth * 0.025,
                      ),
                      child: Text(
                        "Please choose the time in which you are available in your Clinic.",
                        style: TextStyle(
                          color: Color(0xff6C757D),
                        ),
                      ),
                    )
                  : Container(
                      height: 0,
                    ),
            ],
          )
        : Container(
            height: 0,
          );
  }

  void TimePicker(BuildContext context, TimeOfDay timechosen) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: timechosen,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(primaryColor: Color(0xff42CCC3)),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: false,
            ),
            child: Directionality(
              textDirection: ui.TextDirection.ltr,
              child: child!,
            ),
          ),
        );
      },
    );
    if (time != null) {
      setState(() {
        timechosen = time;
      });
    }
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
