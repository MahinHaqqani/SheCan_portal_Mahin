import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../widgets/intern_card.dart';
import '../widgets/reward_card.dart';
import 'announcements_screen.dart';
import 'leaderboard_screen.dart';
import 'donation_screen.dart';
import 'impact_screen.dart';
import 'rewards_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Widget buildTile({required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Colors.deepPurple[700]),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _logout() {
    Navigator.pop(context); // Simulates returning to login screen
    // Replace with Navigator.pushNamed(context, '/login') if LoginScreen is defined
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          // Chatbot action
        },
        child: const Icon(Icons.smart_toy, color: Colors.white),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/login_bg.png',
              fit: BoxFit.cover,
              color: Colors.white.withOpacity(0.2),
              colorBlendMode: BlendMode.lighten,
            ),
          ),
          _isLoading
              ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                children: [
                  Container(height: 100, color: Colors.white, width: double.infinity),
                  const SizedBox(height: 16),
                  Container(height: 120, color: Colors.white, width: double.infinity),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.0,
                      children: List.generate(4, (index) => Container(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          )
              : FadeTransition(
            opacity: _fadeAnimation,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/login_bg.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.6),
                        BlendMode.lighten,
                      ),
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Welcome to SheCan Portal',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      const InternCard(
                        company: 'SheCan Foundation',
                        role: 'Community Intern',
                        duration: 'Referral Code: fareeha2025 | Donations: ₹5,000',
                        logoPath: 'assets/images/logo.png',
                      ),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => RewardsScreen()),
                          );
                        },
                        child: const RewardCard(
                          title: 'Referral Milestone',
                          description: 'Referred 10+ people! Bronze Badge Unlocked.',
                          iconPath: 'assets/rewards/bronze.png',
                        ),
                      ),
                      const SizedBox(height: 24),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Explore',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 12),
                      GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 1.0,
                        children: [
                          buildTile(
                            icon: Icons.announcement,
                            label: "Announcements",
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => AnnouncementsScreen()),
                            ),
                          ),
                          buildTile(
                            icon: Icons.leaderboard,
                            label: "Leaderboard",
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const LeaderboardScreen()),
                            ),
                          ),
                          buildTile(
                            icon: Icons.volunteer_activism,
                            label: "Donate Now",
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const DonationScreen()),
                            ),
                          ),
                          buildTile(
                            icon: Icons.emoji_events,
                            label: "Impact",
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const ImpactScreen()),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.deepPurple),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
    );
  }
}