import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'signup_page.dart';
import 'list.dart';

const String apiBaseUrl = 'http://127.0.0.1:8000/api';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  bool loading = false;
  String error = '';

  Future<void> signin() async {
    setState(() {
      loading = true;
      error = '';
    });

    final response = await http.post(
      Uri.parse('$apiBaseUrl/signin'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'email': emailController.text,
        'password': passwordController.text,
      }),
    );

    setState(() {
      loading = false;
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Response body: $data');

      final userId = data['user']?['id'];
      final token = data['token'];

      if (userId != null && token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('id', userId);
        await prefs.setString('token', token);
        await prefs.setString('token', data['token']);
      } else {
        print('User ID atau token tidak ditemukan');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login berhasil')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TodoListPage()),
      );
    } else {
      final data = jsonDecode(response.body);
      setState(() {
        error = data['message'] ?? 'Login gagal';
      });
    }
  }



 @override
    Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;

        return Scaffold(
            backgroundColor: const Color(0xFF0E2148),
            body: Center(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Container(
                width: isWideScreen ? 400 : double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white12),
                    boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                    ),
                    ],
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                    const Text(
                        'login',
                        style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE3D095),
                        ),
                        textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    if (error.isNotEmpty)
                        Text(
                        error,
                        style: const TextStyle(color: Colors.redAccent),
                        textAlign: TextAlign.center,
                        ),
                    const SizedBox(height: 16),
                    TextField(
                        controller: emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email, color: Color(0xFFE3D095)),
                        labelText: 'Email',
                        labelStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: const Color(0xFF483AA0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                        ),
                        ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                        controller: passwordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock, color: Color(0xFFE3D095)),
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: const Color(0xFF483AA0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                        ),
                        ),
                    ),
                    const SizedBox(height: 24),
                    loading
                        ? const Center(child: CircularProgressIndicator(color: Color(0xFFE3D095)))
                        : ElevatedButton(
                            onPressed: signin,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE3D095),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                                ),
                            ),
                            child: const Text(
                                'Sign In',
                                style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF0E2148),
                                fontWeight: FontWeight.bold,
                                ),
                            ),
                            ),
                    const SizedBox(height: 16),
                    TextButton(
                        onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const SignUpPage()),
                        );
                        },
                        child: const Text(
                        'Belum punya akun? Daftar',
                        style: TextStyle(color: Colors.white70),
                        ),
                    ),
                    ],
                ),
                ),
            ),
            ),
        );
    }
}

