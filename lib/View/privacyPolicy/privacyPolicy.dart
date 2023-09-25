import 'package:doctor_clinic_token_app/View/privacyPolicy/updatePrivacyPolicy.dart';
import 'package:doctor_clinic_token_app/core/request_response/privacyPolicy/privacyPolicyNotidier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class Privacy_Policy extends StatefulWidget {
  Privacy_Policy({Key? key}) : super(key: key);

  @override
  State<Privacy_Policy> createState() => _Privacy_PolicyState();
}

class _Privacy_PolicyState extends State<Privacy_Policy> {
  PrivacyPolicyNotifier provider = PrivacyPolicyNotifier();

  int doctorId = 0;

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
    Future.delayed(Duration.zero, () {
      provider.privacyPolicy(doctorId);
      provider.notifyListeners();
      // print(provider.privacyPolicyClass[0].clinicPrivacyPolicy);
      //print(provider.privacyPolicy_ResponseClass.updateDate.toString());
    });
    // TODO: implement initState
    super.initState();
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
                          provider.privacyPolicy(doctorId);
                          provider.notifyListeners();
                          // print(provider
                          //     .privacyPolicyClass[0].clinicPrivacyPolicy);
                          //print(provider.privacyPolicy_ResponseClass.updateDate.toString());
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
    return Consumer<PrivacyPolicyNotifier>(
      builder: (context, provider, _) {
        this.provider = provider;
        return ModalProgressHUD(
            inAsyncCall: provider.isloading,
            color: Colors.transparent,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 0,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: const Text('Privacy Policy'),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdatePrivacyPolicy(
                              id: provider.privacyPolicyClass[0].id ?? 0,
                              content: provider.privacyPolicyClass[0]
                                      .clinicPrivacyPolicy ??
                                  "",
                              doctorId: doctorId,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   children: [
                      //     Image.network(DataConstants.LIVE_BASE_URL+'/'+'logo/icons8-terms-and-conditions-64.png',height: 80,width: 80,fit: BoxFit.fill,),
                      //     Text('Terms And Conditions',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w800),)
                      //   ],
                      // ),
                      Image.asset(
                        'assets/privacy-policy-illustration-design-concept-illustration-websites-landing-pages-mobile-applications-posters-banners_108061-890.jpg',
                        height: 300,
                        width: double.infinity,
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(left: 15),
                      //   child: Row(
                      //     children: [
                      //       Flexible(child: Text('Last Updated: ',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),)),
                      //       Flexible(child: Html(data: provider.termsAndConditions_Date_ResponseClass.updateDate)),
                      //     ],
                      //   ),
                      // ),
                      Html(
                          data: provider.privacyPolicyClass.isEmpty
                              ? ""
                              : provider
                                  .privacyPolicyClass[0].clinicPrivacyPolicy)
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
