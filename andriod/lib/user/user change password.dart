//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:ksrtc/DRIVER/driverhome.dart';
// import 'package:ksrtc/DRIVER/driversignup.dart';
// import 'package:ksrtc/login.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import 'user home.dart';
//
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: UserChangePassword(title: 'Login'),
//   ));
// }
//
// class UserChangePassword extends StatefulWidget {
//   const UserChangePassword({super.key, required this.title});
//   final String title;
//
//   @override
//   State<UserChangePassword> createState() => _UserChangePasswordState();
// }
//
// class _UserChangePasswordState extends State<UserChangePassword> {
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
//             MaterialPageRoute(builder: (context) => const UserHomePage()),
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
//                     ],
//                   ),
//                 ),
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
//     final urls = Uri.parse('$url/user_change_password/');
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
//           Navigator.push(context,
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
import 'package:ksrtc/DRIVER/driversignup.dart';
import 'package:ksrtc/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'user home.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserChangePassword(title: 'Change Password'),
  ));
}

class UserChangePassword extends StatefulWidget {
  const UserChangePassword({super.key, required this.title});
  final String title;

  @override
  State<UserChangePassword> createState() => _UserChangePasswordState();
}

class _UserChangePasswordState extends State<UserChangePassword> {
  final TextEditingController _currentpasswordController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  final TextEditingController _coniformpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UserHomePage()),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0F0F12), // deep dark background
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          backgroundColor: const Color(0xFF111116),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const Text(
                  "Change Password",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Update your password to keep your account secure",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[400],
                  ),
                ),

                const SizedBox(height: 40),

                // Form Fields
                _buildPasswordField(
                  controller: _currentpasswordController,
                  label: "Current Password",
                  hint: "Enter your current password",
                ),
                const SizedBox(height: 20),

                _buildPasswordField(
                  controller: _newpasswordController,
                  label: "New Password",
                  hint: "Enter your new password",
                ),
                const SizedBox(height: 20),

                _buildPasswordField(
                  controller: _coniformpasswordController,
                  label: "Confirm New Password",
                  hint: "Re-enter your new password",
                ),

                const SizedBox(height: 40),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.lock_reset_rounded, size: 22),
                    label: const Text(
                      "Update Password",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEF4444),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      _send_data();
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Optional back to login hint
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyLoginPage()),
                      );
                    },
                    child: Text(
                      "Back to Login",
                      style: TextStyle(
                        color: const Color(0xFF22D3EE),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
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

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      obscureText: true,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[400]),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[600]),
        filled: true,
        fillColor: const Color(0xFF1E1E24),
        prefixIcon: const Icon(Icons.lock_outline_rounded, color: Color(0xFFEF4444)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }

  void _send_data() async {
    String currentpassword = _currentpasswordController.text;
    String newpassword = _newpasswordController.text;
    String conformpassword = _coniformpasswordController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String lid = sh.getString('lid').toString();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/user_change_password/');
    try {
      final response = await http.post(urls, body: {
        'currentpassword': currentpassword,
        'newpassword': newpassword,
        'confirmpassword': conformpassword,
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: "Password changed successfully");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyLoginPage()),
          );
        } else {
          Fluttertoast.showToast(msg: jsonDecode(response.body)['message'] ?? 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
