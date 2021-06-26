
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventar/Widgets/update_batch.dart';
import 'package:inventar/services/database_connection.dart';

class BatchCard extends StatelessWidget{
  int Quantity;
  Timestamp purchaseDate;
  Timestamp expiryDate;
  String batchId;
  String docId;
  String medId;

  BatchCard({@required this.Quantity,@required this.purchaseDate,
              @required this.expiryDate, @required this.docId, @required this.batchId,@required this.medId});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Card(
        semanticContainer: true,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 0.2)),
        child: ListTile(
            title:Padding(
              padding: EdgeInsets.zero,
              child: Row(
                  children: <Widget>[
                    SizedBox(
                        width: 40,
                        child: Text("$Quantity", style: TextStyle(color: Color(0xFFE2699FB), fontSize: 12))),
                    Container(
                      width: 70,
                      child: Text("Batch: $batchId", style: TextStyle(color: Color(0xFFE2699FB), fontSize: 12),),
                    ),
                    Container(
                        padding:EdgeInsets.fromLTRB(0, 5, 0, 0),height: 60,child: VerticalDivider(thickness: 1.5)),
                    Container(
                        width: 45,
                        child: Text("DOP: ${purchaseDate.toDate().day}/${purchaseDate.toDate().month}/${purchaseDate.toDate().month} ", style: TextStyle(color: Color(0xFFE2699FB), fontSize: 10))
                    ),
                    Container(
                        padding:EdgeInsets.fromLTRB(0, 5, 0, 0),height: 60,child: VerticalDivider(thickness: 1.5)),
                    Container(
                      width: 50,
                      child: Text('EXP: ${expiryDate.toDate().month}/${expiryDate.toDate().year}',style: TextStyle(color: Color(0xFFE2699FB), fontSize: 10)),
                    ),
                    Container(
                        padding:EdgeInsets.fromLTRB(0, 5, 0, 0),height: 60,child: VerticalDivider(thickness: 1.5,width: 2,)),
                    SizedBox(
                      width: 100,
                      child: Row(
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.edit, color: Color(0xFFE2699FB),size: 15,), onPressed: () async {
                            //TODO: implement batch edit
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateBatch(
                              retrievedPurchaseDate: purchaseDate,
                              retrievedExpiryDate: expiryDate,
                              retrievedBatchQuantity: Quantity,
                              medicineId: medId,
                              batchID: batchId,
                            )));
                          }),
                          Container(
                              padding:EdgeInsets.fromLTRB(0, 5, 0, 0),height: 60,child: VerticalDivider(thickness: 1.5,width: 3,)),
                          IconButton(icon: Icon(Icons.cancel_outlined, color: Color(0xFFE2699FB),size: 15,), onPressed: () async {
                            //TODO: implment batch delete
                            await Database().deleteBatch(batchId);
                          })
                        ],
                      ),
                    ),
                  ],
                ),
            ),
          ),
        ),
    );
  }
}
