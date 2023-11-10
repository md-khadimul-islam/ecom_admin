import 'package:ecom_admin/auth/auth_service.dart';
import 'package:ecom_admin/pages/dashboard_screen.dart';
import 'package:ecom_admin/utils/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  String errMsg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 4.0),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email Address',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This filed must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 4.0),
                child: TextFormField(
                  obscureText: isObscure,
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: Icon(isObscure
                            ? Icons.visibility_off
                            : Icons.visibility)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This filed must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20,),
              CustomButton(title: 'LOG IN', onPressed: _logAdmin),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(errMsg, style: const TextStyle( fontSize: 18),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logAdmin() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      EasyLoading.show(status: 'Please wait');
      try {
        final status = await AuthService.loginAdmin(email, password);
        EasyLoading.dismiss();
        if (status) {
          Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
        }else {
          await AuthService.logout();
          setState(() {
            errMsg = 'This email is not associated with an Admin account';
          });
        }
      } on FirebaseAuthException catch (error) {
        EasyLoading.dismiss();
        setState(() {
          errMsg = error.message!;
        });
      }
    }
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
