import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'product_list_controller.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage({super.key});

  final ProductListController controller = Get.put(ProductListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildCategoryFilter(),
            Expanded(child: _buildProductList()),
          ],
        ),
      ),
    );
  }

  // ---------------- Header ----------------
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6C63FF),
            const Color(0xFF6C63FF).withOpacity(0.8),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'BT Engineering',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Obx(() => Text(
                '${controller.filteredProducts.length} Products Available',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                ),
              )),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.shopping_cart_outlined,
                color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  // ---------------- Search Bar ----------------
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Obx(() => TextField(
          controller: controller.searchController,
          onChanged: (value) => controller.searchQuery.value = value,
          decoration: InputDecoration(
            hintText: 'Search products...',
            prefixIcon:
            const Icon(Icons.search, color: Color(0xFF6C63FF)),
            suffixIcon: controller.searchQuery.isNotEmpty
                ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                controller.searchController.clear();
                controller.searchQuery.value = '';
              },
            )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(left: 20, top: 16),
          ),
        )),
      ),
    );
  }

  // ---------------- Category Filter ----------------
  Widget _buildCategoryFilter() {
    final categories = [
      'All',
      'Refrigerator',
      'Washing Machine',
      'Air Conditioner',
      'Microwave',
      'Dishwasher',
      'Water Heater'
    ];

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return GestureDetector(
            onTap: () => controller.selectedCategory.value = category,
            child: Obx(() {
              final isSelected = controller.selectedCategory.value == category;
              return Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF6C63FF) : Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );

  }

  // ---------------- Product List ----------------
  Widget _buildProductList() {
    return Obx(() {
      final products = controller.filteredProducts;

      if (products.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 80, color: Colors.grey[300]),
              const SizedBox(height: 20),
              Text(
                'No Products Found',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: products.length,
        itemBuilder: (_, index) {
          return _buildProductCard(products[index]);
        },
      );
    });
  }

  // ---------------- Product Card ----------------
  Widget _buildProductCard(Map<String, dynamic> product) {
    final discountPrice =
    controller.calculateDiscount(product['price'].toDouble(), product['offer']);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ListTile(
        onTap: () {},
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Color(product['color']).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            product['image'],
            size: 40,
            color: Color(product['color']),
          ),
        ),
        title: Text(product['name'],
            maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          '₹$discountPrice',
          style: const TextStyle(
              color: Color(0xFF6C63FF),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
