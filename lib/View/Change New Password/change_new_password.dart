import 'package:doctor_clinic_token_app/Utils/common/app_text_style.dart';
import 'package:doctor_clinic_token_app/Utils/common/app_validators.dart';
import 'package:doctor_clinic_token_app/core/request_response/changenewpassword/changepasswordNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeNewPassword extends StatefulWidget {
  const ChangeNewPassword({Key? key}) : super(key: key);

  @override
  _ChangeNewPasswordState createState() => _ChangeNewPasswordState();
}

class _ChangeNewPasswordState extends State<ChangeNewPassword> {
  bool _isObscure = true;
  bool _isObscure1 = true;
  SharedPreferences? sharedPreferences;
  String forgetEmail = '';

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _keyscafflod = GlobalKey<ScaffoldState>();
  late ChangePasswordNotifier? changePasswordNotifier;
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();

  String? validateConfirmPassword(String? formConfirmPassword) {
    if (formConfirmPassword!.isEmpty) {
      return "Password Is Required";
    }
    if (_password.text != formConfirmPassword) {
      return "Password Does Not Match";
    }
    return null;
  }

  void getEmail() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        forgetEmail = sharedPreferences?.getString('forgetemail') ?? '';
        print(forgetEmail);
      });
    }
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

  @override
  Widget build(BuildContext context) {
    if (!kReleaseMode) {}
    return Consumer<ChangePasswordNotifier>(
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image(
              image: const AssetImage('assets/dashboard.png'),
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                backButton(context),
                buildChangeNewpassword(context),
                buildChangepassPara(context),
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      buildPassword(context),
                      buildConfirmPassword(context),
                    ],
                  ),
                ),
                buildConfirmButton(context),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget backButton(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.04,
          top: MediaQuery.of(context).orientation == Orientation.landscape
              ? MediaQuery.of(context).size.height * 0.09
              : MediaQuery.of(context).size.height * 0.05,
        ),
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
      ),
    );
  }

  Widget buildBackButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.05,
          left: MediaQuery.of(context).size.width * 0.04),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white, width: 2.0),
          ),
          width: 35,
          height: 35,
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildChangeNewpassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.3,
          left: MediaQuery.of(context).size.width * 0.04),
      child: Text('Change New Password', style: TextHeadingStyle(context)),
    );
  }

  Widget buildChangepassPara(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.01,
          left: MediaQuery.of(context).size.width * 0.05),
      child: Text(
          'Your new password must be different from previous used passwords.',
          style: TextParaStyle(context)),
    );
  }

  Widget buildPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.03,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        validator: validatePassword,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: _password,
        obscureText: _isObscure,
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
                icon:
                    Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
            ),
            hintText: 'Password',
            hintStyle: TextFieldStyle(context)),
      ),
    );
  }

  Widget buildConfirmPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.025,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
          validator: validateConfirmPassword,
          controller: _confirmpassword,
          obscureText: _isObscure1,
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
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon:
                    Icon(_isObscure1 ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscure1 = !_isObscure1;
                  });
                },
              ),
            ),
            hintText: 'Confirm Password',
            hintStyle: TextFieldStyle(context),
          )),
    );
  }

  Widget buildConfirmButton(BuildContext context) {
    changePasswordNotifier =
        Provider.of<ChangePasswordNotifier?>(context, listen: false);
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.1,
        ),
        child: SizedBox(
          height: 50,
          width: 234,
          child: ElevatedButton(
              onPressed: () {
                if (_key.currentState!.validate()) {
                  changePasswordNotifier?.doctorChangePassword(
                    forgetEmail,
                    _password.text.trim(),
                    _confirmpassword.text.trim(),
                  );
                }
                // if (_key.currentState!.validate()) {
                //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //     content: const Text('Password Changed'),
                //   ));
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => Login()));
                // }
              },
              style: getButtonStyle(context),
              child: Text('Update',
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextButtonStyle(context))),
        ),
      ),
    );
  }
}
