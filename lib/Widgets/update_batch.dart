
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventar/services/database_connection.dart';

class UpdateBatch extends StatefulWidget{
  final String medicineId;
  final Timestamp retrievedExpiryDate;
  final Timestamp retrievedPurchaseDate;
  final int retrievedBatchQuantity;
  final String batchID;

  const UpdateBatch({Key key, this.medicineId, this.retrievedExpiryDate, this.retrievedPurchaseDate, this.retrievedBatchQuantity, this.batchID}) : super(key: key);
  @override
  UpdateBatchState createState() => UpdateBatchState();

}

class UpdateBatchState extends State<UpdateBatch>{
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  DateTime purchaseDate;
  DateTime expiryDate;
  DateTime currentDate = DateTime.now();
  TextEditingController batchQuantityController;
  void initState(){
    super.initState();
    purchaseDate = widget.retrievedPurchaseDate.toDate();
    expiryDate = widget.retrievedExpiryDate.toDate();
    batchQuantityController = TextEditingController(text: widget.retrievedBatchQuantity.toString());
  }

  void clear(){
    batchQuantityController.text = "";
  }

  Future<void> _selectDate({BuildContext context,String selectedCase}) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2019),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        switch(selectedCase){
          case "ExpiryDate":
            return expiryDate = pickedDate;
          case "PurchaseDate":
            return purchaseDate = pickedDate;
        }
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEBCE0FD),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('${widget.batchID}', style: TextStyle(color: Color(0xFFE2699FB))),
      ),

      body:SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Add TextFormFields and ElevatedButton here.
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('Expiry Date: ${expiryDate.day}/${expiryDate.month}/${expiryDate.year}'),
                    IconButton(icon: Icon(Icons.calendar_today_rounded),
                      onPressed: () async {
                        await _selectDate(context: context,selectedCase: "ExpiryDate");
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('Purchase Date: ${purchaseDate.day}/${purchaseDate.month}/${purchaseDate.year}'),
                    IconButton(icon: Icon(Icons.calendar_today_rounded),
                      onPressed: () async {
                        await _selectDate(context: context,selectedCase: "PurchaseDate");
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: batchQuantityController,
                  decoration: InputDecoration(
                    hintText: '20',
                    labelText: 'Batch Quantity',
                  ),
                  keyboardType: TextInputType.number,
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
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 60,
                    width: 300,
                    child: ElevatedButton(
                      child: Icon(Icons.arrow_forward),
                      onPressed: () async {
                        if(_formKey.currentState.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('Processing Data..')));
                          await Database(docId: widget.medicineId).updateBatch(
                            expiryDate: expiryDate,
                            purchaseDate: purchaseDate,
                            batchQuantity: int.parse(batchQuantityController.text),
                            batchId: widget.batchID
                          ).whenComplete((){
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text('Done')));
                            clear();
                          });
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}