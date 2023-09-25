import 'package:doctor_clinic_token_app/Utils/common/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Pharmacy extends StatefulWidget {
  const Pharmacy({Key? key}) : super(key: key);

  @override
  _PharmacyState createState() => _PharmacyState();
}

class _PharmacyState extends State<Pharmacy> {
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
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Positioned(
            top: -15,
            right: -30,
            child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.black.withOpacity(0.05),
                child: SvgPicture.asset(
                  'assets/images/Vector.svg',
                  color: Colors.white.withOpacity(0.1),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildGoodmornTitle(context),
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

  Widget buildGoodmornTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 50,
        ),
        Text(
          'Good Morning',
          style: GoodmornTitle(context),
        ),
        Text(
          'Mark',
          style: GoodmornTitle(context),
        )
      ],
    );
  }

  Widget buildGridview(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
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
                  padding: const EdgeInsets.only(left: 30,top: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/images/HeartBeat.svg'),
                      const SizedBox(width: 8,),
                      Text('Heartbeat',style: Heartbeatstyle(context),)

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23,vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('66',style: Tempstyle(context),),
                      Text('bpm',style: Bpmstyle(context),)
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
                  padding: const EdgeInsets.only(left: 30,top: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/images/carbon_temperature-feels-like.svg'),
                      const SizedBox(width: 8,),
                      Text('Temperature',style: Heartbeatstyle(context),)

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23,vertical: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('37/35',style: Tempstyle(context),),
                      Text('°F',style: Fahrenheitestyle(context),)
                    ],
                  ),
                ),
              ],
            ),

          )      ],
      ),
    );
  }
  Widget buildYourDailyMedication(BuildContext context){
    return
      Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Text('Your daily medications',style: YoudailyMedicationstyle(context),),
      );
  }
  Widget buildbloodPandDaibetes(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Colors.white
                    ),
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
                              padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/images/Blood Drop.svg',height: 28,width: 18,),
                                  const Spacer(),
                                  Text('8-9 AM',style: bloodpressureTimestyle(context),)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20,top: 20),
                              child: Text('Blood Pressure',style: bloodpressureTitlestyle(context),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: RichText(text: const TextSpan(text: '144/80',style: TextStyle(color: Color(0xff486581),fontWeight: FontWeight.w600,fontSize: 17),
                                  children:[
                                    TextSpan(text: '  mmHg',style: TextStyle(color: Color(0xff486581),fontWeight: FontWeight.w300,fontSize: 17))
                                  ]

                              ),),
                            )
                          ],
                        )
                      ],
                    )
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white
                  ),
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
                            padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/images/blood pressure.svg',height: 28,width: 18,),
                                const Spacer(),
                                Text('8-9 AM',style: bloodpressureTimestyle(context),)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,top: 20),
                            child: Text('Blood Pressure',style: bloodpressureTitlestyle(context),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: RichText(text: const TextSpan(text: '126',style: TextStyle(color: Color(0xff486581),fontWeight: FontWeight.w600,fontSize: 17),
                                children:[
                                  TextSpan(text: '  mg/dl',style: TextStyle(color: Color(0xff486581),fontWeight: FontWeight.w300,fontSize: 17))
                                ]

                            ),),
                          )
                        ],
                      )
                    ],
                  )
              )
            ]),
      ),
    );
  }
  Widget buildScheduled_Activities_Title(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Text('Your daily medications',style: YoudailyMedicationstyle(context),),
    );
  }
  Widget buildScheduled_Activities_card(BuildContext context){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: Colors.white
              ),
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
                            SvgPicture.asset('assets/images/walking.svg',height: 30,width: 20,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: Text('Health Record',style: healthRecordstyle(context),),
                      ),
                    ],
                  )
                ],
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: Colors.white,
              ),
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
                            SvgPicture.asset('assets/images/medication 1.svg',height: 40,width: 40,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: Text('medication history',style: healthRecordstyle(context),),
                      ),
                    ],
                  )
                ],
              )
          ),
        )
      ],
    );

  }
  Widget buildButton(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10,top: 20),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(onPressed: (){
          Navigator.pop(context);
        },
            child: const Text('Back',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
            style: ElevatedButton.styleFrom(primary:const Color(0xff4889FD),shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)))
        ),
      ),
    );
  }

}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xff4889FD);
    Path path = Path()
      ..relativeLineTo(0, 200)
      ..quadraticBezierTo(size.width / 1.9, 300.0, size.width, 185)
      ..relativeLineTo(0, -185)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}