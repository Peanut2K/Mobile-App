import 'package:flutter/material.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF445D44),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              color: Colors.orange,
              child: const Center(
                child: Text('QR Code Scanner', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Plastic bottle'),
            const Text('savedCarbon: 6g | reward: 3 points'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/point');
              },
              child: const Text('DROP OFF !'),
            ),
          ],
        ),
      ),
    );
  }
}
