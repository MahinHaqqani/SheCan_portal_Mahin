import 'package:flutter/material.dart';

class ImpactScreen extends StatelessWidget {
  const ImpactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final impactStats = [
      {"title": "Lives Touched", "value": "3,250+", "icon": Icons.favorite},
      {"title": "Volunteers", "value": "120+", "icon": Icons.group},
      {"title": "Meals Served", "value": "15,000+", "icon": Icons.restaurant},
    ];

    final testimonials = [
      "“This organization changed my life.” – Ayesha, 19",
      "“Thanks to SheCan, I feel empowered again.” – Reema, 22",
      "“They gave me hope when I had none.” – Zara, 25",
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Our Impact'),
        backgroundColor: Colors.deepPurple.withOpacity(0.85),
        elevation: 2,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/login_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // White translucent overlay
          Container(
            color: Colors.white.withOpacity(0.9),
          ),
          // Main Content
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
            children: [
              Text(
                "Your Donations Make a Difference 💫",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple[900],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),

              // Impact Stats Cards (Glass-like)
              Wrap(
                spacing: 15,
                runSpacing: 15,
                alignment: WrapAlignment.center,
                children: impactStats.map((item) {
                  return _ImpactCard(
                    title: item['title'] as String,
                    value: item['value'] as String,
                    icon: item['icon'] as IconData,
                  );
                }).toList(),
              ),

              const SizedBox(height: 40),
              Text(
                "Real Stories from Real People 💬",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal[800],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Testimonials
              ...testimonials.map((quote) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.deepPurple.shade100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: Text(
                    quote,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class _ImpactCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _ImpactCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.teal.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.teal.shade400, size: 32),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple[800],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
