import 'package:ecommerce/screen/authentication/login.dart';
import 'package:ecommerce/screen/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../components/snackBar.dart';
import '../../components/textField.dart';
import '../../components/webView.dart';
import '../../constant/auth.dart';
import '../../constant/splash.dart';
import '../../providers/auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Image.asset(
                tSplashTopIcon,
                height: 120,
              ),
              const SizedBox(height: 20),


              CustomTextField(
                controller: emailController,
                label: 'Email',
                isPasswordField: false,
                validator: Validators.validateEmail,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Ex- abc@gmail.com'),
              ),

              const SizedBox(height: 10),


              CustomTextField(
                controller: passwordController,
                label: 'Password',
                isPasswordField: true,
                validator: Validators.validatePassword,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Ex- abc123vff'),
              ),

              const SizedBox(height: 10),


              CustomTextField(
                controller: confirmPasswordController,
                label: 'Confirm Password',
                isPasswordField: true,
                validator: Validators.validatePassword,
              ),

              const SizedBox(height: 20),


              Row(
                children: [
                  Checkbox(
                    value: isTermsAccepted,
                    onChanged: (value) {
                      setState(() {
                        isTermsAccepted = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const Text(
                          'I accept the ',
                          style: TextStyle(fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CustomWebView(
                                  url: "https://en.wikipedia.org",
                                  title: "Terms and Conditions",
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Terms and Conditions',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const Text('.', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {

                      if(emailController.text.trim()=='' || passwordController.text.trim()=='')
                        {
                          showSnackBar(context, "Please filled the value");
                          return;
                        }

                      if (!isTermsAccepted) {
                        showSnackBar(context, "Please accept the terms and conditions.");
                        return;
                      }

                      if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
                        showSnackBar(context, "Passwords do not match.");
                        return;
                      }

                      try {
                        await authProvider.signup(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const Layout()),
                        );
                      } catch (e) {
                        showSnackBar(context, e.toString());
                      }
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),

              const SizedBox(height: 10),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: const Text('Have an account? Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


