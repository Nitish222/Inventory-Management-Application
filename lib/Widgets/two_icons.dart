
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventar/Screens/local_notification.dart';
import 'package:inventar/routes/route_name.dart';

Widget twoIcon(BuildContext context){
  return Row(
    children: [
      Padding(padding: EdgeInsets.symmetric(horizontal: 10),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xFFE2699FB),
            child: IconButton(
              icon: Icon(Icons.sd_card_alert_outlined,color: Colors.white),
              onPressed: (){
              },
            ),
          ),
      ),
      Padding(padding: EdgeInsets.symmetric(horizontal: 10),
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Color(0xFFE2699FB),
          child: IconButton(
            icon: Icon(Icons.add,color: Colors.white,),
            onPressed: (){
              Navigator.pushNamed(context, addItemsRoute);
            },
          ),
        ),
      ),
    ],
  );
}