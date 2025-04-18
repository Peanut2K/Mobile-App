import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/user.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _loading = false;
  final _fs = FirestoreService();

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _showErrorDialog(String message) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('❌ Sign In Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _signIn() async {
    final username = _usernameCtrl.text.trim();
    final password = _passwordCtrl.text;

    if (username.isEmpty || password.isEmpty) {
      await _showErrorDialog('Please enter both username and password.');
      return;
    }

    setState(() => _loading = true);

    try {
      final user = await _fs.signIn(username, password);
      if (user == null) {
        await _showErrorDialog('Invalid credentials. Please try again.');
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            title: const Text('✅ Login Successful'),
            content: Text('Welcome back, ${user.username}!'),
          ),
        );
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) {
          Navigator.of(context).pop(); // close the dialog
          Navigator.pushReplacementNamed(
            context,
            '/main',
            arguments: user.id,
          );
        }
      }
    } catch (e) {
      await _showErrorDialog('An error occurred: ${e.toString()}');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF3B5F41);
    const creamColor   = Color(0xFFF2D9BB);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        iconTheme: const IconThemeData(color: creamColor),
      ),
      backgroundColor: primaryGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                  color: creamColor,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'SIGN IN',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: creamColor,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Please sign in to continue.',
                style: TextStyle(fontSize: 14, color: creamColor),
              ),
              const SizedBox(height: 24),

              _buildTextField(
                controller: _usernameCtrl,
                hintText: 'Username',
                icon: Icons.person,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: _passwordCtrl,
                hintText: 'Password',
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: creamColor,
                    foregroundColor: primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: _loading ? null : _signIn,
                  child: _loading
                      ? const CircularProgressIndicator(color: primaryGreen)
                      : const Text(
                          'SIGN IN',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              const SizedBox(height: 16),

              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: const Text(
                  'Register new account',
                  style: TextStyle(color: Color(0xFFF2D9BB)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    const primaryGreen = Color(0xFF3B5F41);
    const creamColor   = Color(0xFFF2D9BB);

    return Container(
      decoration: BoxDecoration(
        color: creamColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: primaryGreen),
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: primaryGreen),
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        ),
      ),
    );
  }
}
