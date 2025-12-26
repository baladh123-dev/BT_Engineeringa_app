// ignore_for_file: prefer_const_constructors

import 'package:bt_engineering/sell_exchange/sell_exchange_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellExchangePage extends StatelessWidget {
  const SellExchangePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SellExchangeController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabBar(controller),

            // FIXED: Removed Obx, TabBarView does not need Obx
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  _buildForm(controller, false), // Sell Form
                  _buildForm(controller, true),  // Exchange Form
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------- HEADER ----------------------
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF6C63FF),
            Color(0xFF6C63FF).withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackButton(color: Colors.white),
              Text(
                'Sell or Exchange',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 40),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Get the best value for your appliances',
            style: TextStyle(color: Colors.white.withOpacity(.9)),
          ),
        ],
      ),
    );
  }

  // ---------------------- TAB BAR ----------------------
  Widget _buildTabBar(SellExchangeController controller) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TabBar(
        controller: controller.tabController,
        indicator: BoxDecoration(
          color: Color(0xFF6C63FF),
          borderRadius: BorderRadius.circular(15),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        tabs: const [
          Tab(text: '💰 Sell Product'),
          Tab(text: '🔄 Exchange'),
        ],
      ),
    );
  }

  // ---------------------- FORM UI ----------------------
  Widget _buildForm(SellExchangeController c, bool isExchange) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),

      // FIX: Unique formKey for both tabs
      child: Form(
        key: isExchange ? c.exchangeFormKey : c.sellFormKey,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isExchange ? "Exchange Your Appliance" : "Sell Your Appliance",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            // Category
            Text("Category"),
            SizedBox(height: 10),
             _buildCategorySelector(c),
            SizedBox(height: 20),

            // Brand
            _field(
              "Brand Name",
              c.brandController,
              Icons.business,
              validator: c.validator,
            ),

            SizedBox(height: 20),

            // Product Name
            _field(
              "Product Name",
              c.nameController,
              Icons.shopping_bag,
              validator: c.validator,
            ),

            SizedBox(height: 20),

            // Year
            _field(
              "Year of Purchase",
              c.yearController,
              Icons.calendar_today,
              keyboard: TextInputType.number,
              validator: c.yearValidator,
            ),

            SizedBox(height: 20),

            // Condition
            Text("Condition"),
            SizedBox(height: 10),
            Obx(() => _buildConditionSelector(c)),

            SizedBox(height: 20),

            // Price
            _field(
              "Expected Price ₹",
              c.priceController,
              Icons.currency_rupee,
              keyboard: TextInputType.number,
              validator: c.priceValidator,
            ),

            SizedBox(height: 20),

            // Reason
            _field(
              "Reason for ${isExchange ? 'Exchange' : 'Selling'}",
              c.reasonController,
              Icons.info_outline,
              maxLines: 3,
              validator: c.validator,
            ),

            SizedBox(height: 20),

            // Description
            _field(
              "Description",
              c.descriptionController,
              Icons.description,
              maxLines: 4,
              validator: c.validator,
            ),

            SizedBox(height: 20),

            // Image Upload
            Text("Product Images"),
            SizedBox(height: 10),
            Obx(() => _buildImageUpload(c)),
            SizedBox(height: 20),

            // SUBMIT BUTTON
            Obx(
                  () => SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: c.isSubmitting.value
                      ? null
                      : () => c.sendToWhatsApp(isExchange),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    isExchange ? Color(0xFF4ECDC4) : Color(0xFF6C63FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: c.isSubmitting.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat),
                      SizedBox(width: 10),
                      Text(isExchange
                          ? "Submit Exchange Request"
                          : "Submit Sell Request"),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ---------------------- WIDGET HELPERS ----------------------

  Widget _field(String label, TextEditingController c, IconData icon,
      {int maxLines = 1,
        TextInputType? keyboard,
        String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
            controller: c,
            maxLines: maxLines,
            keyboardType: keyboard,
            validator: validator,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Color(0xFF6C63FF)),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySelector(SellExchangeController c) {
    return SizedBox(
      height: 120,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: c.categories.length,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          final cat = c.categories[index];
          final selected = c.selectedCategory.value == cat;

          return GestureDetector(
            onTap: () => c.selectedCategory.value = cat,
            child: Container(
              margin: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: selected ? Color(0xFF6C63FF) : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  cat,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildConditionSelector(SellExchangeController c) {
    return Row(
      children: c.conditions.map((condition) {
        final selected = c.selectedCondition.value == condition;

        return Expanded(
          child: GestureDetector(
            onTap: () => c.selectedCondition.value = condition,
            child: Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: selected ? Color(0xFF6C63FF) : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                condition,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildImageUpload(SellExchangeController c) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => c.addImage(),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFF6C63FF).withOpacity(.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(Icons.cloud_upload, size: 50, color: Color(0xFF6C63FF)),
                SizedBox(height: 10),
                Text("Tap to upload images"),
              ],
            ),
          ),
        ),

        if (c.selectedImages.isNotEmpty) SizedBox(height: 10),

        Wrap(
          spacing: 10,
          children: c.selectedImages.map((img) {
            return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.image, color: Colors.green),
                  SizedBox(width: 5),
                  Text(img),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () => c.removeImage(img),
                    child: Icon(Icons.close, color: Colors.red),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
