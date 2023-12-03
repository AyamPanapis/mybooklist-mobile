import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const RegisterApp());
}

class RegisterApp extends StatelessWidget {
  const RegisterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<_RegisterPageState> _registerPageKey = GlobalKey();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                String username = _usernameController.text;
                String password = _passwordController.text;

                // Validate username and password
                if (username.isEmpty || password.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Registration Failed'),
                      content:
                          const Text('Username and password are required.'),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                  return;
                }

                // Send registration request to Django backend
                final response = await http.post(
                  Uri.parse('http://127.0.0.1:8000/auth/register_flutter/'),
                  body: {
                    'username': username,
                    'password': password,
                  },
                );

                if (response.statusCode == 200) {
                  // Registration successful
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Registration Successful'),
                      content: const Text(
                          'Your account has been successfully created!'),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  // Registration failed
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Registration Failed'),
                      content: Text('Error: ${response.body}'),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                            _registerPageKey.currentState?.reloadPage();
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  void reloadPage() {
    setState(() {}); // Trigger a rebuild of the widget
  }
}
