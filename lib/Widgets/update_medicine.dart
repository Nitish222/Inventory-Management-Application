
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventar/services/database_connection.dart';

Future<Widget> UpdateMedicine({BuildContext context,String medicineName,String brandName,String medID}){
  TextEditingController medicineNameController = TextEditingController(text: medicineName);
  TextEditingController medicineBrandController = TextEditingController(text: brandName);
  print(medicineName);
  void clear(){
    medicineNameController.text = '';
    medicineBrandController.text = '';
  }
  return showDialog(context: context,
      builder: (BuildContext dialogContext){
        return AlertDialog(
          actions: [
            TextButton(onPressed: () async {
              await Database(docId: medID).updateMedicine(
                  medicineName: medicineNameController.text,brandName: medicineBrandController.text)
                  .whenComplete((){
                    clear();
                    Navigator.pop(dialogContext);
              });
            },
                child: Icon(Icons.forward))
          ],
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18))),
          title: Align(
            alignment: Alignment.topCenter,
            child: Row(
              children: [
                Text('Update Medicine',style: TextStyle(color: Color(0xFFE2699FB))),
                IconButton(icon: Icon(Icons.close_outlined), onPressed: (){
                  Navigator.pop(dialogContext);
                })
              ],
            ),
          ),
          content: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Form(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: medicineNameController,
                      decoration: InputDecoration(
                        labelText: 'Medicine Name',
                      ),
                      onTap: (){
                        medicineNameController.text = '';
                      },
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Cannot leave empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: medicineBrandController,
                      decoration: InputDecoration(
                        labelText: 'Medicine Brand',
                      ),
                        onTap: (){
                          medicineBrandController.text = '';
                        },
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Cannot leave empty';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          contentPadding: EdgeInsets.all(8),
        );
      });
}