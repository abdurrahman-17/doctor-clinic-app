import 'package:doctor_clinic_token_app/View/Patient%20Info/patient_info.dart';
import 'package:flutter/material.dart';

class ReAppointmentScreen extends StatefulWidget {
  const ReAppointmentScreen({Key? key}) : super(key: key);

  @override
  _ReAppointmentScreenState createState() => _ReAppointmentScreenState();
}

class _ReAppointmentScreenState extends State<ReAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Image(
            image: const AssetImage('assets/verysmall.png'),
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height * 0.13,
            width: MediaQuery.of(context).size.width,
          ),
          Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        backButton(context),
                        const SizedBox(
                          height: 10,
                        ),
                        headingText(context),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        searchAndFilter(context),
                        const SizedBox(
                          height: 15,
                        ),
                        listViewBuilder(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
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

  Widget headingText(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Reappointment',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget searchAndFilter(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 0),
                  spreadRadius: 4,
                  blurRadius: 10),
            ],
          ),
          child: TextFormField(
            // validator: validateConfirmPassword,
            // controller: _confirmpassword,
            // obscureText: _isObscure1,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.search,
                ),
              ),
              suffixIcon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff4889FD),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Text(
                    'Search',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              hintText: 'Search for your products',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.filter_list),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color(0xff4889FD),
            ),
          ),
          label: const Text(
            "Filter",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget listViewBuilder(context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const PatientInfo()));
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff3284E5).withOpacity(0.25),
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              height: 60,
                              width: 60,
                              color: const Color(0xff5E698F),
                              child: const Center(
                                child: Text(
                                  'S',
                                  style: TextStyle(fontSize: 33),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Sita Pharmacy',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Text(
                                  'Allergies',
                                  style: TextStyle(
                                    color: Color(0xffABAFB3),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: Color(0xffABAFB3),
                                    ),
                                    Text(
                                      '22/1/2022',
                                      style: TextStyle(
                                        color: Color(0xffABAFB3),
                                        fontSize: 14,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      'view',
                                      style: TextStyle(
                                        color: Color(0xff4889FD),
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
