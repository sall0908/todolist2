import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'create.dart';
import 'edit.dart';
import 'signin_page.dart'; // Pastikan ada halaman SignInPage

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List todos = [];
  bool isLoading = false;

  Future<void> fetchTodos() async {
    setState(() => isLoading = true);

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      print('Token tidak ditemukan, user belum login.');
      if (!mounted) return;
      setState(() => isLoading = false);
      return;
    }

    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/todos'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      if (!mounted) return;
      setState(() => todos = jsonDecode(response.body));
    } else {
      print('Gagal fetch todos: ${response.statusCode} - ${response.body}');
    }

    if (!mounted) return;
    setState(() => isLoading = false);
  }

  Future<void> deleteTodo(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      print('Token tidak ditemukan, user belum login.');
      return;
    }

    final response = await http.delete(
      Uri.parse('http://127.0.0.1:8000/api/todos/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('DELETE status: ${response.statusCode}');
    print('DELETE response: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 204) {
      if (!mounted) return;
      fetchTodos();
    } else {
      print('Gagal menghapus: ${response.statusCode}');
    }
  }

  Future<void> toggleIsDone(int id, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      print('Token tidak ditemukan, user belum login.');
      return;
    }

    final response = await http.put(
      Uri.parse('http://127.0.0.1:8000/api/edit/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'selesai': value}),
    );
    print('Update response status: ${response.statusCode}');
    print('Update response body: ${response.body}');
    if (response.statusCode == 200) {
      if (!mounted) return;
      fetchTodos(); // Refresh data
    } else {
      print('Gagal update is_done: ${response.body}');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SignInPage()),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

 @override
    Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF102C57),
        appBar: AppBar(
        backgroundColor: const Color(0xFF1C3A6F),
        title: Row(
            children: [
            PopupMenuButton<String>(
                icon: const Icon(Icons.menu, color: Colors.white),
                onSelected: (value) {
                if (value == 'logout') logout();
                },
                itemBuilder: (context) => [
                const PopupMenuItem(value: 'logout', child: Text('Logout')),
                ],
            ),
            const SizedBox(width: 8),
            const Text(
                'To-Do List',
                style: TextStyle(color: Colors.white),
            ),
            ],
        ),
        ),
        body: isLoading
        ? const Center(child: CircularProgressIndicator(color: Colors.white))
        : ListView.builder(
            itemCount: todos.length,
            itemBuilder: (_, i) {
            final item = todos[i];
            final isDone = item['selesai'] == 1 || item['selesai'] == true;
            return Center(
                child: Container(
                width: 450,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                    ),
                    ],
                ),
                child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    leading: Checkbox(
                    value: isDone,
                    onChanged: (val) {
                        if (val != null) toggleIsDone(item['id_todo'], val);
                    },
                    activeColor: Colors.white,
                    checkColor: const Color(0xFF102C57),
                    ),
                    title: Text(
                    '${item['list'] ?? ''} | ${item['status'] ?? ''}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                    ),
                    ),
                    subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(item['tanggal'], style: const TextStyle(color: Colors.white70)),
                        if (isDone)
                        const Text(
                            'SELESAI',
                            style: TextStyle(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold,
                            ),
                        ),
                    ],
                    ),
                    trailing: Wrap(
                    spacing: 4,
                    children: [
                        IconButton(
                        icon: const Icon(Icons.description, color: Colors.white),
                        tooltip: 'Deskripsi',
                        onPressed: () {
                            showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                title: const Text('Deskripsi'),
                                content: Text(item['deskripsi'] ?? 'Tidak ada deskripsi'),
                                actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Tutup'),
                                ),
                                ],
                            ),
                            );
                        },
                        ),
                        IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () async {
                            final updated = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => EditTodoPage(
                                todo: item,
                                id: item['id_todo'],
                                ),
                            ),
                            );
                            if (updated == true) fetchTodos();
                        },
                        ),
                        IconButton(
                        icon: const Icon(Icons.delete, color: Colors.white),
                        onPressed: () => deleteTodo(item['id_todo']),
                        ),
                    ],
                    ),
                ),
                ),
            );
            },
        ),

            floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFFE3D095),
            shape: const CircleBorder(),
            onPressed: () async {
                final created = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const CreateTodoPage(),
                ),
                );
                if (created == true) fetchTodos();
            },
            child: const Icon(Icons.add, color: Color(0xFF102C57)),
            ),
        );
    }
}
