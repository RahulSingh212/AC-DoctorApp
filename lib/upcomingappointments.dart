import 'package:flutter/material.dart';

class UpcomingAppointments extends StatelessWidget {
  const UpcomingAppointments({Key? key}) : super(key: key);

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
  String name3 = "Ankita Sharma";
  String name1 = "Ankita Sharma";
  String ailment = "Dust Allergy ,Mirago 50mg..";
  String today = "TODAY | MORNING";
  String date1 = "1st July 2021";
  String date2 = "4th July 2021";
  int number = 2;
  int number1 = 1;

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width);
    double height = (MediaQuery.of(context).size.height);

    return Scaffold(
      backgroundColor: const Color(0xFFf2f3f4),
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Container(
              padding: EdgeInsets.only(right: 180, bottom: 10),
              child: const Text(
                "Upcoming Appointments",
                // time,

                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 24),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, bottom: 10),
              child: const Text(
                "Connect with your patients online",
                // time,

                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 15.22),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: 0.03 * height,
                        left: 0.001 * height,
                        right: 0.29 * height,
                        // right: 0.17 * height
                      ),
                      child: Text(
                        today,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 5, top: 10),
                      height: 67,
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
                                    Container(
                                      child: Text(
                                        name3,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 150),
                                      child: IconButton(
                                          enableFeedback: false,
                                          onPressed: () {
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.calendar_today_outlined,
                                            size: 20,
                                            color: Color(0xff42ccc3),
                                          )),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ailment,
                                      style: const TextStyle(
                                          color: Color(0xff9E9E9E),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 1,
                                    ),
                                    const SizedBox(
                                      width: 1,
                                    ),
                                  ],
                                ),
                              ])
                        ],
                      ),
                    ),
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
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
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
                                    const SizedBox(
                                      width: 1,
                                    ),
                                  ],
                                ),
                              ])
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 5, top: 10),
                      height: 67,
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
                                    Container(
                                      child: Text(
                                        name3,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 150),
                                      child: IconButton(
                                          enableFeedback: false,
                                          onPressed: () {
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.calendar_today_outlined,
                                            size: 20,
                                            color: Color(0xff42ccc3),
                                          )),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ailment,
                                      style: const TextStyle(
                                          color: Color(0xff9E9E9E),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 1,
                                    ),
                                    const SizedBox(
                                      width: 1,
                                    ),
                                  ],
                                ),
                              ])
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 0.02 * height,
                          left: 0.0000001 * height,
                          right: 0.28 * height),
                      child: const Text.rich(
                        TextSpan(
                          text: 'TODAY | EVENING',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 12),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 5, top: 10),
                      height: 67,
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
                                    Container(
                                      child: Text(
                                        name3,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 150),
                                      child: IconButton(
                                          enableFeedback: false,
                                          onPressed: () {
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.calendar_today_outlined,
                                            size: 20,
                                            color: Color(0xff42ccc3),
                                          )),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ailment,
                                      style: const TextStyle(
                                          color: Color(0xff9E9E9E),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 1,
                                    ),
                                    const SizedBox(
                                      width: 1,
                                    ),
                                  ],
                                ),
                              ])
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 0.03 * height,
                        left: 0.001 * height,
                        right: 0.29 * height,
                        // right: 0.17 * height
                      ),
                      child: Text(
                        date1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 5, top: 10),
                      height: 67,
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
                                    Container(
                                      child: Text(
                                        name3,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 150),
                                      child: IconButton(
                                          enableFeedback: false,
                                          onPressed: () {
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.calendar_today_outlined,
                                            size: 20,
                                            color: Color(0xff42ccc3),
                                          )),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ailment,
                                      style: const TextStyle(
                                          color: Color(0xff9E9E9E),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 1,
                                    ),
                                    const SizedBox(
                                      width: 1,
                                    ),
                                  ],
                                ),
                              ])
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 5, top: 10),
                      height: 67,
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
                                    Container(
                                      child: Text(
                                        name3,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 150),
                                      child: IconButton(
                                          enableFeedback: false,
                                          onPressed: () {
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.calendar_today_outlined,
                                            size: 20,
                                            color: Color(0xff42ccc3),
                                          )),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ailment,
                                      style: const TextStyle(
                                          color: Color(0xff9E9E9E),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 1,
                                    ),
                                    const SizedBox(
                                      width: 1,
                                    ),
                                  ],
                                ),
                              ])
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 0.01 * height,
                          left: 0.0000001 * height,
                          right: 0.30 * height),
                      child: const Text.rich(
                        TextSpan(
                          text: 'TOMORROW',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 12),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 5, top: 10),
                      height: 67,
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
                                    Container(
                                      child: Text(
                                        name3,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 150),
                                      child: IconButton(
                                          enableFeedback: false,
                                          onPressed: () {
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.calendar_today_outlined,
                                            size: 20,
                                            color: Color(0xff42ccc3),
                                          )),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ailment,
                                      style: const TextStyle(
                                          color: Color(0xff9E9E9E),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 1,
                                    ),
                                    const SizedBox(
                                      width: 1,
                                    ),
                                  ],
                                ),
                              ])
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
