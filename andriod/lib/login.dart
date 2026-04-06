//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:ksrtc/DRIVER/driverhome.dart';
// import 'package:ksrtc/DRIVER/driversignup.dart';
// import 'package:ksrtc/user/forget_password.dart';
// import 'package:ksrtc/user/user_signup.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import 'main.dart';
// import 'user/user home.dart';
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: MyLoginPage(title: 'Login'),
//   ));
// }
//
// class MyLoginPage extends StatefulWidget {
//   const MyLoginPage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<MyLoginPage> createState() => _MyLoginPageState();
// }
//
// class _MyLoginPageState extends State<MyLoginPage> {
//   final TextEditingController _usernametextController = TextEditingController();
//   final TextEditingController _passwordtextController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//         onWillPop: () async {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const ServerConfigScreen()),
//           );
//           return false; // Prevent default pop
//         },
//         child:Scaffold(
//           backgroundColor: const Color(0xFFEFF3FF), // Light blue background
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 // Top Shape and Logo
//                 Stack(
//                   children: [
//                     Container(
//                       height: 180,
//                       decoration: const BoxDecoration(
//                         color: Color(0xFF0047AB),
//                         borderRadius:
//                         BorderRadius.only(bottomLeft: Radius.circular(80)),
//                       ),
//                     ),
//                     const Positioned(
//                       top: 100,
//                       left: 20,
//                       child: Text(
//                         'KSRTC CONNECT',
//                         style: TextStyle(
//                             fontSize: 32,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 40),
//
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text("Email id",
//                           style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                       const SizedBox(height: 10),
//                       TextField(
//                         controller: _usernametextController,
//                         decoration: InputDecoration(
//                           hintText: "Enter your email",
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       const Text("Password",
//                           style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                       const SizedBox(height: 10),
//                       TextField(
//                         controller: _passwordtextController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           hintText: "••••••••",
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none),
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//
//                       // Login Button
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: _send_data,
//                           style: ElevatedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             backgroundColor: Colors.orange,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12)),
//                           ),
//                           child: const Text("Login",
//                               style: TextStyle(color: Colors.white, fontSize: 16)),
//                         ),
//                       ),
//
//                       const SizedBox(height: 10),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: TextButton(
//                           onPressed: () {
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>forgotpassword()));
//                           },
//                           child: const Text("Forgot Password ?",
//                               style: TextStyle(color: Colors.black87)),
//
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//
//                       // Divider
//                       Row(children: const <Widget>[
//                         Expanded(child: Divider()),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 8),
//                           child: Text("or"),
//                         ),
//                         Expanded(child: Divider()),
//                       ]),
//                       const SizedBox(height: 20),
//
//                       // Facebook Button
//                       // SizedBox(
//                       //   width: double.infinity,
//                       //   child: ElevatedButton.icon(
//                       //     onPressed: () {},
//                       //     icon: const Icon(Icons.facebook, color: Colors.white),
//                       //     label: const Text("Log in with Facebook"),
//                       //     style: ElevatedButton.styleFrom(
//                       //         backgroundColor: const Color(0xFF1877F2),
//                       //         padding: const EdgeInsets.symmetric(vertical: 14),
//                       //         shape: RoundedRectangleBorder(
//                       //             borderRadius: BorderRadius.circular(8))),
//                       //   ),
//                       // ),
//                       const SizedBox(height: 30),
//
//                       // Register Prompt
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children:  [
//                           Text("Don't have an account? ",
//                               style: TextStyle(color: Colors.black87)),
//                           TextButton(onPressed: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>driver_signup(title: '')));
//                           }, child: Text('Driver Register')),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//
//
//                       children: [
//                             Text("Don't have an account? ",
//                                 style: TextStyle(color: Colors.black87)),
//                             TextButton(onPressed: (){
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>UserSignup(title: '')));
//                             }, child: Text('User Register')),
//
//                           ],
//
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
//
//   void _send_data() async {
//     String uname = _usernametextController.text;
//     String password = _passwordtextController.text;
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//
//     final urls = Uri.parse('$url/mobile_login/');
//     try {
//       final response = await http.post(urls, body: {
//         'username': uname,
//         'password': password,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         String type = jsonDecode(response.body)['type'];
//         if (status == 'ok') {
//           String lid = jsonDecode(response.body)['lid'];
//           sh.setString("lid", lid);
//           if(type=='driver'){
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => driverHomePage()),
//             );
//           }
//           if(type=='user'){
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => UserHomePage()),
//             );
//           }
//
//
//         } else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ksrtc/user/forget_password.dart';
import 'package:ksrtc/user/user%20home.dart';
import 'package:ksrtc/user/user_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DRIVER/driverhome.dart';
import 'DRIVER/driversignup.dart';

