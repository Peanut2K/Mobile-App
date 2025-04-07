import 'package:flutter/material.dart';

class PointPage extends StatelessWidget {
  const PointPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Point'),
        backgroundColor: const Color(0xFF3B5F41),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('155 points', style: TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Milestone:'),
                SizedBox(width: 8),
                Text('50 / 100 / 500 points'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                CircularPercent(category: 'Plastic', percent: 70),
                CircularPercent(category: 'Paper', percent: 30),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/redeem');
              },
              child: const Text('Redeem Rewards'),
            )
          ],
        ),
      ),
    );
  }
}

class CircularPercent extends StatelessWidget {
  final String category;
  final double percent;
  const CircularPercent({super.key, required this.category, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
          ),
          child: Center(
            child: Text('$percent%'),
          ),
        ),
        const SizedBox(height: 8),
        Text(category),
      ],
    );
  }
}
