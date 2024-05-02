import 'package:canteen_admin/controller/home_controller.dart';
import 'package:canteen_admin/widgets/drop_down_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Add Item"),
          backgroundColor: const Color.fromARGB(255, 80, 165, 207),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Add New Item",
                  style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 80, 165, 207),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: ctrl.productNameCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      label: const Text("Item Name"),
                      hintText: "Enter Your Item Name"),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: ctrl.productDescriptionCtrl,
                  maxLines: 4,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      label: const Text("Item Description"),
                      hintText: "Enter Your Item Description"),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: ctrl.productImgCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      label: const Text("Image Url"),
                      hintText: "Enter Your Image Url"),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: ctrl.productPriceCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      label: const Text("Item Price"),
                      hintText: "Enter Your Item Price"),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Flexible(
                        child: DropDownBtn(
                      items: const ['Breakfast', 'Lunch', 'Dinner'],
                      selectedItemText: ctrl.category,
                      onSelected: (selectedValue) {
                        ctrl.category = selectedValue ?? 'Category';
                        ctrl.update();
                      },
                    )),
                    Flexible(
                        child: DropDownBtn(
                      items: const ['Chilly', 'Sweet', 'Spicy'],
                      selectedItemText: ctrl.flavour,
                      onSelected: (selectedValue) {
                        ctrl.flavour = selectedValue ?? 'Flavour';
                        ctrl.update();
                      },
                    )),
                  ],
                ),
                const SizedBox(height: 15),
                const Text("Offer Item ?"),
                const SizedBox(height: 15),
                DropDownBtn(
                  items: const ['true', 'false'],
                  selectedItemText: ctrl.offer.toString(),
                  onSelected: (selectedValue) {
                    ctrl.offer =
                        bool.tryParse(selectedValue ?? 'Offer ?') ?? false;
                    ctrl.update();
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 80, 165, 207),
                        foregroundColor: Colors.white),
                    onPressed: () {
                      ctrl.addProduct();
                    },
                    child: const Text("Add Item")),
              ],
            ),
          ),
        ),
      );
    });
  }
}
