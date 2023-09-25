import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PatientInfo extends StatefulWidget {
  const PatientInfo({Key? key}) : super(key: key);

  @override
  _PatientInfoState createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF7F9FC),
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Image(
            image: const AssetImage('assets/Home screen.png'),
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                backButton(context),
                buildGoodmornTitle(context),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                buildImage(context),
                buildGridview(context),
                buildYourDailyMedication(context),
                buildbloodPandDaibetes(context),
                buildScheduled_Activities_Title(context),
                buildScheduled_Activities_card(context),
                buildButton(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget backButton(context) {
    return Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 3.0),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 15,
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget buildGoodmornTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(
          height: 40,
        ),
        Text(
          'Patient',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget buildImage(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(
              'https://profilemagazine.com/wp-content/uploads/2020/04/Ajmere-Dale-Square-thumbnail.jpg'),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Dr. Praveen',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '23 yrs old',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildGridview(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: GridView.count(
        crossAxisSpacing: 15,
        shrinkWrap: true,
        crossAxisCount: 2,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Container(
            decoration: BoxDecoration(
                color: const Color(0xffA1ECBF),
                borderRadius: BorderRadius.circular(11)),
            child: Stack(
              children: [
                Positioned(
                  top: -10,
                  left: -10,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.black.withOpacity(0.05),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/images/HeartBeat.svg'),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Heartbeat',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        '66',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'bpm',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: const Color(0xffFFDA7A),
                borderRadius: BorderRadius.circular(11)),
            child: Stack(
              children: [
                Positioned(
                  top: -10,
                  left: -10,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.black.withOpacity(0.05),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          'assets/images/carbon_temperature-feels-like.svg'),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Temperature',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 23, vertical: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '37/35',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        '°F',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildYourDailyMedication(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 30),
      child: Text(
        'Your daily medications',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget buildbloodPandDaibetes(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: Colors.white),
                height: 130,
                width: 250,
                child: Stack(
                  children: [
                    Positioned(
                      top: -10,
                      left: -10,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: const Color(0xff3EC6FF).withOpacity(0.10),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/Blood Drop.svg',
                                height: 28,
                                width: 18,
                              ),
                              const Spacer(),
                              const Text(
                                '8-9 AM',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20, top: 20),
                          child: Text(
                            'Blood Pressure',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: RichText(
                            text: const TextSpan(
                                text: '144/80',
                                style: TextStyle(
                                    color: Color(0xff486581),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17),
                                children: [
                                  TextSpan(
                                      text: '  mmHg',
                                      style: TextStyle(
                                          color: Color(0xff486581),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 17))
                                ]),
                          ),
                        )
                      ],
                    )
                  ],
                )),
          ),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11), color: Colors.white),
              height: 130,
              width: 250,
              child: Stack(
                children: [
                  Positioned(
                    top: -10,
                    left: -10,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: const Color(0xff3EC6FF).withOpacity(0.10),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/blood pressure.svg',
                              height: 28,
                              width: 18,
                            ),
                            const Spacer(),
                            const Text(
                              '8-9 AM',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          'Blood Pressure',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: RichText(
                          text: const TextSpan(
                              text: '126',
                              style: TextStyle(
                                  color: Color(0xff486581),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17),
                              children: [
                                TextSpan(
                                    text: '  mg/dl',
                                    style: TextStyle(
                                        color: Color(0xff486581),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 17))
                              ]),
                        ),
                      )
                    ],
                  )
                ],
              ))
        ]),
      ),
    );
  }

  Widget buildScheduled_Activities_Title(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 30),
      child: Text(
        'Your daily medications',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget buildScheduled_Activities_card(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11), color: Colors.white),
              height: 85,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: -20,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: const Color(0xffFFDA7A).withOpacity(0.10),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/walking.svg',
                              height: 30,
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 60),
                        child: Text(
                          'Health Record',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11), color: Colors.white),
              height: 85,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: -20,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: const Color(0xff3EC6FF).withOpacity(0.10),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/medication 1.svg',
                              height: 40,
                              width: 40,
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 60),
                        child: Text(
                          'medication history',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        )
      ],
    );
  }

  Widget buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 50,
            width: 180,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Reappointment',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xff4889FD),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)))),
          ),
          SizedBox(
            height: 50,
            width: 100,
            child: OutlinedButton(
              onPressed: null,
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                  const BorderSide(
                    color: Color(0xff6EA7FA),
                    width: 2,
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              child: const Text(
                'Back',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff6EA7FA),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
