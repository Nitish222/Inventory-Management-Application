import 'package:flutter/cupertino.dart';
import 'package:inventar/DataModels/batch_datamodel.dart';
import 'package:inventar/Screens/Batches.dart';
import 'package:inventar/services/database_connection.dart';
import 'package:provider/provider.dart';

class BatchLayout extends StatelessWidget{
  final String medicineId;
  final String medicineName;
  BatchLayout({this.medicineId,this.medicineName});
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<BatchDataModel>>.value(
        value: Database(docId: medicineId).batches,
        initialData: [],
        catchError: (_, __) => null,
        child: batchPage(medicineName: medicineName,medicineId: medicineId,),
    );
  }

}