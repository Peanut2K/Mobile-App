import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/firestore_service.dart';

class SettingPage extends StatefulWidget {
  final String userId;
  const SettingPage({required this.userId, super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _fs = FirestoreService();
  bool _loading = true;
  bool _saving  = false;

  late UserModel _user;
  late bool _vibrateOn;
  late bool _beepOn;

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
      _user      = u;
      _vibrateOn = u.vibrate;
      _beepOn    = u.beeb;
      _loading   = false;
    });
  }

  Future<void> _updateSettings({bool? vibrate, bool? beeb}) async {
    setState(() => _saving = true);
    final updated = UserModel(
      id:            _user.id,
      username:      _user.username,
      mobileNumber:  _user.mobileNumber,
      password:      _user.password,
      points:        _user.points,
      recycledAmount:_user.recycledAmount,
      savedCarbon:   _user.savedCarbon,
      savedPlastic:  _user.savedPlastic,
      savedPaper:    _user.savedPaper,
      vibrate:       vibrate ?? _user.vibrate,
      beeb:          beeb    ?? _user.beeb,
    );
    try {
      await _fs.updateUser(updated);
      setState(() {
        _user      = updated;
        _vibrateOn = updated.vibrate;
        _beepOn    = updated.beeb;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Save failed: $e')),
      );
    } finally {
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const backgroundGreen = Color(0xFF3B5F41);
    const darkBlock       = Color(0xFF2C2C2C);
    const creamText       = Color(0xFFF2D9BB);

    if (_loading) {
      return const Scaffold(
        backgroundColor: backgroundGreen,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Settings',
          style: TextStyle(color: creamText, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: backgroundGreen,
        iconTheme: const IconThemeData(color: creamText),
      ),
      body: Stack(
        children: [
          Container(color: backgroundGreen),
          ListView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            children: [
              // Switch tiles…
              _buildSwitchTile(
                icon: Icons.vibration,
                title: 'Vibrate',
                subtitle: 'Vibration when scan is done.',
                value: _vibrateOn,
                onChanged: _saving ? null : (v) => _updateSettings(vibrate: v),
              ),
              _buildSwitchTile(
                icon: Icons.volume_up,
                title: 'Beep',
                subtitle: 'Beep when scan is done.',
                value: _beepOn,
                onChanged: _saving ? null : (b) => _updateSettings(beeb: b),
              ),
              const SizedBox(height: 24),
              _buildSettingTile(
                icon: Icons.star_rate,
                title: 'Rate Us',
                subtitle: 'Your best reward to us.',
                onTap: () {/* … */},
              ),
              _buildSettingTile(
                icon: Icons.privacy_tip,
                title: 'Privacy Policy',
                subtitle: 'Follow our policies that benefit you.',
                onTap: () {/* … */},
              ),
              _buildSettingTile(
                icon: Icons.share,
                title: 'Share',
                subtitle: 'Share app with others.',
                onTap: () {/* … */},
              ),

              const SizedBox(height: 32),

              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(color: darkBlock, borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: _saving
                      ? null
                      : () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/first',
                            (route) => false,
                          );
                        },
                  child: Row(
                    children: const [
                      Icon(Icons.exit_to_app, color: Colors.red),
                      SizedBox(width: 12),
                      Text(
                        'Sign out',
                        style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (_saving)
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool>? onChanged,
  }) {
    const darkBlock = Color(0xFF2C2C2C);
    const creamText = Color(0xFFF2D9BB);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: darkBlock, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(icon, color: creamText),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: creamText, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(color: Colors.grey[400], fontSize: 14)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: creamText,
            activeTrackColor: Colors.amber[600],
            inactiveThumbColor: Colors.grey[400],
            inactiveTrackColor: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    const darkBlock = Color(0xFF2C2C2C);
    const creamText = Color(0xFFF2D9BB);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(color: darkBlock, borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: creamText),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: creamText, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
