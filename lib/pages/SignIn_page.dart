import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF3B5F41);
    const Color creamColor = Color(0xFFF2D9BB);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        iconTheme: const IconThemeData(
          color: Color(0xFFF2D9BB),
        ),
      ),
      backgroundColor: primaryGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/WasteBin.png',
                  width: 200,
                  height: 200,
                  color: creamColor,
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'WASTEPOINT',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF2D9BB),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'SIGN IN',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF2D9BB),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Please Sign In to Continue.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFF2D9BB),
                ),
              ),
              const SizedBox(height: 24),

              Container(
                decoration: BoxDecoration(
                  color: creamColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(color: Color(0xFF3B5F41)),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person, color: Color(0xFF3B5F41)),
                    contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: creamColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Color(0xFF3B5F41)),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF3B5F41)),
                    contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: creamColor,
                    foregroundColor: primaryGreen,
                    textStyle: const TextStyle(fontSize: 16),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/main');
                  },
                  child: const Text('SIGN IN',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  'Register new account',
                  style: TextStyle(
                    color: Color(0xFFF2D9BB),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
