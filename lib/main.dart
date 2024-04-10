// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import SystemChrome

import 'mainmenu.dart'; // Importing the mainmenu.dart file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    // Set preferred orientation to portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Login Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final List<String> usernames = ['user1', 'user2', 'user3'];
  final List<String> passwords = ['password1', 'password2', 'password3'];

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    int index = usernames.indexOf(username);
    if (index != -1 && passwords[index] == password) {
      // Navigate to success page or perform desired action
      setState(() {
        errorMessage = '';
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SuccessPage()),
      );
    } else {
      setState(() {
        errorMessage = 'Invalid username or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Submit'),
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Call the mainmenu function defined in mainmenu.dart
    mainmenu();
    return Scaffold();
  }
}
