import 'package:flutter/material.dart';
import 'package:inventar/DataModels/medicine_batch.dart';
import 'package:inventar/Layout/batches_layout.dart';
import 'package:inventar/Screens/Batches.dart';
import 'package:inventar/Widgets/medicine_card.dart';
import 'package:inventar/Widgets/two_icons.dart';
import 'package:inventar/routes/batchpage_arguments.dart';
import 'package:inventar/routes/route_name.dart';
import 'package:inventar/services/database_connection.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class medPage extends StatefulWidget {
  @override
  medPageState createState() => medPageState();
}
class medPageState extends State<medPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double appbarheight;
  bool showSearchBar;
  bool showTwoIcons;
  @override
  void initState() {
    appbarheight = 200;
    showSearchBar = false;
    showTwoIcons = false;
    super.initState();
  }
  void updateheight() {
    setState(() {
      appbarheight = 50;
    });
  }

  @override
  Widget build(BuildContext context) {
    final medicines = Provider.of<List<MedicineDataModel>>(context) ?? [];
    print(showSearchBar);
    return MaterialApp(
        home: Scaffold(
          key: _scaffoldKey,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(65.0),
          child: showSearchBar?AppBar(
            backgroundColor: Color(0xFFEBCE0FD),
            toolbarHeight: 100,
            leading: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.sort, color: Color(0xFFE2699FB),),
                onPressed: (){
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
            ),
            title: Align(
              alignment: Alignment.topCenter,
              child: Card(
                elevation: 0,
                color: Color(0xFFEBCE0FD),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text('Medicines', style: TextStyle(color: Color(0xFFE2699FB))),
                    ),
                    TextField(
                      decoration: InputDecoration(
                      suffixIcon: Icon(Icons.done), hintText: 'Search Medicines...',
                      ),
                      onChanged: (val) {
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      icon: const Icon(Icons.search, color: Color(0xFFE2699FB)),
                      onPressed: () => setState(() {
                        showSearchBar = false;
                      }))
              ),
            ],
          ):AppBar(
            backgroundColor: Color(0xFFEBCE0FD),
            leading: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.sort, color: Color(0xFFE2699FB),),
                onPressed: (){
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
            ),
            title: Align(
              alignment: Alignment.topCenter,
              child: Text('Medicines', style: TextStyle(color: Color(0xFFE2699FB))),
            ),
              centerTitle: true,
            actions: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    icon: const Icon(Icons.search, color: Color(0xFFE2699FB)),
                    onPressed: () => setState(() {
                      showSearchBar = true;
                    }))
                    ),
                  ],
              // bottom: Bottom
                ),
          ),
          drawer:
          Container(
            height: MediaQuery.of(context).size.height*0.5,
            width: MediaQuery.of(context).size.width*0.5,
            child: ClipRRect(
              borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
              child:Drawer(
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
                          title:Text("Sort by Medicine Name"),
                          onTap:(){
                            setState(() {
                              medicines.sort((a,b){
                                return a.medicineName.toLowerCase().compareTo(b.medicineName.toLowerCase());
                              });
                            });
                          }
                      ),
                      ListTile(
                          leading:Icon(Icons.format_list_numbered),
                          title:Text("Sort by Quantity"),
                          onTap:(){
                            setState(() {
                              medicines.sort((b,a){
                                return a.quantity.compareTo(b.quantity);
                              });
                            });
                          }
                      ),
                      ListTile(
                          leading:Icon(Icons.confirmation_number),
                          title:Text("Sort by Brand Name"),
                          onTap:(){
                            setState(() {
                              medicines.sort((a,b){
                                return a.Brand.toLowerCase().compareTo(b.Brand.toLowerCase());
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
          body:
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
              child: Column(
            // padding: EdgeInsets.all(10),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: showTwoIcons?Padding(
                  padding: const EdgeInsets.only(bottom:15.0),
                  child: SizedBox(
                    height: 50,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                           Container(
                             decoration: BoxDecoration(
                               boxShadow: [BoxShadow(
                                 color: Colors.blueGrey,
                                 blurRadius: 10.0
                               )],
                               borderRadius: BorderRadius.circular(20)
                             ),
                             child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xFFE2699FB),
                                  child: IconButton(
                                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                                      onPressed: () async {
                                        // TODO: below is for testing
                                        // await Database().addMedicine(medicineName: 'B',brandName: 'testBrand',Quantity: '1');
                                        setState(() {
                                          showTwoIcons = false;
                                        });
                                        })
                              ),
                           ),
                          twoIcon(context)
                        ],
                      ),
                    ),
                  ),
                ):SizedBox(
                  height: 50,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFFE2699FB),
                        child: IconButton(
                            icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                            onPressed: () async {
                              // TODO: below is for testing
                              // await Database().addMedicine(medicineName: 'B',brandName: 'testBrand',Quantity: '1');
                              setState(() {
                                showTwoIcons = true;
                              });
                            })
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: medicines.length,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context,index){
                    return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> BatchLayout(
                            medicineId: medicines[index].medicineId,
                            medicineName: medicines[index].medicineName,
                          )));
                        },
                        child: MedicineCard(
                          medicineName: medicines[index].medicineName,
                          brandName: medicines[index].Brand,
                          Quantity: medicines[index].quantity,
                          medicineId: medicines[index].medicineId,
                        ));
                  },
                )
              )

            ]
          ),
        ),
        ),
    );
  }
}