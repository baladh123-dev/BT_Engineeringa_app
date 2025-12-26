import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CustomerCareController extends GetxController {
  final feedbackController = TextEditingController();

  var rating = 0.obs;

  void setRating(int value) {
    rating.value = value;
  }

  void clearFeedback() {
    rating.value = 0;
    feedbackController.clear();
  }

  bool validateFeedback() {
    return rating.value > 0 && feedbackController.text.isNotEmpty;
  }

  @override
  void onClose() {
    feedbackController.dispose();
    super.onClose();
  }
}
