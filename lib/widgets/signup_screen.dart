import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // TODO: 1. Deklarasikan Variabel
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorText = '';
  bool _obscurePassword = true;

  // TODO: 10. Membuat fungsi _signup
  void _signup() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String name = _fullNameController.text.trim();
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (password.length < 8 ||
        !password.contains(RegExp(r'[A-Z]')) ||
        !password.contains(RegExp(r'[a-z]')) ||
        !password.contains(RegExp(r'[0-9]')) ||
        !password.contains(RegExp(r'[@#$%^&*(),.?"!:{}|<>]'))) {
      setState(() {
        _errorText =
            'Minimal 8 karakter, kombinasi [A-Z], [a-z], [0-9], [!@#\\\$%^&*(),.?":{}|<>]';
      });
      return;
    }
    if (name.isNotEmpty && username.isNotEmpty && password.isNotEmpty) {
      final encrypt.Key key = encrypt.Key.fromLength(32);
      final iv = encrypt.IV.fromLength(16);

      final encrypter = encrypt.Encrypter(encrypt.AES(key));
      final encryptedName = encrypter.encrypt(name, iv: iv);
      final encryptedUsername = encrypter.encrypt(username, iv: iv);
      final encryptedPassword = encrypter.encrypt(password, iv: iv);

      prefs.setString("fullname", encryptedName.base64);
      prefs.setString("username", encryptedUsername.base64);
      prefs.setString("password", encryptedPassword.base64);
      prefs.setString("key", key.base64);
      prefs.setString("iv", iv.base64);
    }
    // print("*** Sign up Berhasil!");
    // print("Nama : $name");
    // print("Nama penggguna : $username");
    // print("Password : $password");

    Navigator.pushReplacementNamed(context, "/signin");
  }

  // TODO: 11. Membuat fungsi dispose
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: 2. Pasang Appbar
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      // TODO: 3. Pasang body
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: Column(
                // TODO 4. Atur Main Axis Alignment dan Cross Axis Alignment
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // TODO 5. Pasang TextFormField Nama Lengkap
                  TextFormField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(
                        labelText: "Nama Lengkap",
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // TODO 6. Pasang TextFormField Nama Pengguna
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                        labelText: "Nama Pengguna",
                        border: OutlineInputBorder()),
                  ),
                  // TODO 7. Pasang TextFormField Kata Sandi
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        labelText: "Kata Sandi",
                        errorText: _errorText.isNotEmpty ? _errorText : null,
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          icon: Icon(_obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        )),
                    obscureText: _obscurePassword,
                  ),

                  // TODO 8. Pasang Elevated Button Signed Up
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: _signup, child: const Text("Sign Up")),
                  // TODO 9. Pasang TextButton Sign Up
                  const SizedBox(height: 10),
                  // TextButton(
                  //     onPressed: () {},
                  //     child: const Text("Belum Punya Akun? Daftar Disini")),
                  RichText(
                      text: TextSpan(
                          text: "Sudah Punya Akun? ",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.deepPurple),
                          children: <TextSpan>[
                        TextSpan(
                          text: "Login Disini",
                          style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontSize: 16),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        )
                      ]))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
