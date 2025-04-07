import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _vibrateOn = true;
  bool _beepOn = false;

  @override
  Widget build(BuildContext context) {
    const Color backgroundGreen = Color(0xFF3B5F41);
    const Color darkBlock = Color(0xFF2C2C2C);
    const Color creamText = Color(0xFFF2D9BB);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting',
        style: TextStyle(
            color: Color(0xFFF2D9BB),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: backgroundGreen,
        iconTheme: const IconThemeData(
          color: Color(0xFFF2D9BB),
        ),
      ),
      body: Stack(
        children: [
          Container(color: backgroundGreen),

          ListView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            children: [
              _buildSwitchTile(
                icon: Icons.vibration,
                title: 'Vibrate',
                subtitle: 'Vibration when scan is done.',
                value: _vibrateOn,
                onChanged: (val) {
                  setState(() {
                    _vibrateOn = val;
                  });
                },
              ),

              _buildSwitchTile(
                icon: Icons.volume_off,
                title: 'Beep',
                subtitle: 'Beep when scan is done.',
                value: _beepOn,
                onChanged: (val) {
                  setState(() {
                    _beepOn = val;
                  });
                },
              ),

              _buildSettingTile(
                icon: Icons.star_rate,
                title: 'Rate Us',
                subtitle: 'Your best reward to us.',
              ),

              _buildSettingTile(
                icon: Icons.privacy_tip,
                title: 'Privacy Policy',
                subtitle: 'Follow our policies that benefits you.',
              ),

              _buildSettingTile(
                icon: Icons.share,
                title: 'Share',
                subtitle: 'Share app with others.',
              ),
            ],
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
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFF2D9BB)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFFF2D9BB),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFFF2D9BB),
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
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFF2D9BB)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFFF2D9BB),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
