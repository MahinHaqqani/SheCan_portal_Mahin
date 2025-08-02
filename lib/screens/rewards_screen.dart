import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> rewards = [
    {
      'title': 'Referral Milestone',
      'description': 'Referred 10+ people! Bronze Badge Unlocked.',
      'image': 'assets/rewards/bronze.png',
    },
    {
      'title': 'Fundraiser Champion',
      'description': 'Raised ₹5000 for the cause. Silver Badge Achieved.',
      'image': 'assets/rewards/diamond.png',
    },
    {
      'title': 'Top 10 Leaderboard',
      'description': 'Exclusive Gold Badge for top performers.',
      'image': 'assets/rewards/gold.png',
    },
    {
      'title': 'Community Helper',
      'description': 'Helped 3+ friends join the initiative.',
      'image': 'assets/rewards/helper.png',
    },
    {
      'title': 'ShePoints Collector',
      'description': 'Earned 1500+ ShePoints!',
      'image': 'assets/rewards/coin.png',
    },
  ];

  void _downloadCertificate(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Certificate for "$title" downloaded! 🏆')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Your Achievements'),
        backgroundColor: Colors.deepPurple.withOpacity(0.8),
        elevation: 2,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.card_giftcard_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/login_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.white.withOpacity(0.85),
          ),
          ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, kToolbarHeight + 32, 16, 16),
            itemCount: rewards.length,
            itemBuilder: (context, index) {
              final reward = rewards[index];
              return _RewardCard(
                title: reward['title'],
                description: reward['description'],
                image: reward['image'],
                delay: index * 150,
                onDownload: () => _downloadCertificate(context, reward['title']),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _RewardCard extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final int delay;
  final VoidCallback onDownload;

  const _RewardCard({
    required this.title,
    required this.description,
    required this.image,
    required this.delay,
    required this.onDownload,
  });

  @override
  State<_RewardCard> createState() => _RewardCardState();
}

class _RewardCardState extends State<_RewardCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Card(
          elevation: 6,
          margin: const EdgeInsets.only(bottom: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        widget.image,
                        height: 60,
                        width: 60,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported_outlined, size: 40),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.description,
                            style: const TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: widget.onDownload,
                    icon: const Icon(Icons.download_rounded),
                    label: const Text("Download Certificate"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
