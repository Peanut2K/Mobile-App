import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/firestore_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameCtrl = TextEditingController();
  final _mobileCtrl   = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool  _loading      = false;
  final _fs = FirestoreService();

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _mobileCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _showErrorDialog(String message) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Registration Failed'),
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

  Future<void> _showSuccessDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('✅ Registration Successful'),
        content: const Text(
          'Your account has been created successfully. Please log in to continue.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // close dialog
              Navigator.pushReplacementNamed(context, '/signin');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _register() async {
    final username = _usernameCtrl.text.trim();
    final mobile   = _mobileCtrl.text.trim();
    final password = _passwordCtrl.text;

    if (username.isEmpty || mobile.isEmpty || password.isEmpty) {
      await _showErrorDialog('Please fill in all fields.');
      return;
    }

    setState(() => _loading = true);

    try {
      final newUser = UserModel(
        id: '',
        username: username,
        mobileNumber: mobile,
        password: password,
        points: 0,
        recycledAmount: 0,
        savedCarbon: 0,
        savedPlastic: 0,
        savedPaper: 0,
      );

      final createdId = await _fs.createUser(newUser);
  
      await _showSuccessDialog();
    } catch (e) {
      await _showErrorDialog(
        e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      setState(() => _loading = false);
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset(
                'assets/images/WasteBin.png',
                width: 200,
                height: 200,
                color: creamColor,
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
                'REGISTER',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: creamColor,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Please register to continue.',
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
                controller: _mobileCtrl,
                hintText: 'Mobile Number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
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
                  onPressed: _loading ? null : _register,
                  child: _loading
                      ? const CircularProgressIndicator(color: primaryGreen)
                      : const Text(
                          'REGISTER',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        ),
      ),
    );
  }
}
