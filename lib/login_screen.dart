import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello/reset_password.dart';
import 'package:hello/reusable_widgets.dart';
import 'package:hello/signup_screen.dart';
import 'main.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({Key? key}) : super(key: key);

   @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {

    TextEditingController _passwordTextController = TextEditingController();
    TextEditingController _emailTextController = TextEditingController();
    bool _passwordVisible = false;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
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
          child: Column(
            children: <Widget>[
            
            //psg tech logo
            Align(
              alignment: Alignment.topRight,
              child: Image.asset('assets/images/PSG LOGO in PNG.png',
              width: 80,
              height: 80,
             ),
            ),

            //psg hospital logo
            logowidget("assets/images/psg-hospitals-coimbatore.jpg"),
            
            const SizedBox(
              height: 30,
            ),
            reusableTextField("Enter Username", Icons.person_outline, false, 
            _emailTextController),
            const SizedBox(
              height: 20,
            ),
            PasswordTextField(
              labelText: "Enter Password", 
              icon: Icons.lock_outline,
              controller: _passwordTextController),
            const SizedBox(
              height: 5,
            ),
            forgotPassword(context),
            PressButton(context, "LOG IN", () {
              // After successful login
              prefs?.setBool('isLoggedIn', true);
              FirebaseAuth.instance.signInWithEmailAndPassword(
                email: _emailTextController.text,
                 password: _passwordTextController.text
              ).then((value) { 
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => HomeScreen()));
            }).onError((error, stackTrace){
              print("error ${error.toString()}");
            });
            }),
            SignUpOption(context)
            ],
          ),
         ),
        ),
       ),
      );
    }
}

Image logowidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 250,
    height: 250,
  );
}

Row SignUpOption(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("Don't have account? ",
      style: TextStyle(color: Colors.white, fontSize: 20,)),
    GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreen()));
      },
    child: const Text(
      "Sign Up",
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20,),
     ),
    )
   ],
  );
}

//forgot password
Widget forgotPassword(BuildContext context){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 35,
    alignment: Alignment.bottomRight,
    child: TextButton(
      child: const Text(
        "Forgot Password",
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.right,
      ),
     onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResetPassword())
     ),
    ),
  );
}