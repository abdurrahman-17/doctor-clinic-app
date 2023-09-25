import 'package:azlistview/azlistview.dart';
import 'package:doctor_clinic_token_app/core/request_response/addBrandName/addBrandNameNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/brandNameList/brandNameListNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/brandNameList/brandNameListResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/editBrandName/editBrandNameNotifier.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ManageBrand extends StatefulWidget {
  const ManageBrand({Key? key}) : super(key: key);

  @override
  State<ManageBrand> createState() => _ManageBrandState();
}

class _AZItem extends ISuspensionBean {
  final String title;
  final String tag;

  _AZItem({required this.title, required this.tag});

  @override
  String getSuspensionTag() => tag;
}

class _ManageBrandState extends State<ManageBrand> {
  BrandNameListNotifier brandNameListNotifier = BrandNameListNotifier();
  EditBrandNameNotifier editBrandNameNotifier = EditBrandNameNotifier();
  AddBrandNameNotifier addBrandNameNotifier = AddBrandNameNotifier();
  List<_AZItem> items = [];
  List<TextEditingController> _controllers = [];
  List<bool> isBool = [];
  int doctorId = 0;
  final addController = TextEditingController();

  bool changeIcon = false;

  @override
  void initState() {
    super.initState();
    MySharedPreferences.instance.getDoctorId('doctorID').then((value) {
      setState(() {
        doctorId = value;
        print(doctorId);
      });
    });
    Future.delayed(Duration.zero, () async {
      await brandNameListNotifier.getBrandNameList();
      brandNameListNotifier.notifyListeners();
      initList(brandNameListNotifier.getBrandNameListClass);
      print(_controllers);
      print(isBool);
    });
  }

  void initList(List<BrandNameData> items) {
    this.items = items
        .map((item) => _AZItem(
              title: item.medicineBrandName!,
              tag: item.medicineBrandName![0].toUpperCase(),
            ))
        .toList();

    print(this.items);
    for (int i = 0; i < this.items.length; i++) {
      _controllers.add(
        TextEditingController(
          text: this.items[i].title,
        ),
      );
      isBool.add(true);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BrandNameListNotifier>(
      builder: (context, provider, _) {
        brandNameListNotifier = provider;
        return ModalProgressHUD(
          inAsyncCall: provider.isLoading,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
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
              MediaQuery.of(context).orientation == Orientation.landscape
                  ? medicineList(context)
                  : medicineListFilter(context),
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
            'Brand List',
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
          controller: addController,
          onChanged: (text) {
            text = text.toLowerCase();
            // setState(() {
            //   // getMedicineListNotifier.getMedicineSearchListClass =
            //   //     getMedicineListNotifier.getMedicineListClass.where((list) {
            //   //       var drugList = list.drugName!.toLowerCase();
            //   //       return drugList.contains(text);
            //   //     }).toList();
            // });
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
              child: GestureDetector(
                onTap: () {
                  addBrandNameNotifier.addBrandName(
                    doctorId,
                    addController.text,
                  );
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            hintText: 'Add Brand',
            hintStyle: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget medicineListFilter(context) {
    return Expanded(
      child: AzListView(
        // indexBarAlignment: Alignment.centerLeft,
        indexBarMargin: const EdgeInsets.all(2),
        indexBarItemHeight: 18,
        indexBarOptions: const IndexBarOptions(
          textStyle: const TextStyle(
            fontSize: 13,
          ),
        ),
        padding: const EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(),
        data: items,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 10.0),
            child: ListTile(
              minLeadingWidth: 10,
              leading: const FaIcon(
                FontAwesomeIcons.award,
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
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                ),
              ),
              trailing: isBool[index] == true
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isBool.replaceRange(
                              0, isBool.length, isBool.map((element) => true));
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
                        editBrandNameNotifier.editBrandName(
                          brandNameListNotifier
                              .getBrandNameListClass[index].id!,
                          _controllers[index].text,
                        );
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.check,
                        color: Colors.blueAccent,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget medicineList(context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: brandNameListNotifier.getBrandNameListClass.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 10.0),
            child: ListTile(
              leading: const FaIcon(
                FontAwesomeIcons.award,
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
                              const BorderSide(color: Colors.blueAccent),
                        ),
                ),
              ),
              trailing: isBool[index] == true
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isBool.replaceRange(
                              0, isBool.length, isBool.map((element) => true));
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
                        editBrandNameNotifier.editBrandName(
                          brandNameListNotifier
                              .getBrandNameListClass[index].id!,
                          _controllers[index].text,
                        );
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.check,
                        color: Colors.blueAccent,
                      ),
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
            "Delete Medicine",
            style: TextStyle(color: Colors.black),
          ),
          content: Text(
            "Are You sure want to delete this medicine?",
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
                  // deleteMedicineNotifier.deleteMedicine(
                  //   doctorId,
                  //   int.parse(id),
                  // );
                });
              },
            ),
          ],
        );
      },
    );
  }
}

class Item {
  final String id;
  final String name;

  Item(this.id, this.name);
}
