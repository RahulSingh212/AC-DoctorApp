import 'package:doctor/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "Ravina Kapoor";

  // String branch = "bruh";
  String time = "5:00 PM";
  String date = "8th Jul";
  String name1 = "Khushi Sharma";
  String time1 = "5:00 PM";
  String date1 = "8th Jul";
  String name2 = "Ankita Sharma";
  String ailment = "Dust Allergy ,Mirago 50mg..";
  int number = 2;

  // String ImageUrl;
  String wait = " is waiting for you!";
  String sched = "You are scheduled for ";
  String date10 = "April 17";
  String at = "at ";

  String time10 = "11:30 AM";

  double? width;

  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width);
    double height = (MediaQuery.of(context).size.height);
    String finalwait = name + wait;
    String finalsched = sched + date10 + at + time10;
    return Scaffold(
      backgroundColor: Color(0xffF2f3f4f5),
      appBar: AppBar(
          elevation: 0,
          leading: Container(
            child: Column(
              children: [
                IconButton(
                    onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => SimpleDialog(
                            backgroundColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                              side: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                width: width,
                                height: 350,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 148,
                                      margin: const EdgeInsets.only(top: 40),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 80, right: 80, top: 30),
                                      child: Text(
                                        finalwait,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 80, top: 10, right: 80),
                                      child: Text(
                                        finalsched,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: width / 2,
                                height: 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: width / 1.23,
                                      height: 52,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                        ),
                                        onPressed: () {},
                                        child: const Text(
                                          'Call',
                                          style: TextStyle(
                                              color: Color(0xff42ccc3),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    // child: const Text('Show Dialog'),
                    icon: const Icon(
                      Icons.notifications,
                      color: Color(0xff42ccc3),
                      size: 35,
                    )

                    // IconButton(
                    //   enableFeedback: false,
                    //   onPressed: () {
                    //     // Navigator.push(
                    //     //   context,
                    //     //   MaterialPageRoute(builder: (context) => const Page3()),
                    //     // );
                    //   },
                    //   icon: const Icon(
                    //           Icons.notifications,
                    //           color: Color(0xff42ccc3),
                    //           size: 35,
                    //         )
                    //
                    // ),
                    ),
              ],
            ),
          ),
          // IconButton(
          //   enableFeedback: false,
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const Page3()),
          //     );
          //   },
          //   icon: const Icon(
          //           Icons.notifications,
          //           color: Color(0xff42ccc3),
          //           size: 35,
          //         )
          //
          // ),
          actions: <Widget>[
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Page3()),
                  );
                },
                icon: const Icon(
                  Icons.image,
                  color: Color(0xff42ccc3),
                  size: 35,
                ))
          ],
          backgroundColor: const Color(0xfff3f4f5)),
      // backgroundColor: const Color(0xFFf2f3f4),
      body: Container(
        width: width,
        height: 839,
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(
                      top: 0.001 * height,
                      left: 0.0000001 * height,
                      right: 0.17 * height),
                  child: const Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Hello, ',
                            style: TextStyle(
                              fontSize: 25,
                            )),
                        TextSpan(
                          text: 'Dr. Ram Singh!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ],
                    ),
                  )),
              Row(
                children: [
                  // Container(
                  //   padding: EdgeInsets.only(
                  //     top: 0.15 * height,
                  //     left: 0.04 * height,
                  //     bottom: 0.01 * height,
                  //   ),
                  //   child: Column(
                  //     children: const [
                  //       Icon(Icons.perm_identity_rounded, size: 30),
                  //       SizedBox(
                  //         height: 8,
                  //       ),
                  //       Center(
                  //           child: Text(
                  //         "My Patients",
                  //         style: TextStyle(fontSize: 16),
                  //       )),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 0.2 * height,
                      left: 0.04 * height,
                      bottom: 0.08 * height,
                    ),
                    child: Column(
                      children: [
                        IconButton(
                            enableFeedback: false,
                            onPressed: () {
                              {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => const Page7()),
                                // );
                                // pageIndex = 0;
                              }
                              ;
                            },
                            icon:
                                // pageIndex == 0
                                const Icon(
                              Icons.perm_identity_rounded,
                              color: Color(0xff42ccc3),
                              size: 30,
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                            child: Text(
                          "My Patients",
                          style: TextStyle(fontSize: 16),
                        )),
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(
                      top: 0.2 * height,
                      left: 0.05 * height,
                      bottom: 0.08 * height,
                    ),
                    child: Column(
                      children: [
                        IconButton(
                            enableFeedback: false,
                            onPressed: () {
                              {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => const Page7()),
                                // );
                                // pageIndex = 0;
                              }
                              ;
                            },
                            icon:
                                // pageIndex == 0
                                const Icon(
                              Icons.perm_identity_rounded,
                              color: Color(0xff42ccc3),
                              size: 30,
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                            child: Text(
                          "My Schedule",
                          style: TextStyle(fontSize: 16),
                        )),
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(
                      top: 0.2 * height,
                      left: 0.05 * height,
                      bottom: 0.08 * height,
                    ),
                    child: Column(
                      children: [
                        IconButton(
                            enableFeedback: false,
                            onPressed: () {
                              {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => const Page7()),
                                // );
                                // pageIndex = 0;
                              }
                              ;
                            },
                            icon:
                                // pageIndex == 0
                                const Icon(
                              Icons.perm_identity_rounded,
                              color: Color(0xff42ccc3),
                              size: 30,
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                            child: Text("Consulting",
                                style: TextStyle(fontSize: 16))),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width / 2,
                    padding: EdgeInsets.only(left: 0.01 * height),
                    child: const Text.rich(
                      TextSpan(
                        text: 'Appointments',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 21),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 0.1 * height, right: 0.01 * height),
                    width: width / 2,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      onPressed: () {},
                      child: const Text('View All'),
                    ),
                  )
                ],
              ),
              Container(
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 10, top: 0),
                    height: 80,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
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
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width / 1000,
                                  child: Row(
                                    children: const [],
                                  ),
                                ),
                                // const SizedBox(
                                //
                                //   height: 1,
                                // ),
                                Container(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),
                                  ),
                                ),
                                Container(
                                    // margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.only(
                                        left: 130, top: 10),
                                    child: const Icon(
                                      Icons.calendar_today_outlined,
                                      size: 20,
                                    )),
                              ],
                            ),

                            const SizedBox(
                              height: 1,
                            ),
                            // Text(
                            //   branch,
                            //   style: TextStyle(
                            //       color: Color(0xff727272), fontWeight: FontWeight.w500),
                            // ),
                            const SizedBox(
                              height: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  time,
                                  style: const TextStyle(
                                      color: Color(0xff42ccc3),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 158),
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  decoration: BoxDecoration(
                                      color: Color(0xff42ccc3),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Center(
                                      child: Container(
                                          child: Text(
                                    date,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ))),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //The 2nd Widget starts here

                  Container(
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 10, top: 10),
                    height: 80,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.only(
                            left: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.83),
                            color: Colors.green,
                            // image: DecorationImage(
                            //   image: AssetImage("img/Doctor.jpg"),
                            //   fit: BoxFit.cover,
                            // )
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: width / 1000,
                                    child: Row(
                                      children: const [],
                                    ),
                                  ),
                                  // const SizedBox(
                                  //
                                  //   height: 1,
                                  // ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      name1,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                      // margin: const EdgeInsets.only(top: 10),
                                      padding: const EdgeInsets.only(
                                          left: 120, top: 10),
                                      child: const Icon(
                                        Icons.calendar_today_outlined,
                                        size: 20,
                                      )),
                                ],
                              ),

                              const SizedBox(
                                height: 1,
                              ),
                              // Text(
                              //   branch,
                              //   style: TextStyle(
                              //       color: Color(0xff727272), fontWeight: FontWeight.w500),
                              // ),
                              const SizedBox(
                                height: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    time1,
                                    style: const TextStyle(
                                        color: Color(0xff42ccc3),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 155),
                                    padding: EdgeInsets.only(
                                        left: 5, right: 5, top: 3, bottom: 3),
                                    decoration: BoxDecoration(
                                        color: Color(0xff42ccc3),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Center(
                                      child: Container(
                                        child: Text(
                                          date1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ])
                      ],
                    ),
                  ),

                  // 3rd Widget FROM HERE!

                  Container(
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 5, top: 10),
                    height: 59,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 36,
                          width: 36,
                          margin: const EdgeInsets.only(
                            left: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.5),
                            color: Colors.green,
                            // image: DecorationImage(
                            //   image: AssetImage("img/Doctor.jpg"),
                            //   fit: BoxFit.cover,
                            // )
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: width / 1000,
                                    child: Row(
                                      children: const [],
                                    ),
                                  ),
                                  // const SizedBox(
                                  //
                                  //   height: 1,
                                  // ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Text(
                                      name1,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 150, top: 10),
                                    child: CircleAvatar(
                                      backgroundColor: Color(0xff42ccc3),
                                      radius: 15,
                                      child: Text((number).toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                  // Container(
                                  //   // margin: const EdgeInsets.only(top: 10),
                                  //     padding:
                                  //     const EdgeInsets.only(left: 40, top: 10),
                                  //     child: const Icon(
                                  //       Icons.calendar_today_outlined,
                                  //       size: 28,
                                  //     )),
                                ],
                              ),

                              const SizedBox(
                                height: 1,
                              ),
                              // Text(
                              //   branch,
                              //   style: TextStyle(
                              //       color: Color(0xff727272), fontWeight: FontWeight.w500),
                              // ),
                              const SizedBox(
                                height: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ailment,
                                    style: TextStyle(
                                        color: Color(0xff727272),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  // Text(
                                  //   time1,
                                  //   style: const TextStyle(
                                  //       color: Color(0xff42ccc3),
                                  //       fontWeight: FontWeight.w500,
                                  //       fontSize: 28),
                                  // ),
                                  const SizedBox(
                                    width: 1,
                                  ),
                                  // Container(
                                  //   margin: EdgeInsets.only(left: 50),
                                  //   padding: EdgeInsets.only(
                                  //       left: 5, right: 5, top: 3, bottom: 3),
                                  //   decoration: BoxDecoration(
                                  //       color: Color(0xff42ccc3),
                                  //       borderRadius: BorderRadius.circular(6)),
                                  //   child: Center(
                                  //     child: Container(
                                  //       child: Text(
                                  //         date1,
                                  //         style: TextStyle(
                                  //             color: Colors.white, fontSize: 15),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ])
                      ],
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
