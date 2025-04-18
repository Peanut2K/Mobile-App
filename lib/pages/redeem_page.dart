import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/firestore_service.dart';

class RedeemPage extends StatefulWidget {
  final String userId;
  const RedeemPage({required this.userId, Key? key}) : super(key: key);

  @override
  State<RedeemPage> createState() => _RedeemPageState();
}

class _RedeemPageState extends State<RedeemPage> {
  final _fs = FirestoreService();
  bool _loadingUser = true;
  bool _saving = false;
  late UserModel _user;

  final List<Map<String, dynamic>> _rewards = [
    {'name': '5% Discount',   'cost': 100},
    {'name': 'Free Ice cream','cost': 100},
    {'name': 'Gift Voucher',  'cost': 150},
  ];

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final u = await _fs.getUserById(widget.userId);
    if (u == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not found')),
      );
      Navigator.pop(context);
      return;
    }
    setState(() {
      _user = u;
      _loadingUser = false;
    });
  }

  void _confirmRedeem(String name, int cost) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirm Redeem'),
        content: Text('Redeem "$name" for $cost points?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
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

  Future<void> _redeemReward(String name, int cost) async {
    if (_user.points < cost) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❗ Not enough points!'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _saving = true);

    final updated = UserModel(
      id:            _user.id,
      username:      _user.username,
      mobileNumber:  _user.mobileNumber,
      password:      _user.password,
      points:        _user.points - cost,
      recycledAmount:_user.recycledAmount,
      savedCarbon:   _user.savedCarbon,
      savedPlastic:  _user.savedPlastic,
      savedPaper:    _user.savedPaper,
      vibrate:       _user.vibrate,
      beeb:          _user.beeb,
    );

    try {
      await _fs.updateUser(updated);
      setState(() => _user = updated);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ You redeemed: $name!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingUser) {
      return const Scaffold(
        backgroundColor: Color(0xFF445D44),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF445D44),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Center(
            child: Text(
              'Your Points',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFF2D9BB)),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Hero(
              tag: 'pointsHero',
              child: Material(
                color: Colors.transparent,
                child: Text(
                  '${_user.points} ●',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF2D9BB),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Center(
            child: Text(
              'Rewards',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFF2D9BB)),
            ),
          ),
          const SizedBox(height: 16),
          ..._rewards.map((reward) {
            return RewardItem(
              name: reward['name'] as String,
              cost: reward['cost'] as int,
              onTap: _saving ? null : () => _confirmRedeem(reward['name'] as String, reward['cost'] as int),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class RewardItem extends StatelessWidget {
  final String name;
  final int cost;
  final VoidCallback? onTap;

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
        color: const Color(0xFFF2D9BB),
        border: Border.all(color: const Color(0xFF6FC1A1), width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.green.withOpacity(0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: const TextStyle(fontSize: 16)),
            Text('$cost ●', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
