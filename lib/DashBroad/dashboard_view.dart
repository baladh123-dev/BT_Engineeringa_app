import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 30),
                _buildStatusCards(),
                const SizedBox(height: 30),
                _sectionTitle('Your Appliances'),
                const SizedBox(height: 15),
                _buildAppliancesGrid(),
                const SizedBox(height: 30),
                _sectionTitle('Recent Services'),
                const SizedBox(height: 15),
                _buildRecentServices(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: const Color(0xFF6C63FF),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Book Service', style: TextStyle(color: Colors.white)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }

  // Header
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BT Engineering 👋',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Service your home appliances',
              style: TextStyle(fontSize: 15, color: Colors.grey[600]),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(29),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () {
              // your action here
            },
            child: Padding(
              padding: const EdgeInsets.all(0), // to match IconButton padding
              child: Image.asset(
                'assets/logo.png',
                height: 49,
                width: 49,
              ),
            ),
          ),
        )

      ],
    );
  }

  // Status Cards Row
  Widget _buildStatusCards() {
    return Row(
      children: [
        Expanded(
          child: _statusCard(
            title: 'Clients \n Served',
            count: '100K+',
            icon: Icons.groups,
            iconColor: const Color(0xFF3F51B5),
            bgColor: const Color(0xFFE8EAF6),
            valu: 0.97,
            circleValueColor: Colors.red,
          ),
        ),
        const SizedBox(width: 15),

        Expanded(
          child: _statusCard(
            title: 'Products Available',
            count: '92+',
            icon: Icons.inventory_2_outlined,
            iconColor: const Color(0xFF4CAF50),
            bgColor: const Color(0xFFE8F5E9),
            valu: 0.80,
            circleValueColor: Colors.yellow,
          ),
        ),
        const SizedBox(width: 15),

        Expanded(
          child: _statusCard(
            title: 'Authorized Dealers',
            count: '100+',
            icon: Icons.store_mall_directory_outlined,
            iconColor: const Color(0xFFFF9800),
            bgColor: const Color(0xFFFFF3E0),
            valu: 0.60,
            circleValueColor: Colors.green,
          ),
        ),
      ],
    );
  }


  Widget _statusCard({
    required String title,
    required String count,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required double valu,
    required Color circleValueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 🔥 Start left → go downward
                Transform.rotate(
                  angle: 1.57,
                  child: CircularProgressIndicator(
                    value: valu,
                    strokeWidth: 6,
                    color: circleValueColor, // main color
                    backgroundColor: circleValueColor.withOpacity(0.15), // smooth faded
                  ),
                ),

                // Icon inside
                Icon(
                  icon,
                  color: iconColor,
                  size: 18,
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),

          Text(
            count,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }


  // Section Title
  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.grey[900],
      ),
    );
  }

  // Appliances Grid
  Widget _buildAppliancesGrid() {
    return Obx(() => GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 1.1),
      itemCount: controller.appliances.length,
      itemBuilder: (context, index) {
        final a = controller.appliances[index];
        return _applianceCard(
          a['name'] as String,
          a['icon'] as IconData,
          a['status'] as String,
          Color(a['color'] as int),

        );
      },
    ));
  }

  Widget _applianceCard(String name, IconData icon, String status, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 5)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const Spacer(),
            Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: status == 'Good'
                    ? const Color(0xFFE8F5E9)
                    : status.contains('Due')
                    ? const Color(0xFFFFF3E0)
                    : const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: status == 'Good'
                      ? const Color(0xFF4CAF50)
                      : status.contains('Due')
                      ? const Color(0xFFFF9800)
                      : const Color(0xFFF44336),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Recent Services
  Widget _buildRecentServices() {
    return Obx(() => Column(
      children: controller.recentServices.map((service) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _recentServiceCard(
            service['title'] as String,
            service['status'] as String,
            service['date'] as String,
            service['icon'] as IconData,
            service['color'] as Color,

          ),
        );
      }).toList(),
    ));
  }

  Widget _recentServiceCard(String title, String status, String date, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text("$status • $date", style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
        ],
      ),
    );
  }

}
