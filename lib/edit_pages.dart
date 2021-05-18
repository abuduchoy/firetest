import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'fire_service.dart';

class EditPage extends StatefulWidget {
  EditPage({required this.id, required this.docSnapshot});
  final String id;
  final DocumentSnapshot docSnapshot;

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController productPriceCtrl = TextEditingController();
  //  productPriceCtrl.text = docSnapshot['price'];

  // myData = await firestore.collection('product').doc();

  Future<void> eProduct(DocumentSnapshot doc) async {
    // ignore: unnecessary_null_comparison
    if (doc != null) {
      productPriceCtrl.text = doc['price'].toString();
    }
  }

  // var dt = firestore.collection('product').doc(widget.id).get();

  void createRecord() async {
    // Firebase.initializeApp();
    await firestore
        .collection("book")
        .doc("3")
        .set({'title': 'Test Again and again', 'Desk': 'Bre bla bla'});
  }

  @override
  Widget build(BuildContext context) {
    late String _pPrice;
    productPriceCtrl.text = widget.docSnapshot['productPrice'].toString();
    // print(callEdit);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
      ),
      body: Container(
          child: Column(
        children: [
          Text(widget.id),
          Text(widget.docSnapshot["productPrice"]),
          TextField(
            controller: productPriceCtrl,
            onChanged: (value) {
              _pPrice = value;
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
          TextButton(
            onPressed: () {
              // createRecord();
              editProduct(_pPrice, widget.id);
              Navigator.of(context).pop();
              // getData();
            },
            child: Text('Edit Price'),
          ),
        ],
      )),
    );
  }
}
