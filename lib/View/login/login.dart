import 'dart:io';

import 'package:doctor_clinic_token_app/Utils/common/app_text_style.dart';
import 'package:doctor_clinic_token_app/View/ForgetScreen/forget_screen.dart';
import 'package:doctor_clinic_token_app/View/Register/register.dart';
import 'package:doctor_clinic_token_app/core/request_response/login/loginNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:doctor_clinic_token_app/utils/common/app_validators.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _key = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _keyscafflod = GlobalKey<ScaffoldState>();
  late LoginNotifier? loginNotifier;
  String deviceType = '';
  String fcmKey = '';
  bool _isObscure = true;

  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((newToken) {
      print("FCM Token $newToken");
      fcmKey = newToken.toString();
    });
    Networkcheck().check().then((value) {
      print(value);
      if (value == false) {
        _showConnectionState();
      }
    });
    // TODO: implement initState
    if (Platform.isIOS) {
      deviceType = 'IOS';
    } else if (Platform.isAndroid) {
      deviceType = 'Android';
    }
    super.initState();

    //
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog();
    //       });
    // });
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
    return Consumer<LoginNotifier>(
      builder: (context, provider, _) {
        return ModalProgressHUD(
          inAsyncCall: provider.isLoading,
          color: Colors.transparent,
          child: Scaffold(
            key: _keyscafflod,
            body: buildBody(context),
          ),
        );
      },
    );
  }

  Widget buildBody(context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          backgroundImage(context),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              welcomeText(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
              ),
              Form(
                key: _key,
                child: Column(
                  children: [
                    buildEmail(context),
                    buildPassword(context),
                  ],
                ),
              ),
              buildForgotPass(context),
              buildLoginButton(context),
              //buildYouhaveanac(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget backgroundImage(context) {
    return Image(
      image: const AssetImage('assets/dashboard.png'),
      fit: BoxFit.fill,
      height: MediaQuery.of(context).orientation == Orientation.landscape
          ? MediaQuery.of(context).size.height * 0.4
          : MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget welcomeText(context) {
    return Column(
      children: [
        const Text(
          'Welcome Back To Clinic',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'LogIn',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 28,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget buildEntry(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius:
              const BorderRadius.only(bottomRight: Radius.circular(85))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Welcome Back To Clinic',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 28,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLogintitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.03,
      ),
      child: const Center(
        child: Text(
          'Log In',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 25,
            color: Color(0xff5B5B5B),
          ),
        ),
      ),
    );
  }

  Widget buildEmail(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.1,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        controller: _emailcontroller,
        validator: validateEmail,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.mail),
          ),
          hintText: 'Email',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget buildPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.025,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        controller: _passwordcontroller,
        validator: validateSimplePassword,
        obscureText: _isObscure,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.vpn_key),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: IconButton(
              icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            ),
          ),
          hintText: 'Password',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget buildForgotPass(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.01,
          right: MediaQuery.of(context).size.width * 0.04),
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ForgetScreen(),
              ),
            );
          },
          child: const Text(
            'Forgot Password ?',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xff7B859A),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginButton(BuildContext context) {
    loginNotifier = Provider.of<LoginNotifier?>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.08,
          bottom: MediaQuery.of(context).size.height * 0.01),
      child: SizedBox(
        width: 235,
        height: 50,
        child: ElevatedButton(
          style: getButtonStyle(context),
          onPressed: () async {
            if (_key.currentState!.validate()) {
              loginNotifier?.doctorLogin(
                _emailcontroller.text.trim(),
                _passwordcontroller.text.trim(),
                deviceType,
                fcmKey,
              );
            }
          },
          child: Text(
            'Login',
            style: TextButtonStyle(context),
          ),
        ),
      ),
    );
  }

  Widget buildYouhaveanac(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.012,
          bottom: MediaQuery.of(context).size.height * 0.05),
      child: RichText(
        text: TextSpan(
          text: 'You don\'t have an account',
          style: TextForgetStyle(context),
          children: [
            TextSpan(
              text: ' Register',
              style: RichtextStyle(context),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
            ),
          ],
        ),
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    );
  }
}
