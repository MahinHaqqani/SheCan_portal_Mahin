import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/leaderboard_tile.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  final List<Map<String, dynamic>> dummyData = const [
    {'rank': 1, 'name': 'Fatima Khan', 'points': 980},
    {'rank': 2, 'name': 'Ananya Reddy', 'points': 910},
    {'rank': 3, 'name': 'Mehak Sharma', 'points': 860},
    {'rank': 4, 'name': 'Tanvi Patel', 'points': 830},
    {'rank': 5, 'name': 'Nandini Das', 'points': 810},
    {'rank': 6, 'name': 'Divya Menon', 'points': 800},
    {'rank': 7, 'name': 'Simranjeet Kaur', 'points': 790},
    {'rank': 8, 'name': 'Ayesha Syed', 'points': 765},
    {'rank': 9, 'name': 'Keerthana Ravi', 'points': 750},
    {'rank': 10, 'name': 'Roshni Barua', 'points': 730},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/login_bg.png',
              fit: BoxFit.cover,
              color: Colors.white.withOpacity(0.9),
              colorBlendMode: BlendMode.lighten,
            ),
          ),
          Column(
            children: [
              AppBar(
                title: Text(
                  'Leaderboard',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              const SizedBox(height: 10),
              const Icon(Icons.emoji_events, color: Colors.amber, size: 60),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  itemCount: dummyData.length,
                  itemBuilder: (context, index) {
                    final user = dummyData[index];
                    return _buildLeaderboardCard(context, user, index);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardCard(BuildContext context, Map<String, dynamic> user, int index) {
    bool isTop3 = index < 3;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: isTop3
            ? LinearGradient(colors: [Colors.purple.shade100, Colors.purple.shade50])
            : const LinearGradient(colors: [Colors.white, Colors.white]),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: isTop3 ? Colors.amber.shade400 : Colors.grey.shade300,
            child: Text(
              user['rank'].toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user['name'],
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Stack(
                  children: [
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Container(
                      height: 6,
                      width: (user['points'] / 1000) * MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Colors.purple, Colors.deepPurpleAccent]),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Row(
            children: [
              Image.asset('assets/rewards/coin.png', height: 24, width: 24),
              const SizedBox(width: 6),
              Text(
                user['points'].toString(),
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
