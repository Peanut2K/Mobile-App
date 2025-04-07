import 'package:flutter/material.dart';
import 'scan_page.dart';
import 'redeem_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final pages = [
    const HomeView(),
    const ScanPage(),
    const RedeemPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'WastePoint',
          style: TextStyle(
            color: Color(0xFFF2D9BB),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF445D44),
        iconTheme: const IconThemeData(
          color: Color(0xFFF2D9BB),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/setting');
            },
            icon: const Icon(
              Icons.settings,
              color: Color(0xFFF2D9BB),
            ),
          ),
        ],
      ),
      body: pages[_currentIndex],

      backgroundColor: const Color(0xFF445D44),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        backgroundColor: const Color(0xFFF2D9BB),
        selectedItemColor: const Color(0xFF445D44),
        unselectedItemColor: Colors.grey[600],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Redeem',
          ),
        ],
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: const Color(0xFF445D44)),

        Positioned(
          top: -80,
          right: -80,
          child: Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              color: Color(0xFF3B5F41),
              shape: BoxShape.circle,
            ),
          ),
        ),

        SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Sapon!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF2D9BB),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Faculty of Information\nand Communication Technology',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFF2D9BB),
                        ),
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2D9BB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '500g',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF445D44),
                            ),
                          ),
                          Text(
                            'saved Carbon',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF445D44),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text(
                          '343 points',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF445D44),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '43 recycled',
                          style: TextStyle(
                            fontSize: 16,
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
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFF2D9BB),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text('Map Placeholder'),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF2D9BB),
                    foregroundColor: const Color(0xFF445D44),
                    textStyle: const TextStyle(fontSize: 16),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/point');
                  },
                  child: const Text('My Points',
                  style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                ),
                ),
              ),

              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF2D9BB),
                    foregroundColor: const Color(0xFF445D44),
                    textStyle: const TextStyle(fontSize: 16),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/contents');
                  },
                  child: const Text('Our Contents',
                  style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
