import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF3B5F41);
    const Color creamColor = Color(0xFFF2D9BB);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: primaryGreen,
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/WasteBin.png',
              width: 250,
              height: 250,
            ),
            const SizedBox(height: 24),

            const Text(
              'WASTEPOINT',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF2D9BB),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'TURN TRASH INTO TREASURE!',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFF2D9BB),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: creamColor, 
                  foregroundColor: primaryGreen,
                  textStyle: const TextStyle(fontSize: 18),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Register',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: creamColor, width: 2),
                  foregroundColor: creamColor,
                  textStyle: const TextStyle(fontSize: 18),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/signin');
                },
                child: const Text('LOG IN',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
