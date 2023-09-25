import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientData1 extends StatefulWidget {
  const PatientData1({Key? key}) : super(key: key);

  @override
  _PatientData1State createState() => _PatientData1State();
}

class _PatientData1State extends State<PatientData1> {
  final DataTableSource _data = MyData();
  DateTime? todayDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: todayDate!, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != todayDate) {
      setState(() {
        todayDate = picked;
      });
    }
  }

  @override
  void initState() {
    Networkcheck().check().then((value) {
      print(value);
      if(value==false){
        _showConnectionState();
      }});
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
                      if(value==true){
                        Navigator.pop(context);
                      }});
                  },
                  child: Text('Retry',))
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
    return SafeArea(
      child: Scaffold(
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(context) {
    return Stack(
      children: [
        Image(
          image: const AssetImage('assets/verysmall.png'),
          fit: BoxFit.fill,
          height: MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.width,
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    backButton(context),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    searchAndFilter(context),
                    const SizedBox(
                      height: 20,
                    ),
                    patientListData(context),
                    // Divider(
                    //   thickness: 5,
                    //   color: Color(0xff68A0F8),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget backButton(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
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
      ),
    );
  }

  Widget searchAndFilter(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 0),
                      spreadRadius: 4,
                      blurRadius: 10),
                ],
              ),
              child: TextFormField(
                // validator: validateConfirmPassword,
                // controller: _confirmpassword,
                // obscureText: _isObscure1,
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
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    hintText: 'Search for your products',
                    hintStyle: const TextStyle(
                      fontSize: 12,
                    )),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton.icon(
            onPressed: () {
              _selectDate(context);
            },
            icon: const Icon(
              Icons.filter_list,
              size: 14,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color(0xff4889FD),
              ),
            ),
            label: const Text(
              "Filter",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget patientListData(context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _createDataTable(),
      ],
    );
  }

  Widget _createDataTable() {
    return Theme(
      data: ThemeData(
        cardColor: const Color(0xff68A0F8),
        textTheme: const TextTheme(
          caption: TextStyle(color: Colors.white),
        ),
      ),
      child: PaginatedDataTable(
        arrowHeadColor: Colors.white,
        headingRowHeight: 35,
        dataRowHeight: 35,
        source: _data,
        columns: const [
          DataColumn(
              label: Text(
                'Ticker',
                style: TextStyle(color: Colors.white),
              )),
          DataColumn(
              label: Text(
                'Name',
                style: TextStyle(color: Colors.white),
              )),
          DataColumn(
              label: Text(
                'Phone No',
                style: TextStyle(color: Colors.white),
              )),
          DataColumn(
              label: Text(
                'Age',
                style: TextStyle(color: Colors.white),
              )),
          DataColumn(
              label: Text(
                'Action',
                style: TextStyle(color: Colors.white),
              )),
        ],
        columnSpacing: 10,
        horizontalMargin: 10,
        rowsPerPage: 13,
        showCheckboxColumn: false,
      ),
    );
  }

}

class MyData extends DataTableSource {
  // Generate some made-up data
  final List<Map<String, dynamic>> _data = [
    {
      'Ticker': "1",
      'Name': "Abdul Rahman",
      'Phone No': '9998887776',
      'Age': '22'
    },
    {
      'Ticker': "1",
      'Name': "Mohammed Irfan",
      'Phone No': '9998887776',
      'Age': '23'
    },
    {
      'Ticker': "1",
      'Name': "Shadab Ahmed",
      'Phone No': '9998887776',
      'Age': '24'
    },
    {
      'Ticker': "1",
      'Name': "Saad Ahmed",
      'Phone No': '9998887776',
      'Age': '25'
    },
    {'Ticker': "1", 'Name': " Irbaz", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Rifque", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Javeed", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Praveen", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Javeed", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Javeed", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Javeed", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Javeed", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Javeed", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Javeed", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Javeed", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Javeed", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Javeed", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Javeed", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Javeed", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Javeed", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Javeed", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Javeed", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Javeed", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Javeed", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Javeed", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Javeed", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Javeed", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Javeed", 'Phone No': '9998887776', 'Age': '26'},
    {'Ticker': "1", 'Name': " Javeed", 'Phone No': '9998887776', 'Age': '26'},
  ];

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(color: MaterialStateProperty.all(const Color(0xffF6F6F6)), cells: [
      DataCell(Text('${index + 1}')),
      DataCell(Text(_data[index]["Name"])),
      DataCell(Text(_data[index]["Phone No"].toString())),
      DataCell(Text(_data[index]["Age"].toString())),
      DataCell(IconButton(
        icon: const Icon(
          CupertinoIcons.eye,
          size: 13,
        ),
        onPressed: () {},
      )),
    ]);
  }
}
