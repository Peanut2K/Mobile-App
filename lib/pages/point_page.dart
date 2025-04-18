import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/firestore_service.dart';

class PointPage extends StatefulWidget {
  final String userId;
  const PointPage({required this.userId, Key? key}) : super(key: key);

  @override
  State<PointPage> createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {
  final _fs = FirestoreService();
  bool _loadingUser = true;
  late UserModel _user;
  int _selectedIndex = 0;
  static const _milestones = [50, 100, 500];

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final u = await _fs.getUserById(widget.userId);
    if (u == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('User not found')));
      Navigator.pop(context);
      return;
    }
    setState(() {
      _user = u;
      _loadingUser = false;
    });
  }

  void _onNavTap(int idx) {
    setState(() => _selectedIndex = idx);
    switch (idx) {
      case 0:
        Navigator.pushReplacementNamed(context, '/main',
            arguments: widget.userId);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/scan',
            arguments: widget.userId);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/redeem',
            arguments: widget.userId);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingUser) {
      return const Scaffold(
        backgroundColor: Color(0xFF3B5F41),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // compute percentages
    final totalWaste = (_user.savedPlastic + _user.savedPaper) > 0
        ? (_user.savedPlastic + _user.savedPaper)
        : 1.0;
    final plasticPct = _user.savedPlastic / totalWaste;
    final paperPct   = _user.savedPaper   / totalWaste;

    return Scaffold(
      backgroundColor: const Color(0xFF3B5F41),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Point',
          style: TextStyle(
            color: Color(0xFFF2D9BB),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFF2D9BB)),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // decorative circle
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
                  const SizedBox(height: 10),

                  // points display
                  Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, anim) =>
                          ScaleTransition(scale: anim, child: child),
                      child: Text(
                        '${_user.points} points',
                        key: ValueKey<int>(_user.points),
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
                    'points stat',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),

                  const SizedBox(height: 4),
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 800),
                    tween: Tween(begin: 0.0, end: _user.points / 500),
                    builder: (ctx, val, _) => LinearProgressIndicator(
                      value: val.clamp(0.0, 1.0),
                      backgroundColor: Colors.white30,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.tealAccent),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // milestones
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Milestone',
                            style: TextStyle(color: Colors.white)),
                        const SizedBox(height: 12),
                        ..._milestones.map((m) {
                          final reached = _user.points >= m;
                          return Row(
                            children: [
                              Icon(
                                reached
                                    ? Icons.emoji_events
                                    : Icons.emoji_events_outlined,
                                color: reached
                                    ? Colors.yellowAccent
                                    : Colors.white70,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '$m points',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Text('Your stats',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  const SizedBox(height: 12),

                  // percentages
                  Text(
                    'Plastic: ${(plasticPct * 100).toStringAsFixed(1)}%    '
                    'Paper: ${(paperPct * 100).toStringAsFixed(1)}%',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 12),

                  // circular indicators
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6FC1A1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _CircularPercent(
                            category: 'Plastic', percent: plasticPct),
                        _CircularPercent(category: 'Paper', percent: paperPct),
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
        onTap: _onNavTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner), label: 'SCAN'),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard), label: 'REDEEM'),
        ],
      ),
    );
  }
}

class _CircularPercent extends StatelessWidget {
  final String category;
  final double percent;
  const _CircularPercent(
      {Key? key, required this.category, required this.percent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: percent.clamp(0.0, 1.0)),
      duration: const Duration(milliseconds: 800),
      builder: (ctx, val, _) => Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: val,
                  strokeWidth: 8,
                  backgroundColor: Colors.white24,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              Text('${(val * 100).toInt()}%',
                  style: const TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 8),
          Text(category, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
