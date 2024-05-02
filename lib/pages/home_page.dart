import 'package:canteen_admin/controller/home_controller.dart';
import 'package:canteen_admin/pages/add_product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Canteen Admin'),
          backgroundColor: const Color.fromARGB(255, 80, 165, 207),
        ),
        body: ListView.builder(
            itemCount: ctrl.products.length,
            itemBuilder: ((context, index) {
              return Container(
                margin: const EdgeInsets.all(5),
                child: ListTile(
                  title: Text(
                    ctrl.products[index].name ?? '',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Rs. ${ctrl.products[index].price ?? 0}",
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      size: 28,
                    ),
                    onPressed: () {
                      ctrl.deleteProduct(ctrl.products[index].id ?? '');
                      print("Deleted");
                    },
                  ),
                ),
              );
            })),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => AddProductPage()),
            // );

            Get.to(const AddProductPage());
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
