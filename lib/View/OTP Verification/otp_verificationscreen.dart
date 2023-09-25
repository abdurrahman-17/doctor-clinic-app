import 'package:doctor_clinic_token_app/Utils/common/app_text_style.dart';
import 'package:doctor_clinic_token_app/core/request_response/forgetpassword/forgetpasswordNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/otpVerify/OtpVerifyNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late ForgetPasswordNotifier? forgetPasswordNotifier;
  final _otpcontroller = TextEditingController();
  final _keyscafflod = GlobalKey<ScaffoldState>();
  late OtpVerifyNotifier? otpVerifyNotifier;
  SharedPreferences? sharedPreferences;
  String? forgetEmail;

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
    getEmail();
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
                  child: Text(
                    'Retry',
                  ))
            ],
            title: new Text(
              "No Internet Connection",
              style: TextStyle(color: Colors.black),
            ),
            content: new Text(
              "Please Check the internet connection",
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
        );
      },
    );
  }

  void getEmail() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        forgetEmail = sharedPreferences?.getString('forgetemail');
        print(forgetEmail);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!kReleaseMode) {}
    return Consumer<OtpVerifyNotifier>(
      builder: (context, provider, _) {
        return ModalProgressHUD(
          inAsyncCall: provider.isLoading,
          color: Colors.transparent,
          child: Scaffold(
              key: _keyscafflod,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: buildBody(context)),
        );
      },
    );
  }

  Widget buildBody(context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Image(
            image: const AssetImage('assets/dashboard.png'),
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.04,
                right: MediaQuery.of(context).size.width * 0.04,
                top: MediaQuery.of(context).orientation == Orientation.landscape
                    ? MediaQuery.of(context).size.height * 0.09
                    : MediaQuery.of(context).size.height * 0.05,
                bottom: MediaQuery.of(context).size.height * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                backButton(context),
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                titleText(context),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                otpVerificationText(context),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                verificationTextField(context),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                buttonRequestOTP(context),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                didnotRecieveText(context),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                resendOtpText(context),
              ],
            ),
          ),
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
          borderRadius: const BorderRadius.all(Radius.circular(20))),
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

  Widget titleText(context) {
    return Text('OTP Verification', style: TextHeadingStyle(context));
  }

  Widget otpVerificationText(context) {
    return Text(
        'Enter the verification code we just sent you on your email address',
        style: TextParaStyle(context));
  }

  Widget verificationTextField(context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 1,
        child: PinCodeTextField(
          controller: _otpcontroller,
          length: 4,
          obscureText: true,
          showCursor: false,
          //blinkWhenObscuring: true,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(18),
            borderWidth: 0,
            fieldWidth: 75,
            fieldHeight: 75,
            activeColor: Colors.white,
            inactiveColor: Colors.white,
            activeFillColor: Colors.white,
            inactiveFillColor: Colors.white,
            selectedFillColor: Colors.white,
          ),
          enableActiveFill: true,

          keyboardType: TextInputType.number,
          //backgroundColor: Colors.white,
          onChanged: (value) {
            print(value);
          },
          appContext: context,
        ),
      ),
    );
  }

  Widget buttonRequestOTP(context) {
    otpVerifyNotifier = Provider.of<OtpVerifyNotifier?>(context, listen: false);
    return Center(
      child: SizedBox(
        height: 50,
        width: 234,
        child: ElevatedButton(
          style: getButtonStyle(context),
          child: Text('Submit', style: TextButtonStyle(context)),
          onPressed: () {
            otpVerifyNotifier?.doctorOtpVerify(
                forgetEmail!, _otpcontroller.text.trim());
            // Navigator.push(context, MaterialPageRoute(builder: (context)=> const ChangeNewPassword()));
            // Navigator.pushNamed(context, RoutePaths.CHANGENEWPASSWORD);
          },
        ),
      ),
    );
  }

  Widget didnotRecieveText(context) {
    return const Center(
      child: Text(
        'Didn\'t receive OTP? ',
        style: TextStyle(
          fontSize: 13,
        ),
      ),
    );
  }

  Widget resendOtpText(context) {
    forgetPasswordNotifier =
        Provider.of<ForgetPasswordNotifier?>(context, listen: false);
    return Center(
      child: InkWell(
        child: Text(
          'Resend',
          textAlign: TextAlign.center,
          style: TextResendStyle(context),
        ),
        onTap: () {
          forgetPasswordNotifier?.doctorForgetPassword(forgetEmail.toString());
        },
      ),
    );
  }
}
