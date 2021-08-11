import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:headsup/user/nav_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:headsup/utilities/constants.dart';

import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final  _keySignup =GlobalKey<FormState>();
  bool _isLoading = false;

  Widget _signupForm() {
    return Form(
        key:_keySignup,
        child:Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.name,
              controller: nameController,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                // border: InputBorder.none,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.perm_identity_sharp ,
                  color: Colors.deepPurple,
                ),
                hintText: 'Enter your Name',
                // hintStyle: kHintTextStyle,
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              validator: (val){
                return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(val!)?
                null:"Email Id is not valid";
              },
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                // border: InputBorder.none,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.deepPurple,
                ),
                hintText: 'Enter your Email',
                // hintStyle: kHintTextStyle,
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              autocorrect: false,
              controller: passwordController,
              validator: (val){
                return val!.length>4?null:"Password should be greater than 6 characters";
              },
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                // border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.deepPurple,
                ),
                hintText: 'Enter your password',
                // hintStyle: kHintTextStyle,
              ),
            ),
          ],
        )
    );
  }
  Widget _signupButtom() {
    return InkWell(
      onTap: (){
        if (_keySignup.currentState!.validate()) {
          _keySignup.currentState!.save();
          _signup();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.purple,Colors.deepPurple]
            ),
            borderRadius: BorderRadius.circular(8)),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
        child: Center(
          child: Text("signUp",
            style: kLabelStyle,
          ),
        ),
      ),
    );
  }
  Widget _buildLoginBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Do you have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        FlatButton.icon(
          onPressed: () {
            // _signupUsingGoogle();
          },
          icon: Icon(
            FontAwesomeIcons.googleDrive, color: Colors.red, size: 30,),
          label: Text("Sign-in using Gmail"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/5.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 120.0,
          ),
          child: Column(
            children: [
              Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontFamily: 'OpenSans',
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 80,),
              _signupForm(),
              SizedBox(height: 40,),
              _signupButtom(),
              SizedBox(height: 40,),
              _buildLoginBtn()
            ],
          ),
        ),
      ),
    );
  }



  void _signup(){
    final String email = emailController.text.trim();
    final String password = passwordController.text;
    final String name = nameController.text;

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
        'name': name,
        'email': email,
        'created_at': DateTime.now().toUtc().millisecondsSinceEpoch,
        'email-opt-in': true,
      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    if(email.isNotEmpty && password.isNotEmpty){
      _auth.createUserWithEmailAndPassword(
          email: email, password: password
      ).then((user) {
        addUser();
       showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
              ),
              title: Text("Done"),
              content: Text("Sign up Success"),
              actions: [
                FlatButton(
                  child: Text("ok"),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    emailController.text ="";
                    passwordController.text='';
                    nameController.text="";
                  },
                ),
              ],
            );
          },);
      }).catchError((e){
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
              ),
              title: Text("Error"),
              content: Text("${e.message}"),
              actions: [
                FlatButton(
                  child: Text("ok"),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            );
          },);
      });
    }
  }
}

