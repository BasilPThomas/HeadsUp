import 'package:flutter/material.dart';

class LogoAndBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          SizedBox(width:60),
          Image.asset("assets/2.png",height: 80,width: 80,),
          Align(
            alignment: Alignment.centerLeft,
              child: Icon(Icons.menu,size: 35,)),
        ],),
    );
  }
}
