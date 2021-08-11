import 'package:flutter/material.dart';
import 'package:headsup/utilities/constants.dart';
import 'appbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage ({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final  _formkey =GlobalKey<FormState>();
  int _value = 1;
  bool _isLoading = false;

  Widget _searchSubject() {
    return Form(
        key: _formkey,
        child: Column(
          children: [
            TextFormField(
              keyboardType:TextInputType.name ,
              validator: (val){
                return val!.isNotEmpty || val.length < 4 ? val="write the full name":val =null;
              },
              style: TextStyle(
                color: Colors.blueAccent,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                // border: InputBorder.Reta,
                contentPadding: EdgeInsets.only(top: 14.0,),
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Colors.blueAccent,
                ),
                hintText: 'Full name*',
                hintStyle: TextStyle(color: Colors.blueAccent),
              ),
            ),
            TextFormField(
              style: TextStyle(
                color: Colors.blueAccent,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                // border: InputBorder.Reta,
                contentPadding: EdgeInsets.only(top: 14.0,),
                prefixIcon: Icon(
                  Icons.open_in_browser,
                  color: Colors.blueAccent,
                ),
                hintText: 'Postcode*',
                hintStyle: TextStyle(color: Colors.blueAccent),
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (val){
                return val!.isNotEmpty || val.length < 4 ? val="write the phone number":val =null;
              },
              style: TextStyle(
                color: Colors.blueAccent,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                // border: InputBorder.Reta,
                contentPadding: EdgeInsets.only(top: 14.0,),
                prefixIcon: Icon(
                  Icons.mobile_friendly,
                  color: Colors.blueAccent,
                ),
                hintText: 'Mobile*',
                hintStyle: TextStyle(color: Colors.blueAccent),
              ),
            ),
            TextFormField(
              validator: (val){
                return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(val!)? null:"Email Id is not valid";
              },
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.blueAccent,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                // border: InputBorder.Reta,
                contentPadding: EdgeInsets.only(top: 14.0,),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.blueAccent,
                ),
                hintText: 'Email address*',
                hintStyle: TextStyle(color: Colors.blueAccent),
              ),
            ),
          ],
        )
    );
  }

  Widget _dropDown(){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 44.0),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecoration,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
                value: _value,
                items: [
                  DropdownMenuItem(
                    child: Text("Select transaction type*",style: TextStyle(color: Colors.blueAccent,),),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text("Second Item"),
                    value: 2,
                  ),
                  DropdownMenuItem(
                      child: Text("Third Item"),
                      value: 3
                  ),
                  DropdownMenuItem(
                      child: Text("Fourth Item"),
                      value: 4
                  )
                ],
                onChanged: (value) {
                  setState(() {
                    // _value = value;
                  });
                }),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15,left: 10),
          child: Icon(
            Icons.business_rounded,
            color: Colors.blueAccent,
            size: 20.0,
          ),
        ),
      ],
    );
  }

  Widget _nextButton(){
    return Container(
      alignment: Alignment.centerRight,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          validateInputs();
        },
        padding: EdgeInsets.symmetric(vertical: 18,horizontal: 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        color: Colors.white,
        child: Text(
          'Next',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/4.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              LogoAndBar(),
              Image.asset('assets/3.png',height: 150,width: 150,fit: BoxFit.cover,),
              // Image(image: AssetImage("assets/3.png")),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 50,
                            child: Text(
                              "Need a Headsup?\n",
                              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.purple.shade800,fontSize: 40),
                            ),
                          ),
                    Container(
                            child: Text(
                              "Whether you’re buying or selling a "
                                  " used car or choosing a tenant for"
                                  "your flat,why take the risk?\n",
                              style:TextStyle(fontWeight: FontWeight.bold,color: Colors.purple.shade800,fontSize: 20),
                            ),
                          ),
                    Container(
                      height: 28,
                            child: Text(
                               "Enter the Search subject’s details below :",
                              style:TextStyle(fontWeight: FontWeight.bold,color: Colors.purple.shade800,fontSize: 12),),
                          ),
                    Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0)),
                        color: Colors.white,
                      ),
                      child:_searchSubject(),
                    ),
                    SizedBox(height: 20,),
                    _dropDown(),
                    SizedBox(height: 20,),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecoration,
                      child: TextField(
                        maxLines: 8,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14.0,bottom: 15),
                          // prefixIcon: Icon(
                          //   Icons.note,
                          //   color: Colors.blueAccent,
                          // ),
                          hintText: 'Enter your text here(optional)',
                          hintStyle: TextStyle(color: Colors.blueAccent),
                        ),
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                    Text("*Requried",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 8),),
                    // _nextButton(),
                    ElevatedButton(
                      child: Text('Elevated Button'),
                      onPressed: () {
                        print('Pressed');
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) return Colors.green;
                            return Colors.greenAccent;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validateInputs() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
    }
  }

}







