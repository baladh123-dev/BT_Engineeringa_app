import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'customer_care_controller.dart';

class CustomerCarePage extends StatelessWidget {
  const CustomerCarePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerCareController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWelcomeSection(),
                    const SizedBox(height: 30),
                    _buildQuickContactSection(),
                    const SizedBox(height: 30),
                    _buildContactOptionsGrid(),
                    const SizedBox(height: 30),
                    _buildFeedbackSection(controller),
                    const SizedBox(height: 30),
                    _buildFAQSection(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------- HEADER --------------------
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6C63FF),
            const Color(0xFF6C63FF).withOpacity(0.8),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Image.asset('assets/logo.png', height: 55, width: 55,),
                onPressed: () {}
              ),
              const Text(
                'Customer Care',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),

        ],
      ),
    );
  }

  // -------------------- WELCOME --------------------
  Widget _buildWelcomeSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF667EEA).withOpacity(0.1),
            const Color(0xFF764BA2).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF6C63FF).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.headset_mic,
                color: Color(0xFF6C63FF), size: 30),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Need Assistance?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  'Our support team is always ready to help',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- QUICK CONTACT --------------------
  Widget _buildQuickContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Contact',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        _buildQuickContactCard('Call Us', '9384199108', Icons.phone,
            const Color(0xFF4CAF50), const Color(0xFFE8F5E9)),
        const SizedBox(height: 12),
        _buildQuickContactCard('WhatsApp', '9788030743', Icons.chat,
            const Color(0xFF25D366), const Color(0xFFE8F5E9)),
        const SizedBox(height: 12),
        _buildQuickContactCard('Email Us', 'baladh123@gmail.com', Icons.email,
            const Color(0xFF2196F3), const Color(0xFFE3F2FD)),
      ],
    );
  }

  Widget _buildQuickContactCard(
      String title, String contact, IconData icon, Color iconColor, Color bg) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 5))
          ]),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(15)),
            child: Icon(icon, color: iconColor, size: 26),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey)),
                const SizedBox(height: 4),
                Text(contact,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Icon(Icons.arrow_forward, color: iconColor)
        ],
      ),
    );
  }

  // -------------------- GRID OPTIONS --------------------
  Widget _buildContactOptionsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How Can We Help?',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 1.2,
          children: [
            _buildOptionCard('Service Request', Icons.build, const Color(0xFF6C63FF)),
            _buildOptionCard('Track Order', Icons.location_on, const Color(0xFFFF6B9D)),
            _buildOptionCard('Warranty Info', Icons.verified_user, const Color(0xFF4ECDC4)),
            _buildOptionCard('Payment Help', Icons.payment, const Color(0xFFFFA726)),
          ],
        ),
      ],
    );
  }

  Widget _buildOptionCard(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 5))
          ]),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.15),
                child: Icon(icon, color: color, size: 30),
              ),
              const SizedBox(height: 12),
              Text(title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------- FEEDBACK SECTION --------------------
  Widget _buildFeedbackSection(CustomerCareController controller) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 10))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Share Your Feedback',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const Text('Rate Your Experience',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),

          /// ⭐ STAR RATING
          Obx(() => Row(
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () => controller.setRating(index + 1),
                child: Icon(
                  index < controller.rating.value
                      ? Icons.star
                      : Icons.star_border,
                  color: const Color(0xFFFFA726),
                  size: 36,
                ),
              );
            }),
          )),
          const SizedBox(height: 20),

          const Text('Your Feedback',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),

          TextField(
            controller: controller.feedbackController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Tell us about your experience...',
              filled: true,
              fillColor: const Color(0xFFF8F9FD),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                if (controller.validateFeedback()) {
                  Get.snackbar('Thank You', 'Feedback submitted successfully!',
                      backgroundColor: Colors.green,
                      colorText: Colors.white);

                  controller.clearFeedback();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text('Submit Feedback',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- FAQ SECTION --------------------
  Widget _buildFAQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Frequently Asked Questions',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        _buildFAQItem('What are your service hours?',
            'We provide 24/7 customer support for all your needs.'),
        const SizedBox(height: 10),
        _buildFAQItem('How long does a service take?',
            'Most services are completed within 2-4 hours.'),
        const SizedBox(height: 10),
        _buildFAQItem(
            'Do you provide warranty?',
            'Yes, all our services include a 90-day warranty.'),
      ],
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 3))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.help_outline, color: Color(0xFF6C63FF)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(question,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 34),
            child: Text(answer,
                style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          ),
        ],
      ),
    );
  }
}
