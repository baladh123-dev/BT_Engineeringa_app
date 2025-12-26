import 'package:get/get.dart';

import '../DashBroad/dashboard_controller.dart';
import '../DashBroad/dashboard_view.dart';
import '../Nav/bottom_nav_controller.dart';
import '../Nav/bottom_nav_widget.dart';
import '../customerCare/customer_care_controller.dart';
import '../customerCare/customer_care_view.dart';
import '../product_list/product_list_Controller.dart';
import '../product_list/product_list_view.dart';
import '../sell_exchange/sell_exchange_controller.dart';
import '../sell_exchange/sell_exchange_view.dart';

class Routes {
  static final List<GetPage> routes = [

    // Main NAV (root screen)
    GetPage(
      name: '/nav',
      page: () => BottomNavWidget(),
      binding: BindingsBuilder(() {
        Get.lazyPut<BottomNavController>(() => BottomNavController());
      }),
    ),

    // Individual pages for tabs
    GetPage(
      name: '/Dashboard',
      page: () => DashboardView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DashboardController>(() => DashboardController());
      }),
    ),

    GetPage(
      name: '/Customer',
      page: () => CustomerCarePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<CustomerCareController>(() => CustomerCareController());
      }),
    ),

      GetPage(
      name: '/Customer',
      page: () => ProductListPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ProductListController>(() => ProductListController());
      }),
    ),

    GetPage(
      name: '/sell',
      page: () => SellExchangePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SellExchangeController>(() => SellExchangeController());
      }),
    ),



  ];
}
