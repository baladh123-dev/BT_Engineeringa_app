import 'package:get/get.dart';
import 'package:flutter/material.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;

  // Bottom Navigation Change
  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  // Appliances Data
  final appliances = [
    {'name': 'Air Conditioner', 'icon': Icons.ac_unit, 'status': '₹499', 'color': 0xFF4ECDC4},
    {'name': 'Refrigerator', 'icon': Icons.kitchen, 'status': '₹399', 'color': 0xFF6C63FF},
    {'name': 'Washing Machine', 'icon': Icons.local_laundry_service, 'status': '399', 'color': 0xFFFF6B9D},
    {'name': 'Microwave', 'icon': Icons.microwave, 'status': '₹399', 'color': 0xFFFFA726},
    {'name': 'Dishwasher', 'icon': Icons.countertops, 'status': '₹299', 'color': 0xFFEF5350},
    {'name': 'Water Heater', 'icon': Icons.water_drop, 'status': '₹199', 'color': 0xFF42A5F5},
  ].obs;

  // Recent Services
  final recentServices = [
    {
      'title': 'AC Filter Replacement',
      'status': 'Completed',
      'date': 'Nov 15, 2025',
      'icon': Icons.check_circle,
      'color': Color(0xFF4CAF50)
    },
    {
      'title': 'Washing Machine Repair',
      'status': 'Scheduled',
      'date': 'Nov 20, 2025',
      'icon': Icons.schedule,
      'color': Color(0xFFFF9800)
    },
    {
      'title': 'Refrigerator Check-up',
      'status': 'In Progress',
      'date': 'Today',
      'icon': Icons.sync,
      'color': Color(0xFF2196F3)
    },
  ].obs;
}
