import 'package:canteen_admin/model/product/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;

  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController productDescriptionCtrl = TextEditingController();
  TextEditingController productImgCtrl = TextEditingController();
  TextEditingController productPriceCtrl = TextEditingController();

  String category = 'category';
  String flavour = 'flavour';
  bool offer = false;

  List<Product> products = [];

  @override
  Future<void> onInit() async {
    productCollection = firestore.collection("Items");
    await fetchProducts();
    super.onInit();
  }

  addProduct() {
    try {
      DocumentReference doc = productCollection.doc();
      Product product = Product(
        id: doc.id,
        name: productNameCtrl.text,
        category: category,
        description: productDescriptionCtrl.text,
        price: double.tryParse(productPriceCtrl.text),
        flavour: flavour,
        image: productImgCtrl.text,
        offer: offer,
      );
      final productJson = product.toJson();
      doc.set(productJson);
      Get.snackbar('Success', "Item added successfully",
          colorText: const Color.fromARGB(255, 6, 203, 52),
          backgroundColor: Colors.white);
      setValuesDefault();
      fetchProducts();
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          colorText: Colors.red, backgroundColor: Colors.white);
      print(e);
    }
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrievedProducts = productSnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      products.clear();
      products.assignAll(retrievedProducts);
      Get.snackbar('Success', 'Products fetched Successfully',
          colorText: Colors.green, backgroundColor: Colors.white);
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          colorText: Colors.red, backgroundColor: Colors.white);
      print(e);
    } finally {
      update();
    }
  }

  deleteProduct(String id) async {
    try {
      await productCollection.doc(id).delete();
      fetchProducts();
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          colorText: Colors.red, backgroundColor: Colors.white);
      print(e);
    }
  }

  setValuesDefault() {
    productNameCtrl.clear();
    productPriceCtrl.clear();
    productDescriptionCtrl.clear();
    productImgCtrl.clear();

    category = 'category';
    flavour = 'flavour';
    offer = false;
    update();
  }
}
