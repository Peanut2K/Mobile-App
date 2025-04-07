import 'package:flutter/material.dart';

class RedeemPage extends StatelessWidget {
  const RedeemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF445D44),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Your Points', style: TextStyle(fontSize: 18)),
          const Text('155 points', style: TextStyle(fontSize: 36)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              RewardItem(name: '5% Discount', cost: 50),
              RewardItem(name: 'Free Ice cream', cost: 100),
              RewardItem(name: 'Gift Voucher', cost: 150),
            ],
          ),
        ],
      ),
    );
  }
}

class RewardItem extends StatelessWidget {
  final String name;
  final int cost;
  const RewardItem({Key? key, required this.name, required this.cost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.card_giftcard, size: 40, color: Colors.blueGrey),
        const SizedBox(height: 8),
        Text(name),
        Text('$cost pts'),
      ],
    );
  }
}
