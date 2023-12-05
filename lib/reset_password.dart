import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello/reusable_widgets.dart';


class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

   @override
  _ResetPasswordState createState() => _ResetPasswordState();

}

class _ResetPasswordState extends State<ResetPassword> {

  TextEditingController _emailTextController = TextEditingController();

  @override
    Widget build(BuildContext context) {
      return Theme(
      data: Theme.of(context).copyWith(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white, // Set your desired color here
          ),
        ),
      ),

      child : Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded, // Change the icon here
            ),
        onPressed: () {
              Navigator.pop(context);
            },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Reset Password",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white,),
          textAlign: TextAlign.center,
        ),
      centerTitle: true,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color.fromRGBO(97, 4, 21, 1),
             Color.fromARGB(255, 197, 14, 14),
             Color.fromARGB(255, 197, 14, 14),
             Color.fromRGBO(97, 4, 21, 1)], 
           ),
          ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.1,20,0),
          child: Column(children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            reusableTextField("Enter Email ID", Icons.person_outline, false, 
            _emailTextController),
            const SizedBox(
              height: 20,
            ),
           PressButton(context, "Reset Password", (){
            FirebaseAuth.instance.sendPasswordResetEmail(
              email: _emailTextController.text
            ).then((value) {}).onError((error, stackTrace) {
              print("error ${error.toString()}");
            });
           }),
         ],
        ),
       ),
      )
    )
    ),
  );
  }
}