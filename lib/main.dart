import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firetest/fire_service.dart';
import 'package:flutter/material.dart';

import 'add_pages.dart';
import 'edit_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FireStore Test')),
      body: Container(
        child: Column(
          children: [
            Text('Disini'),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AddDataPage();
                    },
                  ),
                );
              },
              icon: Icon(Icons.phone_android_outlined),
              color: Colors.red,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('product').snapshots(),
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
                    // padding: EdgeInsets.only(bottom: 70, top: 16),
                    itemCount: snapshot.data!.docs.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      // return Text('${ds["title"]} : ${ds["Desk"]}');
                      return ProductItem(
                        id: ds.id,
                        name: ds["productName"],
                        price: ds["productPrice"],
                        docSnapshot: ds,
                      );
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}

class ProductItem extends StatefulWidget {
  ProductItem(
      {required this.id,
      required this.name,
      required this.price,
      required this.docSnapshot});
  final id;
  final name;
  final price;

  final DocumentSnapshot docSnapshot;
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(widget.name),
              Text(widget.price),
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    // deleteProduct(widget.docSnapshot);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return EditPage(
                        id: widget.id,
                        docSnapshot: widget.docSnapshot,
                      );
                    }));
                  },
                  icon: Icon(Icons.edit),
                  color: Colors.blue),
              IconButton(
                  onPressed: () {
                    deleteProduct(widget.docSnapshot);
                  },
                  icon: Icon(Icons.delete_outline),
                  color: Colors.red),
            ],
          ),
        ],
      ),
    );
  }
}
