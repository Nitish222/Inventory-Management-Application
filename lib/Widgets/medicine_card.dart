import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventar/Widgets/update_medicine.dart';
import 'package:inventar/services/database_connection.dart';

class MedicineCard extends StatelessWidget{
  int Quantity;
  String medicineName;
  String brandName;
  String medicineId;
  MedicineCard({@required this.medicineName,@required this.brandName, @required this.Quantity,@required this.medicineId});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 1)),
        child: Container(
          height: 75,
          child: ListTile(
            leading: Column(
              children: [
                Text("Qty",style: TextStyle(color: Color(0xFFE2699FB), fontSize: 17)),
                Text("$Quantity",style: TextStyle(color: Color(0xFFE2699FB), fontSize: 13)),
              ],
            ),
            title: Align(
                    alignment: Alignment.center,
                    child:
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 30,top: 17,bottom: 17),
                          child: VerticalDivider(thickness: 1.5, width: 4,),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              Text("$medicineName", style: TextStyle(color: Color(0xFFE2699FB), fontSize: 20, fontWeight: FontWeight.bold)),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("$brandName", style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Color((0xFFE2699FB))),)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50,top: 17,bottom: 17),
                          child: VerticalDivider(thickness: 1.5, width: 4,),
                        ),
                      ],
                    )),
            trailing: Container(
              padding: EdgeInsets.fromLTRB(0,0, 5, 10),
              width: 122,
              height: 80,
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.edit, color: Color(0xFFE2699FB),size: 30), onPressed: () async {
                      await UpdateMedicine(context: context,brandName: brandName,medicineName: medicineName,medID: medicineId);
                    }),
                    VerticalDivider(thickness: 1.5, width: 4,),
                    IconButton(icon: Icon(Icons.cancel_outlined, color: Color(0xFFE2699FB),size: 35,),
                        onPressed: () {
                          Database(docId: medicineId).deleteMedicine();
                      })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}