import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/snackBar.dart';
import '../../components/textField.dart';
import '../../constant/auth.dart';
import '../../providers/auth.dart';
import '../layout.dart';
import 'signup.dart';
import '../../constant/splash.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(tSplashTopIcon),
                const SizedBox(height: 20),

                // Email TextField
                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  isPasswordField: false, // Non-password field
                  validator: Validators.validateEmail,
                ),

                const SizedBox(height: 16),

                // Password TextField
                CustomTextField(
                  controller: _passwordController,
                  label: 'Password',
                  isPasswordField: true, // Password field
                  validator: Validators.validatePassword,
                ),

                const SizedBox(height: 24),

                // Login Button
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await authProvider.login(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => Layout()),
                      );
                    } catch (e) {
                      showSnackBar(context,e.toString());
                    }
                  },
                  child: const Text('Login'),
                ),

                // Redirect to SignUp page
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => SignupScreen()),
                    );
                  },
                  child: const Text("Don't have an account? Sign up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
