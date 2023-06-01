// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_new, unused_field, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unused_local_variable, unused_import, import_of_legacy_library_into_null_safe, unused_element

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/screens/Home_Screen.dart';
import 'package:doctor/screens/MyProfile_Screen.dart';
import 'package:doctor/screens/MySettings_Screen.dart';
import 'package:doctor/screens/Tabs_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:open_file/open_file.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/doctorAuth_details.dart';
import '../providers/doctorUser_details.dart';

class MyProfileScreen extends StatefulWidget {
  static const routeName = '/doctor-my-profile-screen';

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  bool isLangEnglish = true;

  @override
  void initState() {
    super.initState();
    isLangEnglish = Provider.of<DoctorUserDetails>(context, listen: false)
        .isReadingLangEnglish;
  }

  File _profilePicture = new File("");
  bool _isProfilePicTaken = false;

  File _signaturePicture = new File("");
  bool _isDigitalSignatureTaken = false;

  File _documentFile = new File("");
  bool _isDocumentFileTaken = false;
  String docFileName = "";
  String docFileBytes = "";
  String docFileSize = "";
  String docFileExtentionType = "";
  String docFileLocation = "";

  bool isSaveChangesBtnActive = false;

  Map<String, bool> editBtnMapping = {
    "doctor_MedicalRegistrationNumber": false,
    "doctor_FullName": false,
    "doctor_Gender": false,
    "doctor_PhoneNumber": false,
    "doctor_YearsOfExperience": false,
    "doctor_EducationQualification": false,
    "doctor_MedicineType": false,
    "doctor_Speciality": false,
    "doctor_CurrentCity": false,
    "doctor_CurrentCityPinCode": false,
    "doctor_RegistrationDetails": false,
  };

  Map<String, String> userMapping = {};
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userMapping = Provider.of<DoctorUserDetails>(context)
        .getDoctorUserPersonalInformation();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    bool isImageAvailable = false;
    final defaultImg = 'assets/images/surgeon.png';

    // var userInfoDetails = Provider.of<DoctorUserDetails>(context);
    // Map<String, String> userMapping =
    //     userInfoDetails.getDoctorUserPersonalInformation();

