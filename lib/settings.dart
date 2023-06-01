// ignore_for_file: prefer_const_constructors

import 'package:doctor/profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Settings());
}

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Color(0xFFf3f4f5),
      title: 'Flutter Widget stuff',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const WidgetPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WidgetPage extends StatefulWidget {
  const WidgetPage({Key? key}) : super(key: key);

  @override
  State<WidgetPage> createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  
  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width);
    double height = (MediaQuery.of(context).size.height);

    return Scaffold(
      backgroundColor: const Color(0xFFf2f3f4),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            enableFeedback: false,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Page3()),
              );
            },
            icon: const Icon(
              Icons.arrow_circle_left,
              color: Color(0xff42ccc3),
              size: 35,
            )),
        title: Text(
          "Settings",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 24),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
          height: 750,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: const Border(
              top: BorderSide(width: 1.0, color: Colors.grey),
              left: BorderSide(width: 1.0, color: Colors.grey),
              right: BorderSide(width: 1.0, color: Colors.grey),
              bottom: BorderSide(width: 1.0, color: Colors.grey),
            ),
          ),
          child: Column(
            children: [
              Container(
                child: Column(children: [
                  Container(
                    height: 43,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: const Border(
                        top: BorderSide(width: 1.0, color: Colors.grey),
                        left: BorderSide(width: 1.0, color: Colors.grey),
                        right: BorderSide(width: 1.0, color: Colors.grey),
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 25,
                                  width: 25,
                                  margin: const EdgeInsets.only(left: 7.83),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.83),
                                    color: Colors.green,
                                    // image: DecorationImage(
                                    //   image: AssetImage("img/Doctor.jpg"),
                                    //   fit: BoxFit.cover,
                                    // )
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 37),
                                  child: const Text(
                                    "Privacy Policies",
                                    // time,
                                    // textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(0xff42ccc3),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25),
                                  ),
                                ),
                                // Container(
                                //   margin : const EdgeInsets.only(
                                //       left: 50,right: 40),
                                //   child: Text(
                                //     "Share App",
                                //     // textAlign: TextAlign.right,
                                //     style: const TextStyle(
                                //         color: Color(0xff42ccc3),
                                //         fontWeight: FontWeight.w500,
                                //         fontSize: 25),
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 43,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: const Border(
                        top: BorderSide(width: 1.0, color: Colors.grey),
                        left: BorderSide(width: 1.0, color: Colors.grey),
                        right: BorderSide(width: 1.0, color: Colors.grey),
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 25,
                                  width: 25,
                                  margin: const EdgeInsets.only(left: 7.83),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.83),
                                    color: Colors.green,
                                    // image: DecorationImage(
                                    //   image: AssetImage("img/Doctor.jpg"),
                                    //   fit: BoxFit.cover,
                                    // )
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 37),
                                  child: const Text(
                                    "Share App",
                                    // time,
                                    // textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(0xff42ccc3),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25),
                                  ),
                                ),
                                // Container(
                                //   margin : const EdgeInsets.only(
                                //       left: 50,right: 40),
                                //   child: Text(
                                //     "Share App",
                                //     // textAlign: TextAlign.right,
                                //     style: const TextStyle(
                                //         color: Color(0xff42ccc3),
                                //         fontWeight: FontWeight.w500,
                                //         fontSize: 25),
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 43,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: const Border(
                        top: BorderSide(width: 1.0, color: Colors.grey),
                        left: BorderSide(width: 1.0, color: Colors.grey),
                        right: BorderSide(width: 1.0, color: Colors.grey),
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 25,
                                  width: 25,
                                  margin: const EdgeInsets.only(left: 7.83),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.83),
                                    color: Colors.green,
                                    // image: DecorationImage(
                                    //   image: AssetImage("img/Doctor.jpg"),
                                    //   fit: BoxFit.cover,
                                    // )
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 37),
                                  child: const Text(
                                    "Customer Care",
                                    // time,
                                    // textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(0xff42ccc3),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25),
                                  ),
                                ),
                                // Container(
                                //   margin : const EdgeInsets.only(
                                //       left: 50,right: 40),
                                //   child: Text(
                                //     "Share App",
                                //     // textAlign: TextAlign.right,
                                //     style: const TextStyle(
                                //         color: Color(0xff42ccc3),
                                //         fontWeight: FontWeight.w500,
                                //         fontSize: 25),
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 43,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: const Border(
                        top: BorderSide(width: 1.0, color: Colors.grey),
                        left: BorderSide(width: 1.0, color: Colors.grey),
                        right: BorderSide(width: 1.0, color: Colors.grey),
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 25,
                                  width: 25,
                                  margin: const EdgeInsets.only(left: 7.83),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.83),
                                    color: Colors.green,
                                    // image: DecorationImage(
                                    //   image: AssetImage("img/Doctor.jpg"),
                                    //   fit: BoxFit.cover,
                                    // )
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 37),
                                  child: Text(
                                    "Manage Account",
                                    // time,
                                    // textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        color: Color(0xff42ccc3),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25),
                                  ),
                                ),
                                // Container(
                                //   margin : const EdgeInsets.only(
                                //       left: 50,right: 40),
                                //   child: Text(
                                //     "Share App",
                                //     // textAlign: TextAlign.right,
                                //     style: const TextStyle(
                                //         color: Color(0xff42ccc3),
                                //         fontWeight: FontWeight.w500,
                                //         fontSize: 25),
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),

              //  log out thingi

              Container(
                margin: EdgeInsets.only(top: 533),
                height: 43,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: const Border(
                    top: BorderSide(width: 1.0, color: Colors.grey),
                    left: BorderSide(width: 1.0, color: Colors.grey),
                    right: BorderSide(width: 1.0, color: Colors.grey),
                    bottom: BorderSide(width: 1.0, color: Colors.grey),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 125),
                              child: const Text(
                                "Log Out",
                                // time,
                                // textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 25),
                              ),
                            ),
                            // Container(
                            //   margin : const EdgeInsets.only(
                            //       left: 50,right: 40),
                            //   child: Text(
                            //     "Share App",
                            //     // textAlign: TextAlign.right,
                            //     style: const TextStyle(
                            //         color: Color(0xff42ccc3),
                            //         fontWeight: FontWeight.w500,
                            //         fontSize: 25),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
