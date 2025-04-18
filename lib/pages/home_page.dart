import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/user.dart';
import '../services/firestore_service.dart';
import 'scan_page.dart';
import 'redeem_page.dart';

class MainPage extends StatefulWidget {
  final String userId;
  const MainPage({required this.userId, super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeView(userId: widget.userId),
      ScanPage(userId: widget.userId),
      RedeemPage(userId: widget.userId),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'WastePoint',
          style: TextStyle(
            color: Color(0xFFF2D9BB),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF3B5F41),
        iconTheme: const IconThemeData(color: Color(0xFFF2D9BB)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0xFFF2D9BB)),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/setting',
                arguments: widget.userId,
              );
            },
          ),
        ],
      ),
      body: pages[_currentIndex],
      backgroundColor: const Color(0xFF3B5F41),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        backgroundColor: const Color(0xFFF2D9BB),
        selectedItemColor: const Color(0xFF445D44),
        unselectedItemColor: Colors.grey[600],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Redeem'),
        ],
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  final String userId;
  const HomeView({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: FirestoreService().getUserById(userId),
      builder: (ctx, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        final user = snap.data;
        if (user == null) {
          return const Center(
            child: Text('User not found', style: TextStyle(color: Colors.white)),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Image.asset('assets/images/Profile.png', width: 75, height: 75),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.username,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF2D9BB),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.mobileNumber,
                        style: const TextStyle(fontSize: 14, color: Color(0xFFF2D9BB)),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2D9BB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user.savedCarbon}g',
                            style: const TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF445D44),
                            ),
                          ),
                          const Text(
                            'saved Carbon',
                            style: TextStyle(fontSize: 16, color: Color(0xFF445D44)),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${user.points} points',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF445D44),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${user.recycledAmount} recycled',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF445D44),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'nearby bin stations',
                  style: TextStyle(fontSize: 16, color: Color(0xFFF2D9BB)),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(13.7563, 100.5018),
                    zoom: 13,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 30,
                          height: 30,
                          point: LatLng(13.7563, 100.5018),
                          builder: (_) => const Icon(Icons.location_on, color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF2D9BB),
                  foregroundColor: const Color(0xFF445D44),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/point', arguments: userId);
                },
                child: const Text(
                  'My Points',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF2D9BB),
                  foregroundColor: const Color(0xFF445D44),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/contents', arguments: userId);
                },
                child: const Text(
                  'Our Contents',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
