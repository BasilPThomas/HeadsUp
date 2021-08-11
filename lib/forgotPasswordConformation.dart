import 'package:flutter/material.dart';
import 'package:headsup/utilities/constants.dart';

class ForgotPasswordConformation extends StatefulWidget {
  const ForgotPasswordConformation({Key? key}) : super(key: key);

  @override
  _ForgotPasswordConformationState createState() => _ForgotPasswordConformationState();
}

class _ForgotPasswordConformationState extends State<ForgotPasswordConformation> {

  Widget _backToLoginButton(){
    return  InkWell(
      onTap: (){
        Navigator.of(context).pop();
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
          child: Text("Back To Login",
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Reset Password",
              style: TextStyle(
                color: Colors.deepPurple,
                fontFamily: 'OpenSans',
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),),
            SizedBox(height: 20,),
            Text("password Reset Instruction Sent!",
              style: TextStyle(
                color: Colors.deepPurple,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20,),
            _backToLoginButton()
          ],
        ),
      ),
    );
  }
}
