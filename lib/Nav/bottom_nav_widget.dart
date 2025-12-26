import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bottom_nav_controller.dart';

class BottomNavWidget extends StatelessWidget {
  final controller = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: controller.pages[controller.currentIndex.value],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changeIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF6C63FF),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Buy'),
          BottomNavigationBarItem(icon: Icon(Icons.sell_outlined), label: 'Sell'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Support'),
        ],
      ),
    ));
  }
}
