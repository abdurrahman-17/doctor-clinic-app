import 'package:doctor_clinic_token_app/Utils/common/app_font.dart';
import 'package:doctor_clinic_token_app/Utils/common/app_text_style.dart';
import 'package:doctor_clinic_token_app/Utils/common/app_validators.dart';
import 'package:doctor_clinic_token_app/core/request_response/forgetpassword/forgetpasswordNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({Key? key}) : super(key: key);

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();
  final _keyscafflod = GlobalKey<ScaffoldState>();
  late ForgetPasswordNotifier? forgetPasswordNotifier;
  SharedPreferences? sharedPreferences;

  Future<void> initializePreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences?.setString('forgetemail', _emailcontroller.text);
  }

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
    return Consumer<ForgetPasswordNotifier>(
      builder: (context, provider, _) {
        return ModalProgressHUD(
          inAsyncCall: provider.isLoading,
          color: Colors.transparent,
          child: buildBody(context),
        );
      },
    );
  }

  Widget buildBody(context) {
    return Scaffold(
      key: _keyscafflod,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            backgroundImage(context),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.04,
                  right: MediaQuery.of(context).size.width * 0.04,
                  top: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? MediaQuery.of(context).size.height * 0.09
                      : MediaQuery.of(context).size.height * 0.05,
                  bottom: MediaQuery.of(context).size.height * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  backButton(context),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                  titleText(context),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  emailTextField(context),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  buttonRequestOTP(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget backgroundImage(context) {
    return Image(
      image: const AssetImage('assets/dashboard.png'),
      fit: BoxFit.fill,
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget backButton(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: const Padding(
          padding: EdgeInsets.only(left: 6),
          child: Icon(
            Icons.arrow_back_ios,
            size: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget titleText(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Forget Password',
          style: TextHeadingStyle(context),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
            'Enter the email associated with your account and we\'ll send an email with OTP to reset your password',
            style: TextStyle(
              fontWeight: AppFont.fontWeightRegular,
              fontSize: 13,
              color: Colors.black54,
            )),
      ],
    );
  }

  Widget emailTextField(context) {
    return Form(
      key: _key,
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
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Icon(Icons.mail),
            ),
            hintText: 'Email',
            hintStyle: TextFieldStyle(context)),
      ),
    );
  }

  Widget buttonRequestOTP(context) {
    forgetPasswordNotifier =
        Provider.of<ForgetPasswordNotifier?>(context, listen: false);
    return Center(
      child: SizedBox(
        height: 50,
        width: 234,
        child: ElevatedButton(
          style: getButtonStyle(context),
          child: Text(
            'Request OTP',
            style: TextButtonStyle(context),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            initializePreference();

            // Navigator.push(context, MaterialPageRoute(builder: (context)=> const OtpVerification()));
            if (_key.currentState!.validate()) {
              forgetPasswordNotifier
                  ?.doctorForgetPassword(_emailcontroller.text.trim());
            }
          },
        ),
      ),
    );
  }
}