// Uncomment and adjust your actual page imports as needed
// import 'package:ksrtc/DRIVER/driverhome.dart';
// import 'package:ksrtc/DRIVER/driversignup.dart';
// import 'package:ksrtc/user/forget_password.dart';
// import 'package:ksrtc/user/user_signup.dart';
// import 'package:ksrtc/user/user%20home.dart';
// import 'main.dart';  // ServerConfigScreen if needed

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyLoginPage(),
  ));
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const ServerConfigScreen()),
        // );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0D1117), // Deep dark background
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                // Logo + App Name
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.network(
                        'https://toppng.com/uploads/preview/ksrtc-logo-11562902896j2j2j2j2j2.png',
                        height: 110,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE63946).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Icon(
                              Icons.directions_bus_filled_rounded,
                              size: 70,
                              color: Color(0xFFE63946),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'KSRTC CONNECT',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Login to manage trips & bookings',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 60),

                // Email Field
                _buildTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'yourname@example.com',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24),

                // Password Field
                _buildTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: '••••••••',
                  icon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey[400],
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),

                const SizedBox(height: 12),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ForgotPassword()),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xFFE63946),
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE63946),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                      height: 26,
                      width: 26,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                        : const Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 48),

                // Divider + OR
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[800])),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'OR',
                        style: TextStyle(color: Colors.grey[600], fontSize: 15),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey[800])),
                  ],
                ),

                const SizedBox(height: 40),

                // Register Options
                _buildRegisterRow(
                  text: "Don't have an account? ",
                  buttonText: 'Register as Driver',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DriverSignup(title: '')),
                    );
                  },
                ),

                const SizedBox(height: 12),

                _buildRegisterRow(
                  text: "Don't have an account? ",
                  buttonText: 'Register as User',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UserSignup(title: '')),
                    );
                  },
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(icon, color: Colors.grey[400]),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFF161B22),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE63946), width: 1.8),
        ),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      ),
    );
  }

  Widget _buildRegisterRow({
    required String text,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(color: Colors.grey[400], fontSize: 15),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Color(0xFFE63946),
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please enter email and password",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final baseUrl = prefs.getString('url') ?? '';

      if (baseUrl.isEmpty) {
        Fluttertoast.showToast(msg: "Server URL not set");
        return;
      }

      final uri = Uri.parse('$baseUrl/mobile_login/');

      final response = await http.post(
        uri,
        body: {
          'username': email,
          'password': password,
        },
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final status = json['status']?.toString() ?? 'error';
        final type = json['type']?.toString() ?? '';

        if (status == 'ok') {
          final lid = json['lid']?.toString() ?? '';
          await prefs.setString('lid', lid);

          if (type == 'driver') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const driverHomePage()),
            );
          } else if (type == 'user') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const UserHomePage()),
            );
          } else {
            Fluttertoast.showToast(msg: "Unknown account type");
          }
        } else {
          Fluttertoast.showToast(
            msg: json['message'] ?? 'Login failed – invalid credentials',
            backgroundColor: Colors.redAccent,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Server error (${response.statusCode})",
          backgroundColor: Colors.redAccent,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Connection error: ${e.toString().split('\n')[0]}",
        backgroundColor: Colors.redAccent,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
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

