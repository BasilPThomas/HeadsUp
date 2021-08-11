import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:headsup/user/signup_screen.dart';
import 'package:headsup/utilities/constants.dart';
import 'package:headsup/user/nav_bar.dart';
import 'forgotPassword.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final  _keySignin =GlobalKey<FormState>();
  bool _isLoading = false;

  Widget _signinForm(){
    return Form(
      key: _keySignin,
      child: Column(
        children: [
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
      ),
    );
  }
  Widget _loginButton(){
    return  InkWell(
      onTap: (){
        if (_keySignin.currentState!.validate()) {
          _keySignin.currentState!.save();
          _signin();
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
  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignupScreen()),);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
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
  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForgotPassword()),
          );
        },
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontFamily: 'OpenSans',
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 80.0),
              _signinForm(),
              _buildForgotPasswordBtn(),
              SizedBox(height: 20,),
              _loginButton(),
              SizedBox(height: 20,),
              _buildSignupBtn()
            ],
          ),
        ),
      ),
    );
  }

  void _signin() {
    String email = emailController.text.trim();
    String password = passwordController.text;

    if(email.isNotEmpty && password.isNotEmpty){
      _auth .signInWithEmailAndPassword(
          email: email, password: password
      ).then((user) {
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
              ),
              title: Text("Done"),
              content: Text(" login Succes"),
              actions: [
                FlatButton(
                  child: Text("ok"),
                  onPressed: () {
                    emailController.text ="";
                    passwordController.text='';
                    Navigator.of(ctx).pop();
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
              title: Text("error"),
              content: Text("${e.message}"),
              actions: [
                FlatButton(
                  child: Text("ok"),
                  onPressed: () {
                    emailController.text ="";
                    passwordController.text='';
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
