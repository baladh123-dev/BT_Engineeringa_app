import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellExchangeController extends GetxController
    with GetSingleTickerProviderStateMixin {

  // ---------------- FORM KEYS (UPDATED) ----------------
  final sellFormKey = GlobalKey<FormState>();
  final exchangeFormKey = GlobalKey<FormState>();

  late TabController tabController;

  // ---------------- TEXT CONTROLLERS ----------------
  final brandController = TextEditingController();
  final nameController = TextEditingController();
  final yearController = TextEditingController();
  final reasonController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  // ---------------- OBSERVABLES ----------------
  RxString selectedCategory = 'Refrigerator'.obs;
  RxString selectedCondition = 'Good'.obs;

  RxList<String> selectedImages = <String>[].obs;

  RxBool isSubmitting = false.obs;

  // ---------------- STATIC DATA ----------------
  final categories = [
    'Refrigerator',
    'Washing Machine',
    'Air Conditioner',
    'Microwave',
    'Dishwasher',
    'Water Heater',
    'Television',
    'Other'
  ];

  final conditions = ['Excellent', 'Good', 'Fair', 'Poor'];

  // ---------------- INIT ----------------
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  // ---------------- VALIDATORS ----------------
  String? validator(String? v) =>
      v == null || v.isEmpty ? "Required" : null;

  String? yearValidator(String? v) {
    if (v == null || v.isEmpty) return "Year required";
    final year = int.tryParse(v);
    if (year == null || year < 1990 || year > 2025) {
      return "Enter valid year (1990–2025)";
    }
    return null;
  }

  String? priceValidator(String? v) {
    if (v == null || v.isEmpty) return "Price required";
    if (int.tryParse(v) == null) return "Enter valid number";
    return null;
  }

  // ---------------- IMAGE FUNCTIONS ----------------
  void addImage() {
    selectedImages.add("image_${selectedImages.length + 1}.jpg");

    Get.snackbar("Image Added", "Demo image added.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white);
  }

  void removeImage(String img) {
    selectedImages.remove(img);
  }

  // ---------------- SUBMIT ----------------
  void sendToWhatsApp(bool isExchange) {
    // ---- PICK CORRECT FORM KEY ----
    final key = isExchange ? exchangeFormKey : sellFormKey;

    if (!key.currentState!.validate()) return;

    isSubmitting.value = true;

    final type = isExchange ? "EXCHANGE" : "SELL";
    final msg = """
🔔 NEW $type REQUEST

Category: ${selectedCategory.value}
Brand: ${brandController.text}
Product: ${nameController.text}
Year: ${yearController.text}
Condition: ${selectedCondition.value}
Price: ₹${priceController.text}

Reason: ${reasonController.text}
Description: ${descriptionController.text}

Images: ${selectedImages.length} file(s)
""";

    final encoded = Uri.encodeComponent(msg);
    final url = "https://wa.me/919788030743?text=$encoded";

    Future.delayed(Duration(milliseconds: 700), () {
      isSubmitting.value = false;

      Get.defaultDialog(
        title: "Success!",
        middleText: "Request will open in WhatsApp.",
        textConfirm: "Continue",
        onConfirm: () {
          Get.back();
          Get.snackbar("WhatsApp URL", url,
              snackPosition: SnackPosition.BOTTOM);
          resetForm();
        },
      );
    });
  }

  // ---------------- RESET ----------------
  void resetForm() {
    brandController.clear();
    nameController.clear();
    priceController.clear();
    descriptionController.clear();
    reasonController.clear();
    yearController.clear();

    selectedImages.clear();
    selectedCategory.value = "Refrigerator";
    selectedCondition.value = "Good";
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
