import 'package:doctor_clinic_token_app/core/request_response/updatePolicy/updatePolicyNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:enough_html_editor/enough_html_editor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class UpdateAboutUs extends StatefulWidget {
  final id;
  final doctorId;
  final content;

  UpdateAboutUs({Key? key, this.id, this.content, this.doctorId})
      : super(key: key);

  @override
  State<UpdateAboutUs> createState() => _UpdateAboutUsState();
}

class _UpdateAboutUsState extends State<UpdateAboutUs> {
  UpdatePolicyNotifier provider = UpdatePolicyNotifier();

  HtmlEditorApi? _editorApi;
  String result = '';
  String _htmlContent = '';
  String updatedText = '';

  @override
  initState() {
    Networkcheck().check().then((value) {
      print(value);
      if (value == false) {
        _showConnectionState();
      }
    });
    // Future.delayed(Duration.zero, () {
    //   provider.updatePolicy(widget.doctorId, widget.id, privacyPolicy, aboutUs, termsAndCondition);
    //   provider.notifyListeners();
    //   print(provider.privacyPolicyClass[0].clinicPrivacyPolicy);
    //   //print(provider.privacyPolicy_ResponseClass.updateDate.toString());
    // });
    // TODO: implement initState
    super.initState();
    print(widget.id);
    print(widget.content);
    _htmlContent = widget.content;
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
                        // Future.delayed(Duration.zero, () {
                        //     //provider.privacyPolicy();
                        //    provider.notifyListeners();
                        //    print(provider
                        //        .privacyPolicyClass[0].clinicPrivacyPolicy);
                        //    //print(provider.privacyPolicy_ResponseClass.updateDate.toString());
                        //  });
                        Navigator.pop(context);
                      }
                    });
                  },
                  child: const Text(
                    'Retry',
                  ))
            ],
            title: const Text(
              "No Internet Connection",
              style: TextStyle(color: Colors.black),
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
    return Consumer<UpdatePolicyNotifier>(
      builder: (context, provider, _) {
        this.provider = provider;
        return ModalProgressHUD(
          inAsyncCall: provider.isloading,
          color: Colors.transparent,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Update About Us'),
              actions: [
                IconButton(
                  onPressed: () async {
                    // updatedText = await _editorApi!.getText().toString();
                    // print(updatedText);
                    // provider.updatePolicy(widget.doctorId, widget.id, 'null',
                    //     updatedText, 'null');
                    final newUpdatedText = await _editorApi!.getText();
                    print(updatedText);
                    await provider.updatePolicy(widget.doctorId, widget.id,
                        'null', newUpdatedText, 'null');
                  },
                  icon: const Icon(Icons.check),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: PackagedHtmlEditor(
                      onCreated: (api) {
                        _editorApi = api;
                      },
                      initialContent: _htmlContent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
