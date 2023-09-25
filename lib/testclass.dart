// import 'package:doctor_clinic_token_app/core/request_response/login/loginNotifier.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:provider/provider.dart';
//
//
//
// class Testclass extends StatefulWidget {
//   const Testclass({Key? key}) : super(key: key);
//
//   @override
//   TestclassState createState() => TestclassState();
// }
//
// class TestclassState extends State<Testclass> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   late LoginNotifier? loginNotifier;
//   @override
//   Widget build(BuildContext context) {
//     if (!kReleaseMode) {}
//     return Consumer<LoginNotifier>(
//         builder: (context, provider, _) {
//           return ModalProgressHUD(
//             inAsyncCall: provider.isLoading,
//             child: Scaffold(
//               appBar: AppBar(
//                 centerTitle: true,
//                 title: Text("just"),),
//               body: buildBody(context),
//             ),
//           );});
//   }
//   Widget buildBody(BuildContext context){
//     loginNotifier =
//     Provider.of<LoginNotifier?>(context, listen: false);
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text('Login',style: TextStyle(fontWeight: FontWeight.bold,fontSize:18),),
//         SizedBox(height: 20,),
//         TextField(
//           controller: emailController,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 20),
//           child: TextField(
//             controller: passwordController,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//
//             ),
//           ),
//         ),
//         button(context,loginNotifier!)
//
//       ],
//     );
//   }
//   Widget button(BuildContext context, LoginNotifier notifier){
//     return Padding(
//       padding: const EdgeInsets.all(40.0),
//       child: ElevatedButton(onPressed: (){
//         notifier.doctorLogin(emailController.text.trim(),
//             passwordController.text.trim());
//       }, child: Text('Login')),
//     );
//
//   }
// }
//
