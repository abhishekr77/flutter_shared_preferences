import 'package:flutter/material.dart';

import 'shared_preferences.dart';
import 'validator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserPreferences.init();
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    UserPreferences.hasLogin
                        ? "Hi ${UserPreferences.name}" // Display a welcome message with the user's name if logged in
                        : "Please Login", // Display a login prompt if not logged in
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    controller: _textEditingController,
                    enabled: !UserPreferences.hasLogin, // Disable the text field if already logged in
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Username",
                    ),
                    validator: (value) => Validator.empty(value!),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: UserPreferences.hasLogin
                        ? () async {
                      await UserPreferences.logout(); // Perform logout action and clear user data
                      setState(() {}); // Update the UI after logout
                    }
                        : () async {
                      if (_formKey.currentState!.validate()) {
                        await UserPreferences.setUser(
                            name: _textEditingController.text); // Save the user's name in preferences
                        _textEditingController.clear(); // Clear the text field
                        UserPreferences.setIsLogin(registered: true); // Set login status to true
                        setState(() {}); // Update the UI after successful login
                      }
                    },
                    child: Container(
                      width: 257,
                      height: 51,
                      decoration: ShapeDecoration(
                        color: UserPreferences.hasLogin? const Color(0xFFC00000):const Color(0xFF067404),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(66),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          UserPreferences.hasLogin ? "LogOut" : "Login", // Display "Login" or "LogOut" based on login status
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
