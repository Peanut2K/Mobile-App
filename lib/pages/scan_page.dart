import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../models/user.dart';
import '../services/firestore_service.dart';

class ScanPage extends StatefulWidget {
  final String userId;
  const ScanPage({required this.userId, Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final _fs = FirestoreService();
  UserModel? _user;
  bool _loadingUser = true;
  String? _scanResult;

  static const int _rewardPoints = 3;
  static const int _rewardCarbon = 6;
  static const bool _isPlastic  = true;

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

  Future<void> _onDropOff() async {
    if (_user == null) return;

    // bump counts (as doubles)
    final newPlastic = _user!.savedPlastic + (_isPlastic ? 1.0 : 0.0);
    final newPaper   = _user!.savedPaper   + (_isPlastic ? 0.0 : 1.0);

    final updated = UserModel(
      id:             _user!.id,
      username:       _user!.username,
      mobileNumber:   _user!.mobileNumber,
      password:       _user!.password,
      points:         _user!.points + _rewardPoints,
      recycledAmount: _user!.recycledAmount + 1,
      savedCarbon:    _user!.savedCarbon + _rewardCarbon.toDouble(),
      savedPlastic:   newPlastic,
      savedPaper:     newPaper,
      vibrate:        _user!.vibrate,
      beeb:           _user!.beeb,
    );

    await _fs.updateUser(updated);
    setState(() => _user = updated);

    // success dialog
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.green.shade50,
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 32),
            const SizedBox(width: 8),
            const Text('Success!', style: TextStyle(color: Colors.green)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('You earned $_rewardPoints points!', style: const TextStyle(fontSize: 16)),
            Text('Saved $_rewardCarbon g carbon.', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            const Text('Thank you for helping the planet!'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/main',
                (route) => false,
                arguments: widget.userId,
              );
            },
            child: const Text('OK', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const darkGreen   = Color(0xFF445D44);
    const creamColor  = Color(0xFFF2D9BB);
    const cardBgColor = Color(0xFFFFEBCD);

    if (_loadingUser) {
      return const Scaffold(
        backgroundColor: darkGreen,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: darkGreen,
      body: Stack(
        children: [
          Container(color: darkGreen),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Scanner
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: creamColor,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Stack(
                      children: [
                        MobileScanner(
                          onDetect: (capture) {
                            final code = capture.barcodes.isNotEmpty
                                ? capture.barcodes.first.rawValue
                                : null;
                            if (code != null && code != _scanResult) {
                              setState(() => _scanResult = code);
                            }
                          },
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            color: Colors.black54,
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              _scanResult == null
                                  ? 'Scanning...'
                                  : 'Result: $_scanResult',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                const Text(
                  'Position your QR code between the guide lines',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),

                const SizedBox(height: 16),
                // Info + drop‑off
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardBgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Plastic bottle',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.autorenew, color: Colors.green[700]),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            InfoItem(label: 'Saved Carbon', value: '6g'),
                            InfoItem(label: 'Material', value: 'Plastic'),
                            InfoItem(label: 'Points',   value: '3'),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding:
                                const EdgeInsets.symmetric(vertical: 14),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: _onDropOff,
                          child: const Text(
                            'DROP OFF',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final String label;
  final String value;
  const InfoItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ],
    );
  }
}
