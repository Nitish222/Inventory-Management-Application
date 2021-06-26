import 'package:flutter/material.dart';
class expiryPage extends StatefulWidget {
  @override
  expiryPageState createState() => expiryPageState();
}

class expiryPageState extends State<expiryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          backgroundColor: Color(0xFFEBCE0FD),
          leading: IconButton(icon: const Icon(Icons.arrow_back, color: Color(0xFFE2699FB)),
              onPressed: () => setState(() {})),
          title: Align(
            alignment: Alignment.center,
            child: Text("Expiry Alert", style: TextStyle(color: Color(0xFFE2699FB))),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Card(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 0.2)),
              child: Container(
                height: 75,
                child: ListTile(
                  leading: Text("Qty", style: TextStyle(color: Color(0xFFE2699FB), fontSize: 12)),
                  title: Container(
                    width: 127,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 40,
                          child: Text("Batch", style: TextStyle(color: Color(0xFFE2699FB), fontSize: 12),),
                        ),
                        Container(
                            padding:EdgeInsets.fromLTRB(0, 5, 0, 0),height: 60,child: VerticalDivider(thickness: 1.5)),
                        Container(
                            width: 54,
                            child: Text("DOP: 02/21 EXP: 12/23", style: TextStyle(color: Color(0xFFE2699FB), fontSize: 10))
                        ),
                        Container(
                            padding:EdgeInsets.fromLTRB(0, 5, 0, 0),height: 60,child: VerticalDivider(thickness: 1.5)),
                      ],
                    ),
                  ),
                  trailing: Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    width: 112,
                    height: 80,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.edit, color: Color(0xFFE2699FB)), onPressed: () {}),
                          VerticalDivider(thickness: 1.5, ),
                          IconButton(icon: Icon(Icons.cancel_outlined, color: Color(0xFFE2699FB)), onPressed: () {})
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}