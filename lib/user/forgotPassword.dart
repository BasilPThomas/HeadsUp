import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:headsup/utilities/constants.dart';
import '../forgotPasswordConformation.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final  _keyfpf =GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Widget _forgotPasswordForm(){
    return Form(
      key: _keyfpf,
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
        ],
      ),
    );
  }
  Widget _submitButton(){
    return  InkWell(
      onTap: (){
        if (_keyfpf.currentState!.validate()) {
          _keyfpf.currentState!.save();
          checkEmail();
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
          child: Text("Submit",
            style: kLabelStyle,
          ),
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
                ' ForgotPassword',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontFamily: 'OpenSans',
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50,),
              _forgotPasswordForm(),
              SizedBox(height: 25,),
              _submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  void checkEmail() {
    final String email = emailController.text.trim();
    FirebaseAuth.instance.sendPasswordResetEmail(email: email)
        .then((firebaseUser) {
      setState(() {
        _isLoading = false;
        // _auth.sendPasswordResetEmail(email: emailController.text.trim());
        Navigator.of(context).pop();
      });
    }).catchError((e) {
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
                  emailController.text ="";
                },
              ),
            ],
          );
        },);
    });
  }
}