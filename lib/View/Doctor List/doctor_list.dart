import 'package:doctor_clinic_token_app/View/Add%20Doctor/add_doctor.dart';
import 'package:doctor_clinic_token_app/View/Edit%20Doctor%20Profile/edit_profile.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorList/doctorlistNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class DoctorList extends StatefulWidget {
  const DoctorList({Key? key}) : super(key: key);

  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  DoctorListNotifier provider = DoctorListNotifier();
  int isSwitched = 1;
  int doctorId = 0;

  @override
  void initState() {
    Networkcheck().check().then((value) {
      print(value);
      if (value == false) {
        _showConnectionState();
      }
    });
    // TODO: implement initState
    super.initState();
    MySharedPreferences.instance.getDoctorId('doctorID').then((value) {
      setState(() {
        doctorId = value;
        print(doctorId);
      });
    });
    Future.delayed(Duration.zero, () {
      provider.doctorList(doctorId, 'null', 'null').then((value) {
        provider.notifyListeners();
      });
    });
  }

  // void toggleSwitch(bool value) {
  //   if (isSwitched == false) {
  //     setState(() {
  //       isSwitched = true;
  //     });
  //   } else {
  //     setState(() {
  //       isSwitched = false;
  //     });
  //   }
  // }

  void _showConnectionState() {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () {
            //connection == false ? Navigator.pop(context) : false;
            return Future.value(false);
          },
          child: AlertDialog(
            actions: [
              FlatButton(
                  onPressed: () {
                    Networkcheck().check().then((value) {
                      print(value);
                      if (value == true) {
                        Future.delayed(Duration.zero, () {
                          provider
                              .doctorList(doctorId, 'null', 'null')
                              .then((value) {
                            provider.notifyListeners();
                          });
                        });
                        Navigator.pop(context);
                      }
                    });
                  },
                  child: const Text(
                    'Retry',
                  ))
            ],
            title: Text(
              "No Internet Connection",
              style: const TextStyle(color: Colors.black),
            ),
            content: Text(
              "Please Check the internet connection",
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!kReleaseMode) {}
    return Consumer<DoctorListNotifier>(
      builder: (context, provider, _) {
        this.provider = provider;
        return ModalProgressHUD(
          inAsyncCall: provider.isLoading,
          color: Colors.transparent,
          child: buildBody(context),
        );
      },
    );
  }

  Widget buildBody(context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image(
              image: const AssetImage('assets/Home screen.png'),
              fit: BoxFit.fill,
              height:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? MediaQuery.of(context).size.height * 0.20
                      : MediaQuery.of(context).size.height * 0.115,
              width: MediaQuery.of(context).size.width,
            ),
            doctorList(context),
          ],
        ),
      ),
    );
  }

  Widget doctorList(context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 10.0, bottom: 0, left: 5.0, right: 5.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Doctor List',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              provider.doctorListClass.isEmpty
                  ? Container()
                  : SizedBox(
                      height: 25,
                      width: 65,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const AddDoctor(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(
                            const BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        child: FittedBox(
                          child: const Text(
                            'Add +',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 15.0, bottom: 5, left: 25.0, right: 25.0),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 0),
                    spreadRadius: 4,
                    blurRadius: 10),
              ],
            ),
            child: searchBar(context),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: provider.doctorListClass.isEmpty
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const AddDoctor(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueAccent.withOpacity(0.5),
                            width: 5,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              size: 100,
                              color: Colors.blueAccent.withOpacity(0.5),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Add Doctor',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : provider.doctorSerachClass.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.local_hospital_outlined,
                            size: 100,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'No Result Found',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: provider.doctorSerachClass.length,
                      itemBuilder: (BuildContext context, int index) {
                        return listItem1(index);
                      },
                    ),
        ),
      ],
    );
  }

  listItem(index) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 10.0, top: 10, left: 25, right: 25),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  EditProfile(
                userId: provider.doctorListClass[index].id.toString(),
                mobNumber: provider.doctorListClass[index].phone.toString(),
                fullName: provider.doctorListClass[index].name.toString(),
                address:
                    provider.doctorListClass[index].clinicAddress.toString(),
                specialization:
                    provider.doctorListClass[index].specialist.toString(),
                education: provider.doctorListClass[index].degree.toString(),
                email: provider.doctorListClass[index].email.toString(),
                gender: provider.doctorListClass[index].gender.toString(),
                licenseNo: provider.doctorListClass[index].licenceNo.toString(),
                patientAttend:
                    provider.doctorListClass[index].patientAttend.toString(),
                experience:
                    provider.doctorListClass[index].experience.toString(),
                about: provider.doctorListClass[index].about.toString(),
                pathImage: provider.doctorListClass[index].image.toString(),
              ),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffCAE7FC),
                offset: Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                provider.doctorListClass[index].image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          DataConstants.LIVE_BASE_URL +
                              '/' +
                              provider.doctorListClass[index].image.toString(),
                          width: 55,
                          height: 55,
                          fit: BoxFit.fill,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 55,
                          width: 55,
                          color: const Color(0xff67A0F8),
                          child: Center(
                            child: Text(
                              provider.doctorSerachClass[index].name!
                                  .substring(0, 1)
                                  .toUpperCase()
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 33,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.doctorSerachClass[index].name.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              provider.doctorListClass[index].degree.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            provider.doctorListClass[index].experience
                                    .toString() +
                                ' Yrs',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              provider.doctorListClass[index].specialist
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          FlutterSwitch(
                            width: 45,
                            height: 22,
                            toggleSize: 15,
                            value: provider.doctorListClass[index].status == 0
                                ? false
                                : true,
                            onToggle: (value) {
                              if (value == false) {
                                setState(() {
                                  provider.doctorListClass[index].status = 0;
                                  isSwitched = 0;
                                  provider.doctorList(
                                      doctorId,
                                      provider.doctorListClass[index].id
                                          .toString(),
                                      isSwitched.toString());
                                });
                              } else {
                                setState(() {
                                  provider.doctorListClass[index].status = 1;
                                  isSwitched = 1;
                                  provider.doctorList(
                                      doctorId,
                                      provider.doctorListClass[index].id
                                          .toString(),
                                      isSwitched.toString());
                                });
                              }
                            },
                            borderRadius: 7,
                            activeColor: const Color(0xff5A95FD),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  listItem1(index) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 10.0, top: 10, left: 25, right: 25),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  EditProfile(
                userId: provider.doctorSerachClass[index].id.toString(),
                mobNumber: provider.doctorSerachClass[index].phone.toString(),
                fullName: provider.doctorSerachClass[index].name.toString(),
                address:
                    provider.doctorSerachClass[index].clinicAddress.toString(),
                specialization:
                    provider.doctorSerachClass[index].specialist.toString(),
                education: provider.doctorSerachClass[index].degree.toString(),
                email: provider.doctorSerachClass[index].email.toString(),
                gender: provider.doctorSerachClass[index].gender.toString(),
                licenseNo: provider.doctorSerachClass[index].licenceNo == 'null'
                    ? ''
                    : provider.doctorSerachClass[index].licenceNo.toString(),
                patientAttend:
                    provider.doctorSerachClass[index].patientAttend.toString(),
                experience:
                    provider.doctorSerachClass[index].experience.toString(),
                about: provider.doctorSerachClass[index].about.toString(),
                pathImage: provider.doctorSerachClass[index].image.toString(),
              ),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffCAE7FC),
                offset: Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    provider.doctorSerachClass[index].image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              DataConstants.LIVE_BASE_URL +
                                  '/' +
                                  provider.doctorSerachClass[index].image
                                      .toString(),
                              width: 55,
                              height: 55,
                              fit: BoxFit.fill,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 55,
                              width: 55,
                              color: const Color(0xff67A0F8),
                              child: Center(
                                child: Text(
                                  provider.doctorSerachClass[index].name!
                                      .substring(0, 1)
                                      .toUpperCase()
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 33,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr. ' +
                                provider.doctorSerachClass[index].name
                                    .toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  provider.doctorSerachClass[index].degree
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.local_hospital_rounded,
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        provider.doctorSerachClass[index].specialist.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.verified,
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      provider.doctorSerachClass[index].experience.toString() +
                          ' Years',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    FlutterSwitch(
                      width: 45,
                      height: 22,
                      toggleSize: 15,
                      value: provider.doctorSerachClass[index].status == 0
                          ? false
                          : true,
                      onToggle: (value) {
                        if (value == false) {
                          setState(() {
                            provider.doctorSerachClass[index].status = 0;
                            isSwitched = 0;
                            provider.doctorList(
                                doctorId,
                                provider.doctorSerachClass[index].id.toString(),
                                isSwitched.toString());
                          });
                        } else {
                          setState(() {
                            provider.doctorSerachClass[index].status = 1;
                            isSwitched = 1;
                            provider.doctorList(
                                doctorId,
                                provider.doctorSerachClass[index].id.toString(),
                                isSwitched.toString());
                          });
                        }
                      },
                      borderRadius: 7,
                      activeColor: const Color(0xff5A95FD),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  searchBar(context) {
    return TextFormField(
      // validator: validateConfirmPassword,
      // controller: _confirmpassword,
      // obscureText: _isObscure1,
      onChanged: (text) {
        text = text.toLowerCase();
        setState(() {
          provider.doctorSerachClass = provider.doctorListClass.where((note) {
            var noteTile = note.name!.toLowerCase();
            return noteTile.contains(text);
          }).toList();
        });
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        suffixIcon: Container(
          decoration: BoxDecoration(
            color: const Color(0xff4889FD),
            borderRadius: BorderRadius.circular(45),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ),
        hintText: 'Search doctors',
        hintStyle: const TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }
}
