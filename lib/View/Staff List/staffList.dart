import 'package:doctor_clinic_token_app/View/Add%20Staff/addStaff.dart';
import 'package:doctor_clinic_token_app/View/Edit%20Staff/editStaff.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/staffList/stafflistNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class StaffList extends StatefulWidget {
  const StaffList({Key? key}) : super(key: key);

  @override
  _StaffListState createState() => _StaffListState();
}

class _StaffListState extends State<StaffList> {
  StaffListNotifier provider = StaffListNotifier();
  int isSwitched = 1;
  int doctorId = 0;

  final searchController = TextEditingController();

  @override
  void initState() {
    Networkcheck().check().then((value) {
      print(value);
      if (value == false) {
        _showConnectionState();
      }
    });
    MySharedPreferences.instance.getDoctorId('doctorID').then((value) {
      setState(() {
        doctorId = value;
        print(doctorId);
      });
    });
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      provider.staffList(doctorId, 'null', 'null').then((value) {
        provider.notifyListeners();
      });
    });
  }

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
                              .staffList(doctorId, 'null', 'null')
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

  // void toggleSwitch(value) {
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

  @override
  Widget build(BuildContext context) {
    if (!kReleaseMode) {}
    return Consumer<StaffListNotifier>(
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
                      ? MediaQuery.of(context).size.height * 0.25
                      : MediaQuery.of(context).size.height * 0.115,
              width: MediaQuery.of(context).size.width,
            ),
            staffList(context),
          ],
        ),
      ),
    );
  }

  Widget staffList(context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 10.0, bottom: 0.0, left: 5.0, right: 5.0),
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
                'Nurse List',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              provider.staffListClass.isEmpty
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
                                      const AddStaff(),
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
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 0),
                  spreadRadius: 4,
                  blurRadius: 10,
                ),
              ],
            ),
            child: TextFormField(
              // validator: validateConfirmPassword,
              controller: searchController,
              // obscureText: _isObscure1,
              onChanged: (text) {
                text = text.toLowerCase();
                setState(() {
                  provider.staffSearchClass =
                      provider.staffListClass.where((note) {
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
                  borderRadius: BorderRadius.circular(45),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff4889FD),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
                hintText: 'Search staff',
                hintStyle: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: provider.staffListClass.isEmpty
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const AddStaff(),
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
                              'Add Nurse',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: provider.staffSearchClass.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10.0, right: 25.0, left: 25.0, top: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      EditStaff(
                                staffId: provider.staffSearchClass[index].id
                                    .toString(),
                                mobNumber: provider.staffSearchClass[index].phone
                                    .toString(),
                                fullName: provider.staffSearchClass[index].name
                                    .toString(),
                                email: provider.staffSearchClass[index].email
                                    .toString(),
                                address: provider.staffSearchClass[index].address
                                    .toString(),
                                pathImage: provider.staffSearchClass[index].image
                                    .toString(),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 100,
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
                                provider.staffSearchClass[index].image != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          DataConstants.LIVE_BASE_URL +
                                              '/' +
                                              provider
                                                  .staffSearchClass[index].image
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
                                              provider
                                                  .staffSearchClass[index].name!
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              provider
                                                  .staffSearchClass[index].name
                                                  .toString(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
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
                                            value: provider
                                                        .staffSearchClass[index]
                                                        .status ==
                                                    0
                                                ? false
                                                : true,
                                            onToggle: (value) {
                                              if (value == false) {
                                                setState(() {
                                                  provider.staffSearchClass[index]
                                                      .status = 0;
                                                  isSwitched = 0;
                                                  provider.staffList(
                                                      doctorId,
                                                      provider
                                                          .staffSearchClass[index]
                                                          .id
                                                          .toString(),
                                                      isSwitched.toString());
                                                });
                                              } else {
                                                setState(() {
                                                  provider.staffSearchClass[index]
                                                      .status = 1;
                                                  isSwitched = 1;
                                                  provider.staffList(
                                                      doctorId,
                                                      provider
                                                          .staffSearchClass[index]
                                                          .id
                                                          .toString(),
                                                      isSwitched.toString());
                                                });
                                              }
                                            },
                                            borderRadius: 7,
                                            activeColor:
                                                const Color(0xff5A95FD),
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
                  },
                ),
        ),
      ],
    );
  }
}
