import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventar/Screens/Batches.dart';
import 'package:inventar/Screens/addItems.dart';
import 'package:inventar/routes/batchpage_arguments.dart';
import 'package:inventar/routes/route_name.dart';
import 'package:inventar/services/firebase_root.dart';

Route<dynamic> generateRoute(RouteSettings settings){

  final args = settings.arguments;

  switch(settings.name){
    case rootRoute:
        return MaterialPageRoute(builder: (context)=>App());
    case addItemsRoute:
        return MaterialPageRoute(builder: (context)=>addItems());
    case batchPageRoute:
        BatchPageArguments argument = args;
        return MaterialPageRoute(builder: (context)=>batchPage(
          medicineId: argument.medicineId,
          medicineName: argument.medicineName,
        ));
    default:
       return MaterialPageRoute(builder: (context)=>App());
  }
}