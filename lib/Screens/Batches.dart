import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventar/DataModels/batch_datamodel.dart';
import 'package:inventar/Screens/add_batch.dart';
import 'package:inventar/Widgets/batch_card.dart';
import 'package:provider/provider.dart';

class batchPage extends StatefulWidget {
  final String medicineName;
  final String medicineId;
  const batchPage({this.medicineId,this.medicineName});
  @override
  batchPageState createState() => batchPageState();
}

class batchPageState extends State<batchPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final batches = Provider.of<List<BatchDataModel>>(context) ?? [];
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          backgroundColor: Color(0xFFEBCE0FD),
          leading: IconButton(icon: const Icon(Icons.arrow_back, color: Color(0xFFE2699FB)),
              onPressed: (){
                  Navigator.pop(context);
              }),
          title: Align(
            alignment: Alignment.center,
            child: Text("${widget.medicineName}", style: TextStyle(color: Color(0xFFE2699FB))),
          ),
          actions: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.sort),
                onPressed: (){
                  _scaffoldKey.currentState.openEndDrawer();
                },
              ),
            )
          ],
        ),
      ),
      endDrawer:  Container(
        height: MediaQuery.of(context).size.height*0.5,
        width: MediaQuery.of(context).size.width*0.5,
        child: ClipRRect(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
          child: Drawer(
            child: Container(
              color: Color(0xFFEBCE0FD),
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.only(left: 10, right: 10),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                  ),
                  ListTile(
                      leading:Icon(Icons.sort_by_alpha),
                      title:Text("Sort by ExpiryDate"),
                      onTap:(){
                        setState(() {
                            batches.sort((a,b){
                                  return a.expiryDate.compareTo(b.expiryDate);
                              });
                          });
                        }),
                  ListTile(
                      leading:Icon(Icons.format_list_numbered),
                      title:Text("Sort by PurchaseDate"),
                      onTap:(){
                        setState(() {
                          batches.sort((a,b){
                            return a.purchaseDate.compareTo(b.purchaseDate);
                          });
                        });
                      }
                  ),
                  ListTile(
                      leading:Icon(Icons.confirmation_number),
                      title:Text("Sort by BatchId"),
                      onTap:(){
                        setState(() {
                          batches.sort((a,b){
                            return a.batchId.compareTo(b.batchId);
                          });
                        });
                      }
                  ),
                   ListTile(
                      leading:Icon(Icons.confirmation_number),
                      title:Text("Sort by Quantity"),
                      onTap:(){
                        setState(() {
                          batches.sort((b,a){
                            return a.Quantity.compareTo(b.Quantity);
                          });
                        });
                      }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      //MediaQuery.of(context).size.width/height * [percentage of width you want] - [paddings you applied]
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            itemCount: batches.length,
            itemBuilder: (context,index){
              return BatchCard(Quantity: batches[index].Quantity, purchaseDate: batches[index].purchaseDate,
                              expiryDate: batches[index].expiryDate, docId: batches[index].docId,
                              batchId: batches[index].batchId,medId: widget.medicineId,);
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 60.0),
        color: Color(0xFFEBCE0FD),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddBatch(
            medicineId: widget.medicineId,
          )));
        },
        tooltip: 'Add Batches',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}