    String imageNetworkUrl = userMapping["doctor_ProfilePicUrl"] ?? "";
    String doctorSignatureUrl = userMapping["doctor_SignatureUrl"] ?? "";
    String documentFileNetworkUrl =
        userMapping["doctor_AuthenticationCertificateUrl"] ?? "";

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            // color: Colors.amber,
            height: screenHeight * 0.3,
            margin: EdgeInsets.only(
              left: screenWidth * 0.0125,
              right: screenWidth * 0.0125,
              // top: screenHeight * 0.01,
              bottom: screenHeight * 0.005,
            ),
            padding: EdgeInsets.only(
              left: screenWidth * 0.015,
              right: screenWidth * 0.015,
              top: screenHeight * 0.0075,
              bottom: screenHeight * 0.001,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(TabsScreenDoctor.routeName);
                  },
                  iconSize: 30,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                  ),
                ),
                Container(
                  // color: Colors.grey,
                  height: screenHeight * 0.25,
                  width: screenWidth * 0.45,
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.01,
                    horizontal: screenWidth * 0.01,
                  ),
                  child: Column(
                    children: [
                      Container(
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
                                  child: _isProfilePicTaken
                                      ? Image.file(
                                          _profilePicture,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        )
                                      : imageNetworkUrl == ""
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
                      SizedBox(
                        height: screenHeight * 0.005,
                      ),
                      Container(
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.05,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              color: Color(0xff42ccc3),
                            ),
                          ),
                          onPressed: () {
                            if (_isProfilePicTaken) {
                              Provider.of<DoctorUserDetails>(context,
                                      listen: false)
                                  .updateDoctorProfilePicture(
                                context,
                                _profilePicture,
                              );
                            } else {
                              _seclectImageUploadingType(
                                context,
                                isLangEnglish
                                    ? "Set your Profile Picture"
                                    : "अपनी प्रोफाइल पिक्चर सेट करो",
                                isLangEnglish ? "Image Picker" : "छवि पिकर",
                                imageNetworkUrl,
                              );
                            }
                          },
                          child: Text(
                            !_isProfilePicTaken
                                ? isLangEnglish
                                    ? 'CHANGE PHOTO'
                                    : "तस्वीर बदलिये"
                                : isLangEnglish
                                    ? "SAVE PHOTO"
                                    : "तस्वीर को सेव करें",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff42ccc3),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(MySettingsScreen.routeName);
                  },
                  iconSize: 30,
                  icon: const Icon(
                    Icons.settings,
                  ),
                ),
              ],
            ),
          ),

          Container(
            alignment: Alignment.center,
            width: screenWidth * 0.9,
            padding: EdgeInsets.symmetric(
              // vertical: screenHeight * 0.0125,
              horizontal: screenWidth * 0.01,
            ),
            child: Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: isLangEnglish
                        ? 'Authorization Status: '
                        : "प्राधिकरण स्थिति:",
                    style: TextStyle(
                      color: Color.fromRGBO(108, 117, 125, 1),
                    ),
                  ),
                  TextSpan(
                    text: documentFileNetworkUrl == ""
                        ? isLangEnglish
                            ? "Upload Document!"
                            : "दस्तावेज़ अपलोड करें!"
                        : userMapping["doctor_AutherizationStatus"]!
                            .toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(108, 117, 125, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Container(
              height: screenHeight * 0.1,
              width: screenWidth * 0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(66, 204, 195, 0.1),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.025,
                vertical: screenWidth * 0.001,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: screenWidth * 0.725,
                      padding: EdgeInsets.symmetric(
                        // vertical: screenHeight * 0.0125,
                        horizontal: screenWidth * 0.01,
                      ),
                      child: !_isDocumentFileTaken
                          ? documentFileNetworkUrl == ""
                              ? FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text.rich(
                                    TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: isLangEnglish
                                              ? 'Upload your '
                                              : "अपना अपलोड करें",
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                108, 117, 125, 1),
                                            fontSize: 12.5,
                                          ),
                                        ),
                                        TextSpan(
                                          text: isLangEnglish
                                              ? "Documents(pdf/docs)!"
                                              : "दस्तावेज़ (पीडीएफ/दस्तावेज़)!",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                                108, 117, 125, 1),
                                            fontSize: 12.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: isLangEnglish
                                              ? "Link: "
                                              : "लिंक: ",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: isLangEnglish
                                              ? "My Document..."
                                              : "मेरे दस्तावेज़...",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 20,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              var url = documentFileNetworkUrl;
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              } else {
                                                throw isLangEnglish
                                                    ? 'Could not launch $url'
                                                    : "लॉन्च नहीं हो सका $url";
                                              }
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                          : Text.rich(
                              TextSpan(
                                text: docFileName,
                                style: TextStyle(
                                  color: Color.fromRGBO(108, 117, 125, 1),
                                  fontSize: 12.5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Container(
                      width: screenWidth * 0.125,
                      child: ClipOval(
                        child: Material(
                          color:
                              Color.fromRGBO(220, 229, 228, 1), // Button color
                          child: InkWell(
                            splashColor: Color.fromRGBO(
                                120, 158, 156, 1), // Splash color
                            onTap: () async {
                              if (_isDocumentFileTaken) {
                                Provider.of<DoctorUserDetails>(context,
                                        listen: false)
                                    .updateDoctorDocuments(
                                        context, _documentFile);
                              } else {
                                final result =
                                    await FilePicker.platform.pickFiles(
                                  allowMultiple: false,
                                  type: FileType.custom,
                                  allowedExtensions: ['pdf', 'doc'],
                                );
                                if (result == null) {
                                  return;
                                }

                                // // Open Single File
                                final file = result.files.first;
                                openSingleDocumentFile(file);

                                setState(() {
                                  docFileName = file.name;
                                  docFileBytes = file.bytes.toString();
                                  docFileSize = file.size.toString();
                                  docFileExtentionType =
                                      file.extension.toString();
                                  docFileLocation = file.path.toString();

                                  _isDocumentFileTaken = true;
                                  _documentFile = File(file.path!);
                                });

                                // Provider.of<DoctorUserDetails>(context, listen: false).updateDoctorDocuments(context, _documentFile);
                                // final newFile = await saveFilePermanently(file);

                                // print('From Path: ${file.path!}');
                                // print('To Path: ${newFile.path}');
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: SizedBox(
                                width: screenWidth * 0.075,
                                height: screenWidth * 0.075,
                                child: Icon(
                                  !_isDocumentFileTaken
                                      ? Icons.upload_rounded
                                      : Icons.save_rounded,
                                  size: 21,
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
            height: screenHeight * 0.005,
          ),

          FittedBox(
            fit: BoxFit.fitWidth,
            child: Container(
              height: screenHeight * 0.1,
              width: screenWidth * 0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(66, 204, 195, 0.1),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.025,
                vertical: screenWidth * 0.001,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: screenWidth * 0.725,
                      padding: EdgeInsets.symmetric(
                        // vertical: screenHeight * 0.0125,
                        horizontal: screenWidth * 0.01,
                      ),
                      child: !_isDigitalSignatureTaken
                          ? doctorSignatureUrl == ""
                              ? FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text.rich(
                                    TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: isLangEnglish
                                              ? 'Upload your '
                                              : "अपना अपलोड करें ",
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                108, 117, 125, 1),
                                            fontSize: 12.5,
                                          ),
                                        ),
                                        TextSpan(
                                          text: isLangEnglish
                                              ? "Signature"
                                              : "हस्ताक्षर",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                                108, 117, 125, 1),
                                            fontSize: 12.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: isLangEnglish
                                              ? "Signature Uploaded. Press to re-upload"
                                              : "हस्ताक्षर अपलोडेड। पुनः अपलोड करे",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        // TextSpan(
                                        //   text: isLangEnglish
                                        //       ? "My Document..."
                                        //       : "मेरे दस्तावेज़...",
                                        //   style: TextStyle(
                                        //     color: Colors.blue,
                                        //     fontWeight: FontWeight.bold,
                                        //     decoration:
                                        //         TextDecoration.underline,
                                        //     overflow: TextOverflow.ellipsis,
                                        //     fontSize: 20,
                                        //   ),
                                        //   recognizer: TapGestureRecognizer()
                                        //     ..onTap = () async {
                                        //       var url = documentFileNetworkUrl;
                                        //       if (await canLaunch(url)) {
                                        //         await launch(url);
                                        //       } else {
                                        //         throw isLangEnglish
                                        //             ? 'Could not launch $url'
                                        //             : "लॉन्च नहीं हो सका $url";
                                        //       }
                                        //     },
                                        // ),
                                      ],
                                    ),
                                  ),
                                )
                          : Text.rich(
                              TextSpan(
                                text: isLangEnglish
                                    ? "Press to upload"
                                    : "अपलोड के लिए दबाएँ",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Container(
                      width: screenWidth * 0.125,
                      child: ClipOval(
                        child: Material(
                          color:
                              Color.fromRGBO(220, 229, 228, 1), // Button color
                          child: InkWell(
                            splashColor: Color.fromRGBO(
                                120, 158, 156, 1), // Splash color
                            onTap: () async {
                              if (_isDigitalSignatureTaken) {
                                // setState(() {
                                //   _isDigitalSignatureTaken = false;
                                // });
                                // print(_signaturePicture.path);
                                Provider.of<DoctorUserDetails>(context,
                                        listen: false)
                                    .updateDoctorSignaturePicture(
                                      context,
                                      _signaturePicture,
                                    )
                                    .then((value) => {
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              TabsScreenDoctor.routeName,
                                              (route) => false)
                                        });
                              } else {
                                _seclectSignatureUploadingType(
                                  context,
                                  isLangEnglish
                                      ? "Set your Signature"
                                      : "अपना हस्ताक्षर सेट करें",
                                  isLangEnglish
                                      ? "Signature Picker"
                                      : "हस्ताक्षर पिकर",
                                  doctorSignatureUrl,
                                );
                              }
                              // if (_isDocumentFileTaken) {
                              //   Provider.of<DoctorUserDetails>(context,
                              //           listen: false)
                              //       .updateDoctorDocuments(
                              //           context, _documentFile);
                              // } else {
                              //   final result =
                              //       await FilePicker.platform.pickFiles(
                              //     allowMultiple: false,
                              //     type: FileType.custom,
                              //     allowedExtensions: ['pdf', 'doc'],
                              //   );
                              //   if (result == null) {
                              //     return;
                              //   }

                              //   // // Open Single File
                              //   final file = result.files.first;
                              //   openSingleDocumentFile(file);

                              //   setState(() {
                              //     docFileName = file.name;
                              //     docFileBytes = file.bytes.toString();
                              //     docFileSize = file.size.toString();
                              //     docFileExtentionType = file.extension.toString();
                              //     docFileLocation = file.path.toString();

                              //     _isDocumentFileTaken = true;
                              //     _documentFile = File(file.path!);
                              //   });

                              //   // Provider.of<DoctorUserDetails>(context, listen: false).updateDoctorDocuments(context, _documentFile);
                              //   // final newFile = await saveFilePermanently(file);

                              //   // print('From Path: ${file.path!}');
                              //   // print('To Path: ${newFile.path}');
                              // }
                            },
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: SizedBox(
                                width: screenWidth * 0.075,
                                height: screenWidth * 0.075,
                                child: Icon(
                                  !_isDigitalSignatureTaken
                                      ? Icons.upload_rounded
                                      : Icons.save_rounded,
                                  size: 21,
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
            height: screenHeight * 0.0125,
          ),
          TextFieldContainer(
            context,
            isLangEnglish
                ? "Medical Registration Number"
                : "चिकित्सा पंजीकरण संख्या",
            'doctor_MedicalRegistrationNumber',
            userMapping,
            TextInputType.name,
          ),
          TextFieldContainer(
            context,
            isLangEnglish ? "Name" : "नाम",
            'doctor_FullName',
            userMapping,
            TextInputType.name,
          ),
          TextFieldContainer(
            context,
            isLangEnglish ? "Gender" : "लिंग",
            'doctor_Gender',
            userMapping,
            TextInputType.name,
          ),
          TextFieldContainer(
            context,
            isLangEnglish ? "Phone Number" : "फ़ोन नंबर",
            'doctor_PhoneNumber',
            userMapping,
            TextInputType.number,
          ),
          TextFieldContainer(
            context,
            isLangEnglish ? "Years Of Experience" : "वर्षों का अनुभव",
            'doctor_YearsOfExperience',
            userMapping,
            TextInputType.number,
          ),
          TextFieldContainer(
            context,
            isLangEnglish ? "Education Qualification" : "शैक्षणिक योग्यता",
            'doctor_EducationQualification',
            userMapping,
            TextInputType.name,
          ),
          TextFieldContainer(
            context,
            isLangEnglish ? "Medicine Type" : "दवा का प्रकार",
            'doctor_MedicineType',
            userMapping,
            TextInputType.name,
          ),
          TextFieldContainer(
            context,
            isLangEnglish ? "Speciality" : "स्पेशलिटी",
            'doctor_Speciality',
            userMapping,
            TextInputType.name,
          ),
          TextFieldContainer(
            context,
            isLangEnglish ? "City" : "शहर",
            'doctor_CurrentCity',
            userMapping,
            TextInputType.name,
          ),
          TextFieldContainer(
            context,
            isLangEnglish ? "City Pincode" : "शहर का पिनकोड",
            'doctor_CurrentCityPinCode',
            userMapping,
            TextInputType.number,
          ),
          TextFieldContainer(
            context,
            isLangEnglish ? "Registration Details" : "पंजीकरण के विवरण",
            'doctor_RegistrationDetails',
            userMapping,
            TextInputType.name,
          ),
          SizedBox(
            height: screenHeight * 0.0125,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.005,
              horizontal: screenWidth * 0.0125,
            ),
            alignment: Alignment.center,
            child: Text(
              isLangEnglish ? "Patients Feedback:" : "मरीजों की प्रतिक्रिया:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.08,
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.0125,
          ),
          TextShowingFieldContainer(
            context,
            isLangEnglish ? "My User Rating" : "मेरी उपयोगकर्ता रेटिंग",
            "doctor_ExperienceRating",
            userMapping,
          ),
          TextShowingFieldContainer(
            context,
            isLangEnglish ? "Patients Treated" : "इलाज किए गए मरीजों की संख्या",
            "doctor_NumberOfPatientsTreated",
            userMapping,
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          // Container(
          //   child: TextButton(
          //     onPressed: !isSaveChangesBtnActive ? null : () {},
          //     child: Container(
          //       width: screenWidth * 0.95,
          //       padding: EdgeInsets.symmetric(
          //         vertical: screenHeight * 0.025,
          //         horizontal: screenWidth * 0.01,
          //       ),
          //       decoration: BoxDecoration(
          //         color: !isSaveChangesBtnActive
          //             ? Color.fromRGBO(220, 229, 228, 1)
          //             : Color(0xff42CCC3),
          //         borderRadius: BorderRadius.circular(10),
          //         border: Border.all(
          //           width: 2,
          //           color: Color(0xffCDCDCD),
          //         ),
          //       ),
          //       child: Center(
          //         child: Text(
          //           "Save Changes",
          //           style: TextStyle(
          //             color: Colors.black,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: screenHeight * 0.0125,
          // ),
        ],
      ),
    );
  }

  Widget imageContainer(BuildContext context, String imgUrl) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    final defaultImg = 'assets/images/surgeon.png';
    bool isImageAvailable = false;
    if (imgUrl.length > 0) isImageAvailable = true;

    return Container(
      height: useableHeight * 0.3,
      padding: EdgeInsets.symmetric(
        vertical: useableHeight * 0.010,
        horizontal: screenWidth * 0.015,
      ),
      margin: EdgeInsets.symmetric(
        vertical: useableHeight * 0.0025,
      ),
      child: Card(
        elevation: 15,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade100,
          ),
          padding: EdgeInsets.symmetric(vertical: useableHeight * 0.01),
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: screenWidth * 0.4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(screenWidth * 0.4),
              child: ClipOval(
                child: isImageAvailable
                    ? Image.network(imgUrl)
                    : Image.asset(defaultImg),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget TextShowingFieldContainer(
    BuildContext context,
    String labelText,
    String contentText,
    Map<String, String> userMapping,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    TextEditingController existingText = TextEditingController();
    existingText.text = userMapping[contentText] ?? "";

    if (contentText == "doctor_ExperienceRating") {
      existingText.text += " / 5";
    }

    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(66, 204, 195, 0.1),
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
        height: screenHeight * 0.125,
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

  Widget TextFieldContainer(
    BuildContext context,
    String labelText,
    String contentText,
    Map<String, String> userMapping,
    TextInputType keyBoardType,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var minDimension = min(screenWidth, screenHeight);
    var maxDimension = max(screenWidth, screenHeight);

    TextEditingController existingText = TextEditingController();
    existingText.text = userMapping[contentText] ?? "";

    existingText.selection = TextSelection.fromPosition(
        TextPosition(offset: existingText.text.length));

    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // color: Colors.white70,
          color: Color.fromRGBO(66, 204, 195, 0.1),
        ),
        margin: EdgeInsets.symmetric(
          vertical: screenHeight * 0.0015,
          // horizontal: screenWidth * 0.00125,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: minDimension * 0.04,
          vertical: maxDimension * 0.01,
        ),
        height: maxDimension * 0.125,
        width: screenWidth * 0.95,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: screenWidth * 0.775,
              child: TextFormField(
                autocorrect: true,
                autofocus: true,
                enabled: editBtnMapping[contentText],
                controller: existingText,
                keyboardType: keyBoardType,
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
            ClipOval(
              child: Material(
                color: Color.fromRGBO(220, 229, 228, 1), // Button color
                child: InkWell(
                  splashColor: Color.fromRGBO(120, 158, 156, 1), // Splash color
                  onTap: () {
                    setState(() {
                      if (editBtnMapping[contentText] == true) {
                        Provider.of<DoctorUserDetails>(context, listen: false)
                            .updateDoctorUserPersonalInformation(context,
                                contentText, existingText.text.toString());

                        userMapping[contentText] = existingText.text.toString();
                      }
                      isSaveChangesBtnActive = true;

                      if (editBtnMapping[contentText] == true) {
                        editBtnMapping[contentText] = false;
                      } else {
                        editBtnMapping[contentText] = true;
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: SizedBox(
                      width: screenWidth * 0.075,
                      height: screenWidth * 0.075,
                      child: Icon(
                        editBtnMapping[contentText] == false
                            ? Icons.edit_rounded
                            : Icons.save_rounded,
                        size: 21,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _seclectImageUploadingType(
    BuildContext context,
    String titleText,
    String contextText,
    String imageNetworkUrl,
  ) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    String str1 = isLangEnglish ? "Pick From Galary" : "गैलरी से चुनें";
    String str2 = isLangEnglish ? "Click a Picture" : "तस्वीर ले";

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${titleText}'),
        content: Text('${contextText}'),
        actions: <Widget>[
          InkWell(
            onTap: () async {
              final picker = ImagePicker();
              final imageFile = await picker.getImage(
                source: ImageSource.gallery,
                imageQuality: 80,
                maxHeight: 650,
                maxWidth: 650,
              );

              if (imageFile == null) {
                return;
              }

              setState(() {
                _profilePicture = File(imageFile.path);
                _isProfilePicTaken = true;
              });
              Navigator.pop(ctx);
              // // _saveUploadedImage(context, imageNetworkUrl);
              // Navigator.of(context).pop(true);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(220, 229, 228, 1),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenWidth * 0.025,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.075,
                vertical: screenWidth * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.photo_size_select_actual_rounded,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      str1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          InkWell(
            onTap: () async {
              final picker = ImagePicker();
              final imageFile = await picker.getImage(
                source: ImageSource.camera,
                imageQuality: 80,
                maxHeight: 650,
                maxWidth: 650,
              );

              if (imageFile == null) {
                return;
              }
              setState(() {
                _profilePicture = File(imageFile.path);
                _isProfilePicTaken = true;
                // Navigator.of(context).pop(false);
              });
              Navigator.pop(ctx);
              // // _saveUploadedImage(ctx, imageNetworkUrl);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(220, 229, 228, 1),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenWidth * 0.025,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.075,
                vertical: screenWidth * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.camera_alt_rounded,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      str2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _seclectSignatureUploadingType(
    BuildContext context,
    String titleText,
    String contextText,
    String imageNetworkUrl,
  ) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    String str1 = isLangEnglish ? "Pick From Galary" : "गैलरी से चुनें";
    String str2 = isLangEnglish ? "Click a Picture" : "तस्वीर ले";

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${titleText}'),
        content: Text('${contextText}'),
        actions: <Widget>[
          InkWell(
            onTap: () async {
              final picker = ImagePicker();
              final imageFile = await picker.getImage(
                source: ImageSource.gallery,
                imageQuality: 80,
                maxHeight: 650,
                maxWidth: 650,
              );

              if (imageFile == null) {
                return;
              }

              setState(() {
                _signaturePicture = File(imageFile.path);
                _isDigitalSignatureTaken = true;
              });
              Navigator.pop(ctx);
              // // _saveUploadedImage(context, imageNetworkUrl);
              // Navigator.of(context).pop(true);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(220, 229, 228, 1),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenWidth * 0.025,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.075,
                vertical: screenWidth * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.photo_size_select_actual_rounded,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      str1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          InkWell(
            onTap: () async {
              final picker = ImagePicker();
              final imageFile = await picker.getImage(
                source: ImageSource.camera,
                imageQuality: 80,
                maxHeight: 650,
                maxWidth: 650,
              );

              if (imageFile == null) {
                return;
              }
              setState(() {
                _signaturePicture = File(imageFile.path);
                _isDigitalSignatureTaken = true;
                // Navigator.of(context).pop(false);
              });
              Navigator.pop(ctx);
              // // _saveUploadedImage(ctx, imageNetworkUrl);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(220, 229, 228, 1),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenWidth * 0.025,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.075,
                vertical: screenWidth * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.camera_alt_rounded,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      str2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openSingleDocumentFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  void openMultipleDocumentFiles(List<PlatformFile> files) {}

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');

    return File(file.path!).copy(newFile.path);
  }

  Future<void> _seclectDocumentUploadingType(
    BuildContext context,
    String titleText,
    String contextText,
  ) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    String str1 = isLangEnglish
        ? "Upload from Local Storage"
        : "स्थानीय संग्रहण से अपलोड करें";
    String str2 = isLangEnglish ? "Click a Picture" : "एक तस्वीर पर क्लिक करें";

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${titleText}'),
        content: Text('${contextText}'),
        actions: <Widget>[
          InkWell(
            onTap: () async {
              // // For Selecting, Opening, and Saving only one single file
              // final result = await FilePicker.platform.pickFiles(); // will select only one file at a time
              final result = await FilePicker.platform.pickFiles(
                  type: FileType.custom, allowedExtensions: ['pdf', 'doc']);
              if (result == null) {
                return;
              }

              setState(() {
                _isDocumentFileTaken = true;
              });

              // // Open Single File
              final file = result.files.first;
              openSingleDocumentFile(file);

              print('Name: ${file.name}');
              print('Bytes: ${file.bytes}');
              print('Size: ${file.size}');
              print('Extension: ${file.extension}');
              print('Path: ${file.path}');

              final newFile = await saveFilePermanently(file);

              print('From Path: ${file.path!}');
              print('To Path: ${newFile.path}');

              // // // For Selecting, Opening, and Saving Multiple files at the same time
              // final result = await FilePicker.platform.pickFiles(allowMultiple: true); // will select multiple files at a time
              // openMultipleDocumentFiles(result!.files);

              // // For Selecting, Opening, and Saving files of specific type at the same time
              // final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc']);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(220, 229, 228, 1),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenWidth * 0.025,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.075,
                vertical: screenWidth * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.photo_size_select_actual_rounded,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      str1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveUploadedImage(
      BuildContext context, String imageNetworkUrl) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        actions: <Widget>[
          Container(
            // height: 0.3 * screenHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade100,
            ),
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.025,
            ),
            alignment: Alignment.center,
            child: Container(
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: screenWidth * 0.25,
                child: ClipOval(
                  child: _isProfilePicTaken
                      ? Image.file(
                          _profilePicture,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : Image.asset("assets/images/surgeon.png"),
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          InkWell(
            onTap: () async {
              Provider.of<DoctorUserDetails>(context, listen: false)
                  .updateDoctorProfilePicture(context, _profilePicture);
              Navigator.pop(ctx);

              setState(() {
                _isProfilePicTaken = false;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(220, 229, 228, 1),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenWidth * 0.025,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.075,
                vertical: screenWidth * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.save_rounded,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      isLangEnglish ? "Save Image" : "चित्र को सेव करें",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          InkWell(
            onTap: () async {
              imageNetworkUrl == ""
                  ? Image.asset(
                      "assets/images/surgeon.png",
                    )
                  : Image.network(
                      imageNetworkUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
              Navigator.pop(ctx);

              setState(() {
                _isProfilePicTaken = false;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(220, 229, 228, 1),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenWidth * 0.025,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.075,
                vertical: screenWidth * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.delete_rounded,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      isLangEnglish ? "Discard Image" : "छवि त्यागें",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
