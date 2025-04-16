import 'package:flutter/material.dart';
import 'scan_page.dart';

class RedeemPage extends StatefulWidget {
  const RedeemPage({Key? key}) : super(key: key);

  @override
  State<RedeemPage> createState() => _RedeemPageState();
}

class _RedeemPageState extends State<RedeemPage> {
  int _selectedIndex = 0;
  int? selectedReward;
  int userPoints = 155;

  final List<Map<String, dynamic>> rewards = [
    {'name': '5% Discount', 'cost': 100},
    {'name': 'Free Ice cream', 'cost': 100},
    {'name': 'Gift Voucher', 'cost': 150},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ScanPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RedeemPage()),
      );
    }
  }

  void _confirmRedeem(String name, int cost) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Confirm Redeem'),
        content: Text('Are you sure you want to redeem "$name" for $cost points?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _redeemReward(name, cost);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _redeemReward(String name, int cost) {
    if (userPoints >= cost) {
      setState(() {
        userPoints -= cost;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You redeemed: $name! 🎉'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Not enough points!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F3),
      appBar: AppBar(
        title: const Text('Redeem', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF445D48),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Your Points',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF445D48),
            ),
          ),
          const SizedBox(height: 8),
          Hero(
            tag: 'pointsHero',
            child: Material(
              color: Colors.transparent,
              child: Text(
                '$userPoints ●',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF445D48),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Rewards',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF445D48),
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(rewards.length, (index) {
            final reward = rewards[index];
            return RewardItem(
              name: reward['name'],
              cost: reward['cost'],
              onTap: () => _confirmRedeem(reward['name'], reward['cost']),
            );
          }),
        ],
      ),
      
    );
  }
}

class RewardItem extends StatelessWidget {
  final String name;
  final int cost;
  final VoidCallback onTap;

  const RewardItem({
    Key? key,
    required this.name,
    required this.cost,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFF6FC1A1),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.green.withOpacity(0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: const TextStyle(fontSize: 16)),
            Text('$cost ●',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
