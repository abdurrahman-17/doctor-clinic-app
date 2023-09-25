import 'package:doctor_clinic_token_app/core/request_response/addContentMeasurment/addContentMeasurementNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/deleteContentMeasurement/deleteContentMeasurementNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/editContentMeasurement/editContentMeasurementNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/getContentMeasurement/getContentMeasurementNotifier.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ManageContentMeasurement extends StatefulWidget {
  const ManageContentMeasurement({Key? key}) : super(key: key);

  @override
  State<ManageContentMeasurement> createState() =>
      _ManageContentMeasurementState();
}

class _ManageContentMeasurementState extends State<ManageContentMeasurement> {
  GetContentMeasuremnetNotifier getContentMeasuremnetNotifier =
      GetContentMeasuremnetNotifier();
  AddContentMeasurementNotifier addContentMeasurementNotifier =
      AddContentMeasurementNotifier();
  DeleteContentMeasurementNotifier deleteContentMeasurementNotifier =
      DeleteContentMeasurementNotifier();
  EditContentMeasurementNotifier editContentMeasurementNotifier =
      EditContentMeasurementNotifier();
  final contentController = TextEditingController();
  final List<TextEditingController> _controllers = [];
  List<bool> isBool = [];
  int doctorId = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    MySharedPreferences.instance.getDoctorId('doctorID').then((value) {
      setState(() {
        doctorId = value;
        print(doctorId);
      });
    });

    Future.delayed(Duration.zero, () async {
      await getContentMeasuremnetNotifier.getContentMeasurement();
      getContentMeasuremnetNotifier.notifyListeners();

      for (int i = 0;
          i < getContentMeasuremnetNotifier.getContentMeasurementClass.length;
          i++) {
        _controllers.add(
          TextEditingController(
            text: getContentMeasuremnetNotifier
                .getContentMeasurementClass[i].unitName,
          ),
        );
        isBool.add(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetContentMeasuremnetNotifier>(
      builder: (context, provider, _) {
        getContentMeasuremnetNotifier = provider;
        return ModalProgressHUD(
          inAsyncCall: provider.isLoading,
          child: Scaffold(
            body: buildBody(context),
          ),
        );
      },
    );
  }

  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Image(
            image: const AssetImage('assets/dashboardmain.png'),
            fit: BoxFit.fill,
            height: MediaQuery.of(context).orientation == Orientation.landscape
                ? MediaQuery.of(context).size.height * 0.20
                : MediaQuery.of(context).size.height * 0.115,
            width: MediaQuery.of(context).size.width,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backButton(context),
              const SizedBox(
                height: 25,
              ),
              searchBar(context),
              const SizedBox(
                height: 20,
              ),
              medicineList(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget backButton(context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 20.0, bottom: 10, left: 5.0, right: 15.0),
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
            'Measurement List',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBar(context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 15.0, bottom: 5, left: 25.0, right: 25.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
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
          controller: contentController,
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
              child: GestureDetector(
                onTap: () {
                  addContentMeasurementNotifier.addContentMeasurement(
                    doctorId,
                    contentController.text,
                  );
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            hintText: 'Add Content Measurement',
            hintStyle: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget medicineList(context) {
    return Expanded(
      child: _controllers.isEmpty
          ? Container()
          : ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: getContentMeasuremnetNotifier
                  .getContentMeasurementClass.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, left: 10.0),
                  child: ListTile(
                    leading: const FaIcon(
                      FontAwesomeIcons.weightScale,
                      color: Colors.blueAccent,
                    ),
                    title: TextField(
                      controller: _controllers[index],
                      // onChanged: (text) {
                      //   _controllers.add(
                      //     TextEditingController(
                      //       text: _controllers[index].text,
                      //     ),
                      //   );
                      // },
                      enabled: isBool[index] == true ? false : true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        border: isBool[index] == true
                            ? InputBorder.none
                            : const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                              ),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        isBool[index] == true
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    isBool.replaceRange(0, isBool.length,
                                        isBool.map((element) => true));
                                    isBool[index] = false;
                                    print(isBool);
                                  });
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blueAccent,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  editContentMeasurementNotifier
                                      .editContentMeasurement(
                                    getContentMeasuremnetNotifier
                                        .getContentMeasurementClass[index].id!,
                                    _controllers[index].text,
                                  );
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.check,
                                  color: Colors.blueAccent,
                                ),
                              ),
                        IconButton(
                          onPressed: () {
                            _showDeleteMedicineDialog(
                              getContentMeasuremnetNotifier
                                  .getContentMeasurementClass[index].id
                                  .toString(),
                            );
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showDeleteMedicineDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Delete Measurement",
            style: TextStyle(color: Colors.black),
          ),
          content: Text(
            "Are You sure want to delete this measurement?",
            style: TextStyle(color: Colors.grey.shade700),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text(
                "Confirm",
                style: TextStyle(color: Colors.blueAccent),
              ),
              onPressed: () {
                setState(() {
                  deleteContentMeasurementNotifier.deleteContentMeasurement(
                    int.parse(id),
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }
}
