import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadingData(String _productName, String _productPrice) async {
  await FirebaseFirestore.instance.collection('product').add({
    'productName': _productName,
    'productPrice': _productPrice,
  });
}

Future<void> editProduct(String _productPrice, String id) async {
  await FirebaseFirestore.instance.collection('product').doc(id).update({
    "productPrice": _productPrice,
  });
}

Future<void> deleteProduct(DocumentSnapshot doc) async {
  await FirebaseFirestore.instance.collection('product').doc(doc.id).delete();
}
