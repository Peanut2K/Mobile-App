import 'package:flutter/material.dart';
import 'scan_page.dart';
import 'redeem_page.dart';

class PointPage extends StatefulWidget {
  const PointPage({Key? key}) : super(key: key);

  @override
  State<PointPage> createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {
  int _selectedIndex = 0;
  int _points = 155;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ScanPage()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const RedeemPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double progress = _points / 500;

    return Scaffold(
      backgroundColor: const Color(0xFF3B5F41),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -150,
              left: -100,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  color: const Color(0xFF4E6B4A),
                  borderRadius: BorderRadius.circular(200),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  const BackButton(color: Colors.white),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      'point',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFDEDDC),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      child: Text(
                        '$_points points',
                        key: ValueKey<int>(_points),
                        style: const TextStyle(
                          fontSize: 36,
                          color: Color(0xFFFDEDDC),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'claim free points',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 800),
                    tween: Tween(begin: 0.0, end: progress),
                    builder: (context, value, _) => LinearProgressIndicator(
                      value: value,
                      backgroundColor: Colors.white30,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.tealAccent),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Milestone', style: TextStyle(color: Colors.white)),
                        SizedBox(height: 12),
                        MilestoneCheck(text: '50 points', checked: true),
                        MilestoneCheck(text: '100 points', checked: true),
                        MilestoneCheck(text: '500 points', checked: false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Your stats',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFF6FC1A1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        CircularPercent(category: 'Plastic', percent: 70),
                        CircularPercent(category: 'Paper', percent: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFFDEDDC),
        selectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'SCAN'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'REDEEM'),
        ],
      ),
    );
  }
}

class MilestoneCheck extends StatelessWidget {
  final String text;
  final bool checked;
  const MilestoneCheck({Key? key, required this.text, required this.checked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          checked ? Icons.emoji_events : Icons.emoji_events_outlined,
          color: checked ? Colors.yellowAccent : Colors.white70,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

class CircularPercent extends StatelessWidget {
  final String category;
  final double percent;

  const CircularPercent({Key? key, required this.category, required this.percent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 1, end: percent / 100),
      duration: const Duration(milliseconds: 800),
      builder: (context, value, _) => Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: value,
                  strokeWidth: 8,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              Text('${(value * 100).toInt()}%', style: const TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 8),
          Text(category, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
