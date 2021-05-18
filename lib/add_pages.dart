import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firetest/fire_service.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AddDataPage extends StatefulWidget {
  // AddDataPage({Key key}) : super(key: key);

  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // String id;
  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController productPriceCtrl = TextEditingController();

  late String _productName;
  late String _productPrice;

  // String _productName;

  void createRecord() async {
    // Firebase.initializeApp();
    await firestore
        .collection("book")
        .doc("3")
        .set({'title': 'Test Again and again', 'Desk': 'Bre bla bla'});

    // DocumentReference ref =
    //     firestore.collection("book").add({'title': 'hy', 'Desk': 'bla'});

    // print(ref.id);
  }

  void getData() {
    firestore.collection("book").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((e) {
        print(e.data());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: productNameCtrl,
              onChanged: (value) {
                _productName = value;
              },
              decoration: InputDecoration(
                  labelText: "Product Name",
                  focusedBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                      color: Colors.green,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  icon: Icon(
                    Icons.assignment,
                    color: Colors.orangeAccent,
                  ),
                  fillColor: Colors.white,
                  labelStyle: TextStyle(color: Colors.green)),
            ),
            TextField(
              controller: productPriceCtrl,
              onChanged: (value) {
                _productPrice = value;
              },
              decoration: InputDecoration(
                  labelText: "Product Price",
                  focusedBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                      color: Colors.green,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  icon: Icon(
                    Icons.price_change_outlined,
                    color: Colors.orangeAccent,
                  ),
                  fillColor: Colors.white,
                  labelStyle: TextStyle(color: Colors.green)),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    // createRecord();
                    uploadingData(_productName, _productPrice);
                    Navigator.of(context).pop();
                    // getData();
                  },
                  child: Text('Add Record'),
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('book').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('error : $snapshot.error');
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading ...");
                  }
                  return ListView.builder(
                    // scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 70, top: 16),
                    itemCount: snapshot.data!.docs.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      return Text('${ds["title"]} : ${ds["Desk"]}');
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}
