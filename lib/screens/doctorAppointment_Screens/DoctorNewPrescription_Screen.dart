// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unnecessary_new, unused_element, unused_import, must_be_immutable, unused_local_variable, deprecated_member_use, unnecessary_null_comparison, unnecessary_import

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:doctor/models/token_info.dart';
import 'package:doctor/providers/doctorPrescriptionPdf_details.dart';
import 'package:doctor/providers/doctorUpcomingAppointments_details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/medicine_info.dart';
import '../../providers/doctorAuth_details.dart';
import '../../providers/doctorUser_details.dart';

class DoctorNewPrescriptionScreen extends StatefulWidget {
  static const routeName = '/doctor-new-prescription-screen';

  int pageIndex;
  BookedTokenSlotInformation tokenInfo;

  DoctorNewPrescriptionScreen(
    this.pageIndex,
    this.tokenInfo,
  );

  @override
  State<DoctorNewPrescriptionScreen> createState() =>
      _DoctorNewPrescriptionScreenState();
}

class _DoctorNewPrescriptionScreenState
    extends State<DoctorNewPrescriptionScreen> {
  bool isLangEnglish = true;
  String dropdownvalue = 'Ayurvedic';
  late String Tabletname;
  late String FormofMedicine;
  bool value2 = false;
  bool value3 = false;
  bool value4 = false;
  bool value5 = false;
  bool isaddedmedicineclicked = false;
  TextEditingController KStrength = new TextEditingController();
  TextEditingController KTabletname = new TextEditingController();
  TextEditingController KFormofMedicine = new TextEditingController();
  TextEditingController Kdropdownvalue = new TextEditingController();
  TextEditingController KRemarks = new TextEditingController();
  TextEditingController KDosage = new TextEditingController();
  TextEditingController recommendedPathologicalTests =
      new TextEditingController();
  TextEditingController patientBloopPressure = new TextEditingController();
  TextEditingController patientBodyTemperature = new TextEditingController();
  late List<String> keys;
  String Remarks = "good";
  late String Strength;
  late String Dosage;
  Map<String, MedicinePrescribe> arr = {};
  late int clickedindex;

  String doctorRegistrationNumber = "";
  String doctorSignatureUrl = "";
  String doctorCancellationReason = "";

  List<String> WeekListEnglish = [
    "Mon",
    "Tues",
    "Wed",
    "Thr",
    "Fri",
    "Sat",
    "Sun"
  ];
  List<String> YearListEnglish = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  var items = [
    'Ayurvedic',
    'Allopathic',
    'Homeopathic',
    'Yog-Sadhana',
    'Unani',
    'Naturopathic',
    'Physiotherapy',
    'Dental',
    'General Medicine',
    'Veterinary',
  ];
  bool istrue = false;
  late Widget start;
  String name = "harsh";
  late double height;
  late double width;

  Map<String, String> userMapping = {};

  @override
  void initState() {
    super.initState();

    isLangEnglish = Provider.of<DoctorUserDetails>(context, listen: false)
        .isReadingLangEnglish;

    userMapping = Provider.of<DoctorUserDetails>(context, listen: false)
        .getDoctorUserPersonalInformation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    doctorRegistrationNumber =
        userMapping["doctor_MedicalRegistrationNumber"] ?? "";
    doctorSignatureUrl = userMapping["doctor_SignatureUrl"] ?? "";

    width = (MediaQuery.of(context).size.width);
    height = (MediaQuery.of(context).size.height);
    String pres = name;

    start = AddMedicine(
      context,
      height * 0.7,
      width,
      "Ayurvedic",
      "",
      "",
      "",
      "",
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff3f4f5),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          enableFeedback: false,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_circle_left_rounded,
            color: Color(0xff42ccc3),
            size: 35,
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/images/pres2.png'),
            onPressed: () => {},
          ),
        ],
        centerTitle: true,
        title: Text(
          isLangEnglish ? "New Prescription" : "नया नुस्खा",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.015,
            ),
            // Container(
            //   width: screenWidth * 0.9,
            //   margin: EdgeInsets.only(
            //     bottom: screenHeight * 0.01,
            //   ),
            //   alignment: Alignment.centerLeft,
            //   child: Text.rich(
            //     TextSpan(
            //       children: <TextSpan>[
            //         TextSpan(
            //           text: 'Patient Name',
            //           style: TextStyle(
            //             fontSize: 15,
            //             decoration: TextDecoration.underline,
            //             overflow: TextOverflow.ellipsis,
            //           ),
            //         ),
            //         TextSpan(
            //           text: ': ${widget.tokenInfo.patient_FullName}',
            //           style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 17.5,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            istrue
                ? Align(
                    child: Container(
                      width: screenWidth * 0.9,
                      child: Text(
                        isLangEnglish
                            ? "☞ Prescribed Medicines"
                            : "☞ निर्धारित दवाएं",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  )
                : Container(),
            istrue
                ? Align(
                    child: Container(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.085,
                      margin: EdgeInsets.only(
                        bottom: screenHeight * 0.015,
                      ),
                      child: Center(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: arr.length,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: () {
                                print("pressed");
                                setState(() {
                                  clickedindex = index;

                                  isaddedmedicineclicked = true;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: screenWidth * 0.45,
                                margin: EdgeInsets.all(7),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Container(
                                    child: Text.rich(
                                      TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '🔴  ',
                                            style: TextStyle(
                                              fontSize: 10.5,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '${keys.elementAt(index)}',
                                            style: TextStyle(
                                              fontSize: 12.5,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : Container(),

            // for(var x in arr.values)
            //   x

            Center(
              child: Container(
                // height: height * 0.8,
                child:
                    isaddedmedicineclicked ? ShowAddedMedicine(context) : start,
              ),
            ),
            Align(
              child: Center(
                child: Container(
                  width: screenWidth * 0.9,
                  child: Divider(
                    color: Colors.black,
                    thickness: 0.5,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Align(
              child: Container(
                width: screenWidth * 0.9,
                // padding: EdgeInsets.only(
                //   top: 0.02 * height,
                //   left: 0.02 * height,
                //   right: 0.1 * height,
                //   bottom: 0.01 * height,
                // ),
                child: Text(
                  isLangEnglish
                      ? "Blood Pressure & Temperature"
                      : "रक्त चाप और तापमान",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Align(
              child: Container(
                width: screenWidth * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: screenWidth * 0.4,
                      // padding: EdgeInsets.only(
                      //   // top: 0.01 * height,
                      //   left: 0.02 * height,
                      //   right: 0.03 * height,
                      // ),
                      child: TextField(
                        controller: patientBloopPressure,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          labelText: isLangEnglish ? 'BP' : "बीपी",
                          hintText: isLangEnglish ? 'BP' : "बीपी",
                        ),
                        onChanged: (text) {
                          // setState(() {

                          // });
                        },
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.4,
                      // padding: EdgeInsets.only(
                      //   // top: 0.02 * height,
                      //   left: 0.02 * height,
                      //   right: 0.03 * height,
                      // ),
                      child: TextField(
                        controller: patientBodyTemperature,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          labelText:
                              isLangEnglish ? 'Temperature(℃)' : "तापमान(℃)",
                          hintText:
                              isLangEnglish ? 'Temperature(℃)' : "तापमान(℃)",
                        ),
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Align(
              child: Container(
                width: screenWidth * 0.9,
                child: Text(
                  isLangEnglish
                      ? "Recommended Pathalogical Tests: "
                      : "अनुशंसित रोगविज्ञान संबंधी परीक्षण: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Align(
              child: Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.1,
                child: TextField(
                  controller: recommendedPathologicalTests,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),

                    // labelText: 'Form of Medicine',
                    // hintText: 'Type Form of Medicine ',
                  ),
                  onChanged: (text) {
                    Remarks = text;
                    this.Remarks = text;
                  },
                ),
              ),
            ),

            isaddedmedicineclicked
                ? Container()
                : Align(
                    child: Container(
                      alignment: Alignment.center,
                      width: screenWidth * 0.9,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff42CCC3),
                        ),
                        onPressed: () {
                          onnewpressed();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              isLangEnglish ? '+ ADD MEDICINE' : "+ दवा जोड़ें",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            isaddedmedicineclicked
                ? Container()
                : Align(
                    child: Container(
                      width: screenWidth * 0.9,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff42B3CC),
                        ),
                        onPressed: () {
                          // Provider.of<DoctorPrescriptionPdfDetails>(context,
                          //         listen: false)
                          //     .createDoctorPrescription(
                          //   context,
                          //   widget.tokenInfo,
                          //   arr,
                          // );

                          // if (Provider.of<DoctorUserDetails>(context,
                          //             listen: false)
                          //         .mp["doctor_SignatureUrl"] ==
                          //     "") {
                          //   String titleText = isLangEnglish
                          //       ? "Digital signature not found"
                          //       : "डिजिटल हस्ताक्षर नहीं मिला";
                          //   String contextText = isLangEnglish
                          //       ? "Please upload your digital signature"
                          //       : "कृपया अपना डिजिटल हस्ताक्षर अपलोड करें";
                          //   _checkForError(
                          //     context,
                          //     titleText,
                          //     contextText,
                          //   );
                          // } 
                          if (Provider.of<DoctorUserDetails>(context,
                                      listen: false)
                                  .mp["doctor_MedicalRegistrationNumber"] ==
                              "") {
                            String titleText = isLangEnglish
                                ? "Doctor registration number not found"
                                : "डॉक्टर पंजीकरण संख्या नहीं मिला";
                            String contextText = isLangEnglish
                                ? "Please upload your Doctor's registration number"
                                : "कृपया अपने डॉक्टर की पंजीकरण संख्या अपलोड करें";
                            _checkForError(
                              context,
                              titleText,
                              contextText,
                            );
                          } else if (arr.isEmpty) {
                            String titleText = isLangEnglish
                                ? "No Medicine prescribed"
                                : "कोई दवा निर्धारित नहीं है";
                            String contextText = isLangEnglish
                                ? "Precribe medicine for creating prescription"
                                : "पार्ची बनाने के लिए दवा लिखिए";
                            _checkForError(
                              context,
                              titleText,
                              contextText,
                            );
                          } else {
                            String titleText = isLangEnglish
                                ? "Create your prescription"
                                : "अपना नुस्खा बनाएं";
                            String contextText = isLangEnglish
                                ? "Are your sure all the details are correct?"
                                : "क्या आप सुनिश्चित हैं कि सभी विवरण सही हैं?";
                            _checkForPrescriptionPdfCreation(
                              context,
                              titleText,
                              contextText,
                            );
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              isLangEnglish ? '✅ PRESCRIBE' : "✅ प्रेसक्राइब",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: screenHeight * 0.025,
            ),
          ],
        ),
      ),
    );
  }

  void onnewpressed() {
    bool t = (value4 || value2 || value3 || value5);
    print(t);
    if (KTabletname.text == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            isLangEnglish ? "Medicine Already added " : "दवा जोड़ी जा चुकी है"),
      ));
    } else if (KTabletname.text != null &&
        KDosage != null &&
        KStrength != null &&
        KFormofMedicine != null &&
        t) {
      setState(() {
        istrue = true;

        //  String dropdownvalue,String Tabletname,String FormofMedicine,String Remarks,String Dosage,bool value2,bool value3,bool value4,bool value5
        MedicinePrescribe z = new MedicinePrescribe(
            FormofMedicine: KFormofMedicine.text,
            Tabletname: KTabletname.text,
            Dosage: KDosage.text,
            isdinner: value5,
            isafternoon: value4,
            isevening: value3,
            ismorning: value2,
            MedicineType: dropdownvalue,
            Strength: KStrength.text,
            Remarks: KRemarks.text);
        arr[Tabletname] = z;
        dropdownvalue = 'Ayurvedic';
        value2 = false;
        value3 = false;
        value4 = false;
        value5 = false;
        KTabletname.clear();
        KRemarks.clear();
        KDosage.clear();
        KStrength.clear();
        KFormofMedicine.clear();
        keys = arr.keys.toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(isLangEnglish ? "Fill all fields" : "सभी फ़ील्ड भरें"),
      ));
    }

    print(arr);
  }

  Widget AddMedicine(
    BuildContext context,
    double height,
    double width,
    String dropdownvalue,
    String Tabletname,
    String FormofMedicine,
    String Remarks,
    String Dosage,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              child: Container(
                width: screenWidth * 0.9,
                // padding: EdgeInsets.only(
                //   top: 0.01 * height,
                //   left: 0.02 * height,
                //   right: 0.1 * height,
                // ),
                child: Text(
                  isLangEnglish ? "Medicine Type: " : "दवा का प्रकार: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            Align(
              child: Container(
                width: screenWidth * 0.9,
                alignment: Alignment.topCenter,
                child: DropdownButtonFormField(
                  // style:TextStyle(),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText:
                        isLangEnglish ? 'Medicine Type' : "दवा का प्रकार",
                    hintText: isLangEnglish
                        ? 'Select Medicine Type'
                        : "दवा का प्रकार चुनें",
                  ),
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  value: dropdownvalue,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.tealAccent,
                  ),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                      this.dropdownvalue = newValue;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Align(
              child: Container(
                width: screenWidth * 0.9,
                // padding: EdgeInsets.only(
                //   top: 0.009 * height,
                //   left: 0.02 * height,
                //   right: 0.1 * height,
                // ),
                child: Text(
                  isLangEnglish ? "Medicine Name: " : "दवा का नाम:",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Align(
              child: Container(
                width: screenWidth * 0.9,
                // padding: EdgeInsets.only(
                //   top: 0.01 * height,
                //   left: 0.02 * height,
                //   right: 0.03 * height,
                // ),
                child: TextField(
                  controller: KTabletname,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: isLangEnglish ? 'Medicine Name' : "दवा का नाम",
                    hintText: isLangEnglish
                        ? 'Type Medicine Name'
                        : "दवा का नाम टाइप करें",
                  ),
                  onChanged: (text) {
                    setState(() {
                      Tabletname = text;
                      this.Tabletname = text;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Align(
              child: Container(
                width: screenWidth * 0.9,
                // padding: EdgeInsets.only(
                //   top: 0.01 * height,
                //   left: 0.02 * height,
                //   right: 0.1 * height,
                //   bottom: 0.01 * height,
                // ),
                child: Text(
                  isLangEnglish
                      ? "Form of Medicine Prescribed:  "
                      : "निर्धारित दवा का रूप: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Align(
              child: Container(
                width: screenWidth * 0.9,
                // padding: EdgeInsets.only(
                //   left: 0.02 * height,
                //   right: 0.03 * height,
                // ),
                child: TextField(
                  controller: KFormofMedicine,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText:
                        isLangEnglish ? 'Form of Medicine' : "चिकित्सा का रूप",
                    hintText: isLangEnglish
                        ? 'Type Form of Medicine '
                        : "चिकित्सा का प्रकार",
                  ),
                  onChanged: (text) {
                    setState(() {
                      FormofMedicine = text;
                      this.FormofMedicine = text;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Align(
              child: Container(
                width: screenWidth * 0.9,
                // padding: EdgeInsets.only(
                //   top: 0.02 * height,
                //   left: 0.02 * height,
                //   right: 0.1 * height,
                //   bottom: 0.01 * height,
                // ),
                child: Text(
                  isLangEnglish ? "Strength & Dosage" : "शक्ति और खुराक",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Align(
              child: Container(
                width: screenWidth * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: screenWidth * 0.4,
                      // padding: EdgeInsets.only(
                      //   // top: 0.01 * height,
                      //   left: 0.02 * height,
                      //   right: 0.03 * height,
                      // ),
                      child: TextField(
                        controller: KStrength,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          labelText: isLangEnglish ? 'Strength' : "ताकत",
                          // hintText: 'Type Strength of the Medicine ',
                        ),
                        onChanged: (text) {
                          setState(() {
                            Strength = text;
                            Strength = text;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.4,
                      // padding: EdgeInsets.only(
                      //   // top: 0.02 * height,
                      //   left: 0.02 * height,
                      //   right: 0.03 * height,
                      // ),
                      child: TextField(
                        controller: KDosage,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          labelText: isLangEnglish ? 'Dosage' : "दवा की खुराक",
                          hintText: isLangEnglish
                              ? 'Type Dosage '
                              : "खुराक टाइप करें ",
                        ),
                        onChanged: (text) {
                          setState(() {
                            Dosage = text;
                            this.Dosage = text;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(children: [
              Container(
                padding: EdgeInsets.only(left: 0.01 * height),
                child: Checkbox(
                  checkColor: Colors.white,
                  activeColor: Color(0xff42ccc3),
                  value: value2,
                  onChanged: (bool? value2) {
                    setState(() {
                      value2 = value2!;
                      this.value2 = value2!;
                    });
                  },
                ),
              ),
              Container(
                child: Text(
                  isLangEnglish ? 'Morning ' : "सुबह",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 0.11 * height),
                child: Checkbox(
                  checkColor: Colors.white,
                  activeColor: Color(0xff42ccc3),
                  value: value3,
                  onChanged: (bool? value3) {
                    setState(() {
                      value3 = value3!;
                      this.value3 = value3!;
                    });
                  },
                ),
              ),
              Container(
                child: Text(
                  isLangEnglish ? 'Evening' : "शाम",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ), //Text
            ] // , //<Widget>[]
                ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 0.01 * height),
                  child: Checkbox(
                    checkColor: Colors.white,
                    activeColor: Color(0xff42ccc3),
                    value: value4,
                    onChanged: (bool? value) {
                      setState(() {
                        value4 = value!;
                        value4 = value;
                      });
                    },
                  ),
                ),
                Container(
                  child: Text(
                    isLangEnglish ? 'Afternoon' : "दोपहर बाद",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 0.1 * height),
                  child: Checkbox(
                    checkColor: Colors.white,
                    activeColor: Color(0xff42ccc3),
                    value: value5,
                    onChanged: (bool? value5) {
                      setState(() {
                        this.value5 = value5!;
                      });
                    },
                  ),
                ),
                Container(
                  child: Text(
                    isLangEnglish ? 'Dinner' : "रात का खाना",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ), //Text
                //SizedBox
              ], //<Widget>[]
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Align(
              child: Container(
                width: screenWidth * 0.9,
                child: Text(
                  isLangEnglish ? "Medicine Remarks: " : "दवा टिप्पणियां: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Align(
              child: Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.1,
                child: TextField(
                  controller: KRemarks,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),

                    // labelText: 'Form of Medicine',
                    // hintText: 'Type Form of Medicine ',
                  ),
                  onChanged: (text) {
                    Remarks = text;
                    this.Remarks = text;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // static Widget buildTitle(PrescriptionDetails invoide) => Column();

  Widget TextShowingFieldContainer(
    BuildContext context,
    String labelText,
    String contentText,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    TextEditingController existingText = TextEditingController();
    existingText.text = contentText;

    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white70,
          // color: Color.fromRGBO(66, 204, 195, 1),
        ),
        margin: EdgeInsets.symmetric(
          vertical: screenHeight * 0.0015,
          // horizontal: screenWidth * 0.00125,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.01,
        ),
        height: screenHeight * 0.1,
        width: screenWidth * 0.95,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: screenWidth * 0.775,
              child: TextFormField(
                autocorrect: true,
                autofocus: true,
                enabled: false,
                controller: existingText,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: labelText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ShowAddedMedicine(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    MedicinePrescribe med = arr[keys[clickedindex]]!;
    String timing = "";
    if (med.ismorning) timing += isLangEnglish ? ",morning " : ",प्रभात";
    if (med.isevening) timing += isLangEnglish ? ",evening " : ",शाम ";
    if (med.isdinner) timing += isLangEnglish ? ",dinner " : ",रात का खाना ";
    if (med.isafternoon) timing += isLangEnglish ? ",Afternoon" : ",दोपहर बाद ";

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextShowingFieldContainer(
            context,
            isLangEnglish ? "Medicine Type" : "दवा का प्रकार",
            med.MedicineType,
          ),
          TextShowingFieldContainer(
            context,
            isLangEnglish ? "Medicine Name" : "दवा का नाम",
            med.Tabletname,
          ),
          TextShowingFieldContainer(
            context,
            isLangEnglish ? "Form of Medicine" : "चिकित्सा का रूप",
            med.FormofMedicine,
          ),
          TextShowingFieldContainer(
            context,
            isLangEnglish ? "Strength" : "ताकत",
            med.Strength,
          ),
          TextShowingFieldContainer(
            context,
            isLangEnglish ? "Dosage" : "दवा की खुराक",
            med.Dosage,
          ),
          // SizedBox(
          //   width: screenWidth * 0.015,
          // ),
          TextShowingFieldContainer(
            context,
            isLangEnglish ? "Dose Timings" : "खुराक का समय",
            timing,
          ),
          TextShowingFieldContainer(
            context,
            isLangEnglish ? "Medicine Remarks" : "दवा टिप्पणियां",
            med.Remarks,
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.95,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff42B3CC),
                ),
                onPressed: () {
                  setState(() {
                    arr.remove(med.Tabletname);

                    if (arr.isEmpty) {
                      print(arr.isEmpty);
                      istrue = false;
                    }
                    print(arr);
                    keys = arr.keys.toList();
                    isaddedmedicineclicked = false;
                  });
                },
                child: Container(
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        isLangEnglish ? 'Delete' : "मिटाना",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _checkForPrescriptionPdfCreation(
      BuildContext context, String titleText, String contextText,
      {bool popVal = false}) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

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
              if (popVal == false) {
                Provider.of<DoctorPrescriptionPdfDetails>(context,
                        listen: false)
                    .createDoctorPrescription(
                  context,
                  widget.tokenInfo,
                  arr,
                  recommendedPathologicalTests,
                  patientBloopPressure,
                  patientBodyTemperature,
                  doctorRegistrationNumber,
                  doctorSignatureUrl,
                );
                Navigator.pop(ctx);
              }
            },
            tooltip: "YES",
          ),
          IconButton(
            icon: Icon(
              Icons.dangerous_rounded,
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
            tooltip: "NO",
          ),
        ],
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
            tooltip: "OK",
          ),
        ],
      ),
    );
  }
}

// class MedicinePrescribe {
//   late String MedicineType;
//   late String Tabletname;
//   late String Remarks;

//   late String FormofMedicine;
//   late String Dosage;
//   late String Strength;
//   late bool isevening;
//   late bool isdinner;
//   late bool ismorning;
//   late bool isafternoon;

//   MedicinePrescribe({
//     required this.FormofMedicine,
//     required this.Tabletname,
//     required this.Dosage,
//     required this.isdinner,
//     required this.isafternoon,
//     required this.isevening,
//     required this.ismorning,
//     required this.Remarks,
//     required this.MedicineType,
//     required this.Strength,
//   });
// }
