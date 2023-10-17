import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_sl/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  // final TextEditingController _confirmPassController = TextEditingController();
  // final TextEditingController _fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            height: screenHeight / 4,
            width: screenWidth,
            decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(70))),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white,
                  size: 80,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "SL APP",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // TextField(
                //   decoration: const InputDecoration(
                //     label: Text("Full Name"),
                //     prefixIcon: Icon(Icons.person),
                //     border: OutlineInputBorder(),
                //   ),
                //   controller: _fullNameController,
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                TextField(
                  decoration: const InputDecoration(
                    label: Text("Email ID"),
                    prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(),
                  ),
                  controller: _emailController,
                  // obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                // ******
                TextField(
                  decoration: const InputDecoration(
                    label: Text("Password"),
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  controller: _passController,
                ),
                const SizedBox(
                  height: 30,
                ),
                // TextField(
                //   decoration: const InputDecoration(
                //     label: Text("Confirm Password"),
                //     prefixIcon: Icon(Icons.lock),
                //     border: OutlineInputBorder(),
                //   ),
                //   controller: _confirmPassController,
                //   obscureText: true,
                // ),
                // ******
                // const SizedBox(
                //   height: 30,
                // ),
                // SizedBox(
                //   height: 60,
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () {},
                //     style: ElevatedButton.styleFrom(
                //         backgroundColor: Colors.green,
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(30))),
                //     child: const Text(
                //       "LOGIN",
                //       style: TextStyle(fontSize: 20, color: Colors.white),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                Consumer<AuthService>(
                  builder: (context, authServiceProvider, child) {
                    return SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: authServiceProvider.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                authServiceProvider.registerUser(
                                    _emailController.text.trim(),
                                    _passController.text.trim(),
                                    context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              child: const Text(
                                "REGISTER",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
