import 'package:get/get.dart';

import '../DashBroad/dashboard_view.dart';
import '../customerCare/customer_care_view.dart';
import '../product_list/product_list_view.dart';
import '../sell_exchange/sell_exchange_view.dart';

class BottomNavController extends GetxController {
  RxInt currentIndex = 0.obs;

  final pages = [
    DashboardView(),
    ProductListPage(),
    SellExchangePage(),
    CustomerCarePage(),
  ];

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
