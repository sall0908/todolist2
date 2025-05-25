import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({super.key});

  @override
  State<CreateTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  final listController = TextEditingController();
  final dateController = TextEditingController();
  final descriptionController = TextEditingController();

  int? userId;
  String status = 'low';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadUserId();
  }

  Future<void> loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId');
    });
  }

  Future<void> createTodo() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User belum login')),
      );
      return;
    }

    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/todos'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'list': listController.text,
        'tanggal': dateController.text,
        'deskripsi': descriptionController.text,
        'status': status,
        'id_users': userId,
      }),
    );

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 201) {
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double maxWidth = 400;
    final double maxHeight = MediaQuery.of(context).size.height * 0.9;

    return Scaffold(
      backgroundColor: const Color(0xFF0E2148),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E2148),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: maxWidth,
            constraints: BoxConstraints(maxHeight: maxHeight),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
              border: Border.all(color: Colors.white24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Tambahkan List',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE3D095),
                  ),
                ),
                const SizedBox(height: 24),

                // Input List
                TextField(
                  controller: listController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration('List', Icons.list),
                ),
                const SizedBox(height: 16),

                // Input Tanggal
                TextField(
                  controller: dateController,
                  readOnly: true,
                  style: const TextStyle(color: Colors.white),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        dateController.text = pickedDate.toIso8601String().split('T')[0];
                      });
                    }
                  },
                  decoration: _inputDecoration('Tanggal', Icons.calendar_today),
                ),
                const SizedBox(height: 16),

                // Input Deskripsi
                TextField(
                  controller: descriptionController,
                  maxLines: 4,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration('Deskripsi', Icons.description),
                ),
                const SizedBox(height: 16),

                // Dropdown Prioritas
                const Text(
                  'Prioritas',
                  style: TextStyle(
                    color: Color(0xFFE3D095),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: DropdownButton<String>(
                    value: status,
                    isExpanded: true,
                    underline: Container(),
                    dropdownColor: const Color(0xFF483AA0),
                    style: const TextStyle(color: Colors.white),
                    iconEnabledColor: const Color(0xFFE3D095),
                    onChanged: (val) => setState(() => status = val!),
                    items: ['low', 'medium', 'high']
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e, style: const TextStyle(color: Colors.white)),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 24),

                // Tombol Submit
                ElevatedButton(
                  onPressed: createTodo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE3D095),
                    foregroundColor: const Color(0xFF0E2148),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      floatingLabelStyle: const TextStyle(color: Color(0xFFE3D095)),
      prefixIcon: Icon(icon, color: const Color(0xFFE3D095)),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE3D095)),
      ),
    );
  }
}
