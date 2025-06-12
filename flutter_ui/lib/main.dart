import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'signin_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Laravel Auth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFA5D6A7), // Light green seed
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFE8F5E9), // Light green background
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFA5D6A7), // AppBar green
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF388E3C), // Darker green button
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFC8E6C9), // Input field green
          labelStyle: const TextStyle(color: Colors.black54),
          floatingLabelStyle: const TextStyle(color: Color(0xFF388E3C)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF388E3C)),
          ),
        ),
        textTheme: GoogleFonts.nunitoTextTheme(), // Global Nunito font
      ),
      home: const SignInPage(),
    );
  }
}
