
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello/main.dart';
import 'package:hello/reusable_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

   @override
  _SignUpScreenState createState() => _SignUpScreenState();

}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _IDTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
    Widget build(BuildContext context) {
      return Theme(
      data: Theme.of(context).copyWith(
        appBarTheme: AppBarTheme(
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
        title: Text(
          "SIGN UP",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white,),
          textAlign: TextAlign.center,
        ),
      centerTitle: true,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
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
            reusableTextField("Enter Username", Icons.person_outline, false, 
            _userNameTextController),
            const SizedBox(
              height: 20,
            ),
            reusableTextField("Enter Hospital ID", Icons.person_outline, false, 
            _IDTextController),
            const SizedBox(
              height: 20,
            ),
            reusableTextField("Enter Email ID", Icons.person_outline, false, 
            _emailTextController),
            const SizedBox(
              height: 20,
            ),
            reusableTextField("Enter Password", Icons.lock_outline, true, 
            _passwordTextController),
            const SizedBox(
              height: 20,
            ),
            PressButton(context, "SIGN UP",() {

            FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text,
            ).then((value) {
              print("created new account");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()));
            }).onError((error, stackTrace) {
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
