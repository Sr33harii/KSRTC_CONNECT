
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:ksrtc/DRIVER/driverhome.dart';
// import 'package:ksrtc/DRIVER/driversignup.dart';
// import 'package:ksrtc/login.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: driverchangepassword(title: 'Login'),
//   ));
// }
//
// class driverchangepassword extends StatefulWidget {
//   const driverchangepassword({super.key, required this.title});
//   final String title;
//
//   @override
//   State<driverchangepassword> createState() => _driverchangepasswordState();
// }
//
// class _driverchangepasswordState extends State<driverchangepassword> {
//   final TextEditingController _currentpasswordController = TextEditingController();
//   final TextEditingController _newpasswordController = TextEditingController();
//   final TextEditingController _coniformpasswordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//         onWillPop: () async {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const driverHomePage()),
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
//                         'change password',
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
//                       const Text("",
//                           style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                       const SizedBox(height: 10),
//                       TextField(
//                         controller: _currentpasswordController,
//                         decoration: InputDecoration(
//                           hintText: "Enter your current password",
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       TextField(
//                         controller: _newpasswordController,
//                         decoration: InputDecoration(
//                           hintText: "Enter your new password",
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       TextField(
//                         controller: _coniformpasswordController,
//                         decoration: InputDecoration(
//                           hintText: "Enter your conform password",
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none),
//                         ),
//                       ),
//                       ElevatedButton(onPressed: (){
//                         _send_data();
//                       }, child: Text('submit'))
//
//                       // Divider
//
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
//
//                         ],
//                       ),
//                   ),
//               ],
//             ),
//           ),
//         ));
//   }
//
//   void _send_data() async {
//     String currentpassword = _currentpasswordController.text;
//     String newpassword = _newpasswordController.text;
//     String conformpassword = _coniformpasswordController.text;
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String lid = sh.getString('lid').toString();
//     String url = sh.getString('url').toString();
//
//     final urls = Uri.parse('$url/driver_change_password/');
//     try {
//       final response = await http.post(urls, body: {
//         'currentpassword': currentpassword,
//         'newpassword': newpassword,
//         'confirmpassword': conformpassword,
//         'lid': lid,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => MyLoginPage()),
//           );
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
import 'package:ksrtc/DRIVER/driverhome.dart';
import 'package:ksrtc/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: driverchangepassword(title: 'Change Password'),
  ));
}

class driverchangepassword extends StatefulWidget {
  const driverchangepassword({super.key, required this.title});
  final String title;

  @override
  State<driverchangepassword> createState() => _driverchangepasswordState();
}

class _driverchangepasswordState extends State<driverchangepassword> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const driverHomePage()),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0D1117),
        appBar: AppBar(
          title: const Text('Change Password'),
          centerTitle: true,
          backgroundColor: const Color(0xFF161B22),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                // Logo + Title
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.network(
                        'https://toppng.com/uploads/preview/ksrtc-logo-11562902896j2j2j2j2j2.png',
                        height: 100,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE63946).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Icon(
                            Icons.directions_bus_filled_rounded,
                            size: 60,
                            color: Color(0xFFE63946),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'KSRTC CONNECT',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Update your password',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                // Current Password
                _buildPasswordField(
                  controller: _currentPasswordController,
                  label: 'Current Password',
                  hint: '••••••••',
                  obscureText: _obscureCurrent,
                  onVisibilityChanged: () => setState(() => _obscureCurrent = !_obscureCurrent),
                ),
                const SizedBox(height: 24),

                // New Password
                _buildPasswordField(
                  controller: _newPasswordController,
                  label: 'New Password',
                  hint: '••••••••',
                  obscureText: _obscureNew,
                  onVisibilityChanged: () => setState(() => _obscureNew = !_obscureNew),
                ),
                const SizedBox(height: 24),

                // Confirm Password
                _buildPasswordField(
                  controller: _confirmPasswordController,
                  label: 'Confirm New Password',
                  hint: '••••••••',
                  obscureText: _obscureConfirm,
                  onVisibilityChanged: () => setState(() => _obscureConfirm = !_obscureConfirm),
                ),

                const SizedBox(height: 40),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _sendData,
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
                      'UPDATE PASSWORD',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const driverHomePage()),
                    );
                  },
                  child: const Text(
                    'Back to Dashboard',
                    style: TextStyle(
                      color: Color(0xFFE63946),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool obscureText,
    required VoidCallback onVisibilityChanged,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[400]),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey[400],
          ),
          onPressed: onVisibilityChanged,
        ),
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
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      ),
    );
  }

  Future<void> _sendData() async {
    final current = _currentPasswordController.text.trim();
    final newPass = _newPasswordController.text.trim();
    final confirm = _confirmPasswordController.text.trim();

    if (current.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      Fluttertoast.showToast(msg: "All fields are required");
      return;
    }

    if (newPass != confirm) {
      Fluttertoast.showToast(msg: "New password and confirm password do not match");
      return;
    }

    if (newPass.length < 6) {
      Fluttertoast.showToast(msg: "Password must be at least 6 characters");
      return;
    }

    setState(() => _isLoading = true);

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? lid = sh.getString('lid');
      String? baseUrl = sh.getString('url');

      if (lid == null || baseUrl == null || baseUrl.isEmpty) {
        Fluttertoast.showToast(msg: "Session or server not configured");
        return;
      }

      final uri = Uri.parse('$baseUrl/driver_change_password/');

      final response = await http.post(uri, body: {
        'currentpassword': current,
        'newpassword': newPass,
        'confirmpassword': confirm,
        'lid': lid,
      });

      if (!mounted) return;

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final status = json['status']?.toString() ?? 'error';

        if (status == 'ok') {
          Fluttertoast.showToast(msg: "Password changed successfully");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MyLoginPage()),
          );
        } else {
          Fluttertoast.showToast(
            msg: json['message'] ?? 'Failed to change password',
            backgroundColor: Colors.redAccent,
          );
        }
      } else {
        Fluttertoast.showToast(msg: "Server error (${response.statusCode})");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: ${e.toString().split('\n')[0]}");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}