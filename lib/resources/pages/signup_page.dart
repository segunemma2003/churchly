import 'package:flutter/material.dart';
import 'package:flutter_app/resources/pages/base_navigation_hub.dart';
import 'package:flutter_app/resources/pages/signin_page.dart';
import 'package:flutter_app/resources/pages/terms_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

class SignupPage extends NyStatefulWidget {
  static RouteView path = ("/signup", (_) => SignupPage());

  SignupPage({super.key}) : super(child: () => _SignupPageState());
}

class _SignupPageState extends NyPage<SignupPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;

  @override
  get init => () {
        // Initialize any controllers or state here
      };

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image taking up half the screen
          Column(
            children: [
              // Top half with image
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('bg.jpg').localAsset(),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withValues(alpha: .6),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                      child: Row(
                        children: [
                          // Logo - Moved higher with custom widget
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.church,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "Churchly",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Bottom half (empty as we'll overlay the form)
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ],
          ),

          // Form as a bottom sheet
          DraggableScrollableSheet(
            initialChildSize: 0.65, // Form takes up about 65% of screen
            minChildSize: 0.65, // Prevent dragging below this point
            maxChildSize: 0.9, // Allow dragging up to 90% of screen
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Get Started header
                        Center(
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(
                                  0xFF002951), // Dark blue color like in the image
                            ),
                          ),
                        ),
                        SizedBox(height: 24),

                        // Full Name
                        _buildLabel("Full Name"),
                        _buildTextField(
                          controller: _fullNameController,
                          hintText: "Your full name",
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                        ),
                        SizedBox(height: 16),

                        // Email
                        _buildLabel("Email"),
                        _buildTextField(
                          controller: _emailController,
                          hintText: "Enter email address",
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 16),

                        // Password
                        _buildLabel("Password"),
                        _buildTextField(
                          controller: _passwordController,
                          hintText: "Create a password",
                          obscureText: _obscurePassword,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            child: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Confirm Password
                        _buildLabel("Confirm Password"),
                        _buildTextField(
                          controller: _confirmPasswordController,
                          hintText: "Enter password",
                          obscureText: _obscureConfirmPassword,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                            child: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Terms and Conditions
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                value: _agreeToTerms,
                                onChanged: (value) {
                                  setState(() {
                                    _agreeToTerms = value ?? false;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Wrap(
                                children: [
                                  Text(
                                    "I have read and agree the ",
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to terms and conditions
                                      routeTo(TermsPage.path);
                                    },
                                    child: Text(
                                      "Terms and Conditions",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),

                        // Sign Up Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(
                                0xFF0E2B51), // Dark navy blue like in the image
                            foregroundColor: Colors.white,
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            if (!_agreeToTerms) {
                              _showToast(
                                  "Please agree to the terms and conditions");
                              return;
                            }

                            // Implement sign up logic
                            if (_fullNameController.text.isEmpty ||
                                _emailController.text.isEmpty ||
                                _passwordController.text.isEmpty ||
                                _confirmPasswordController.text.isEmpty) {
                              _showToast("Please fill in all fields");
                              return;
                            }

                            if (_passwordController.text !=
                                _confirmPasswordController.text) {
                              _showToast("Passwords do not match");
                              return;
                            }
                            routeTo(BaseNavigationHub.path);
                            // Process sign up
                            // You would typically use an auth service here
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        SizedBox(height: 16),
                        Center(
                          child: Text(
                            "Or sign up with",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Google Sign Up
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                            side: BorderSide(color: Colors.grey[300]!),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            // Implement Google sign up
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'devicon_google.png', // Local Google icon
                                height: 24,
                                width: 24,
                              ).localAsset(),
                            ],
                          ),
                        ),

                        SizedBox(height: 24),

                        // Sign in option
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already Have an Account?",
                                style: TextStyle(fontSize: 13),
                              ),
                              SizedBox(width: 4),
                              GestureDetector(
                                onTap: () {
                                  // Navigate to sign in page
                                  routeTo(SigninPage.path);
                                },
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13, // Reduced font size
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        style: TextStyle(fontSize: 14), // Reduced font size
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle:
              TextStyle(color: Colors.grey, fontSize: 14), // Reduced font size
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
