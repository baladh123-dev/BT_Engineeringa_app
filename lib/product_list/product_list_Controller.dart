import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProductListController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  var searchQuery = ''.obs;
  var selectedCategory = 'All'.obs;

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Samsung Smart Refrigerator',
      'category': 'Refrigerator',
      'age': 2,
      'price': 45000,
      'warranty': '2 Years',
      'offer': 15,
      'rating': 4.5,
      'image': Icons.kitchen,
      'color': 0xFF6C63FF,
    },
    {
      'name': 'LG Front Load Washing Machine',
      'category': 'Washing Machine',
      'age': 1,
      'price': 32000,
      'warranty': '3 Years',
      'offer': 20,
      'rating': 4.8,
      'image': Icons.local_laundry_service,
      'color': 0xFFFF6B9D,
    },
    {
      'name': 'Daikin Split AC 1.5 Ton',
      'category': 'Air Conditioner',
      'age': 3,
      'price': 38000,
      'warranty': '5 Years',
      'offer': 10,
      'rating': 4.6,
      'image': Icons.ac_unit,
      'color': 0xFF4ECDC4,
    },
    {
      'name': 'IFB Microwave Oven 30L',
      'category': 'Microwave',
      'age': 1,
      'price': 12500,
      'warranty': '1 Year',
      'offer': 25,
      'rating': 4.3,
      'image': Icons.microwave,
      'color': 0xFFFFA726,
    },
    {
      'name': 'Bosch Dishwasher 12 Place',
      'category': 'Dishwasher',
      'age': 2,
      'price': 28000,
      'warranty': '2 Years',
      'offer': 18,
      'rating': 4.7,
      'image': Icons.countertops,
      'color': 0xFFEF5350,
    },
    {
      'name': 'Havells Water Heater 25L',
      'category': 'Water Heater',
      'age': 1,
      'price': 8500,
      'warranty': '5 Years',
      'offer': 12,
      'rating': 4.4,
      'image': Icons.water_drop,
      'color': 0xFF42A5F5,
    },
    {
      'name': 'Whirlpool Double Door Fridge',
      'category': 'Refrigerator',
      'age': 3,
      'price': 35000,
      'warranty': '1 Year',
      'offer': 22,
      'rating': 4.2,
      'image': Icons.kitchen,
      'color': 0xFF9C27B0,
    },
    {
      'name': 'Voltas Window AC 1 Ton',
      'category': 'Air Conditioner',
      'age': 4,
      'price': 25000,
      'warranty': '3 Years',
      'offer': 30,
      'rating': 4.0,
      'image': Icons.ac_unit,
      'color': 0xFF26C6DA,
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    return products.where((product) {
      final matchesSearch = product['name']
          .toLowerCase()
          .contains(searchQuery.value.toLowerCase());

      final matchesCategory =
          selectedCategory.value == 'All' ||
              product['category'] == selectedCategory.value;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  double calculateDiscount(double price, int offer) {
    return price - (price * offer / 100);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
