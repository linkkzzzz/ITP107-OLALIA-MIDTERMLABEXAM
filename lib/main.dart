// =============================================================
// ITP107 Laboratory Examination - Sign-Up Screen
// Nature / Green Theme
// =============================================================
// Requirements covered:
// 1. Working Flutter app displaying a sign-up screen design
// 2. Uses 7+ different basic widgets:
//    Text, Image (Icon-based avatar + decorative leaf art),
//    ListView, Container, Card, ElevatedButton, GestureDetector,
//    Icon, Column, Row, TextField, Stack, Positioned
// 3. GestureDetector on the "Click Me" button handles:
//    - Single Tap  -> prints "Hello World!"
//    - Double Tap  -> prints ITP107 course code + description
//    - Long Press  -> prints full name
// 4. Debug output uses debugPrint() so it is visible in the Debug Console
// 5. Consistent green nature-inspired color scheme, typography, and layout
// =============================================================

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // for debugPrint

void main() {
  runApp(const SignUpApp());
}

// ---------------- Color Palette (Nature / Green Theme) ----------------
class AppColors {
  static const Color darkGreen = Color(0xFF1B4332);
  static const Color midGreen = Color(0xFF2D6A4F);
  static const Color leafGreen = Color(0xFF52B788);
  static const Color mintBackground = Color(0xFFE8F5E9);
  static const Color cream = Color(0xFFF3EFE0);
  static const Color textDark = Color(0xFF1B4332);
}

class SignUpApp extends StatelessWidget {
  const SignUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ITP107 Sign-Up App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.mintBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.midGreen,
          primary: AppColors.midGreen,
          secondary: AppColors.leafGreen,
        ),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.cream,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: AppColors.textDark,
          ),
        ),
      ),
      home: const SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Controllers for the text fields (TextField widget usage)
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Status text shown on screen whenever a gesture is triggered,
  // in addition to the required Debug Console output.
  String _statusMessage = "Tap, double tap, or long press the button below.";

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ---------- Gesture handler methods ----------

  void _handleSingleTap() {
    const message = "Hello World!";
    debugPrint("[SINGLE TAP] $message");
    setState(() {
      _statusMessage = "Single Tap detected -> \"$message\"";
    });
  }

  void _handleDoubleTap() {
    const courseCode = "ITP107";
    const courseDescription =
        "Application Development and Emerging Technologies - "
        "a course focused on building mobile and web applications "
        "using modern frameworks such as Flutter.";
    debugPrint("[DOUBLE TAP] $courseCode - $courseDescription");
    setState(() {
      _statusMessage = "Double Tap detected -> $courseCode course info printed.";
    });
  }

  void _handleLongPress() {
    const fullName = "Juan Miguel Dela Cruz"; // TODO: replace with your full name
    debugPrint("[LONG PRESS] $fullName");
    setState(() {
      _statusMessage = "Long Press detected -> Full name printed.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ---------------- Decorative fern / leaf background ----------------
          _buildLeafDecoration(top: 40, left: -40, rotation: -0.4, size: 220),
          _buildLeafDecoration(top: 40, right: -40, rotation: 0.4, size: 220),
          _buildLeafDecoration(bottom: 60, left: -30, rotation: 0.9, size: 180),
          _buildLeafDecoration(bottom: 200, right: -30, rotation: -0.9, size: 180),

          // ---------------- Main scrollable content ----------------
          ListView(
            padding: EdgeInsets.zero,
            children: [
              // ---------------- Header Section (Container + Image/Icon + Text) ----------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 60, bottom: 40),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.darkGreen, AppColors.leafGreen],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    // Avatar image widget (circular icon badge)
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.cream.withOpacity(0.35),
                      ),
                      child: Center(
                        child: Container(
                          height: 72,
                          width: 72,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.cream,
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 42,
                            color: AppColors.darkGreen,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      "Create Your Account",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ---------------- Sign-Up Form Section (Card + TextField) ----------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 0,
                  color: AppColors.mintBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkGreen,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _nameController,
                          label: "Full Name",
                          icon: Icons.person,
                        ),
                        const SizedBox(height: 14),
                        _buildTextField(
                          controller: _emailController,
                          label: "Email Address",
                          icon: Icons.email,
                        ),
                        const SizedBox(height: 14),
                        _buildTextField(
                          controller: _passwordController,
                          label: "Password",
                          icon: Icons.lock,
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // ---------------- GestureDetector + ElevatedButton Section ----------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _handleSingleTap,
                      onDoubleTap: _handleDoubleTap,
                      onLongPress: _handleLongPress,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.darkGreen, AppColors.midGreen],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.darkGreen.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "Click Me",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    // Status card that reflects the gesture result on-screen
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.cream,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: AppColors.leafGreen.withOpacity(0.4)),
                      ),
                      child: Text(
                        _statusMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.darkGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Additional ElevatedButton widget (real sign-up action)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkGreen,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 3,
                      ),
                      onPressed: () {
                        debugPrint(
                            "[SIGN UP BUTTON] Sign up pressed for: ${_nameController.text}");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Account created!")),
                        );
                      },
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),
            ],
          ),
        ],
      ),
    );
  }

  // Reusable TextField builder to keep the form consistent
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: AppColors.darkGreen),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.darkGreen.withOpacity(0.6)),
        prefixIcon: Icon(icon, color: AppColors.darkGreen),
        filled: true,
        fillColor: AppColors.cream,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }

  // Decorative fern/leaf artwork rendered with a rotated Icon, positioned
  // around the screen edges to echo the nature theme in the reference design.
  Widget _buildLeafDecoration({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double rotation,
    required double size,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: IgnorePointer(
        child: Transform.rotate(
          angle: rotation * math.pi,
          child: Icon(
            Icons.eco,
            size: size,
            color: AppColors.leafGreen.withOpacity(0.12),
          ),
        ),
      ),
    );
  }
}