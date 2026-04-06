
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
// import 'view feedback.dart';
//
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: UserSentFeedback(title: 'Login'),
//   ));
// }
//
// class UserSentFeedback extends StatefulWidget {
//   const UserSentFeedback({super.key, required this.title});
//   final String title;
//
//   @override
//   State<UserSentFeedback> createState() => _UserSentFeedbackState();
// }
//
// class _UserSentFeedbackState extends State<UserSentFeedback> {
//   final TextEditingController _feedbackController = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//         onWillPop: () async {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const UserViewFreedbackPage(title: '',)),
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
//                         'Sent feedback',
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
//                         controller: _feedbackController,
//                         decoration: InputDecoration(
//                           hintText: "Enter your feedback",
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none),
//                         ),
//                       ),
//
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
//     String feed = _feedbackController.text;
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String lid = sh.getString('lid').toString();
//     String url = sh.getString('url').toString();
//
//     final urls = Uri.parse('$url/user_sent_feedback/');
//     try {
//       final response = await http.post(urls, body: {
//         'feed': feed,
//         'lid': lid,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           Navigator.push(context,
//             MaterialPageRoute(builder: (context) => UserViewFreedbackPage(title: '')),
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


import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ksrtc/DRIVER/driverhome.dart';
import 'package:ksrtc/DRIVER/driversignup.dart';
import 'package:ksrtc/login.dart';

import 'user home.dart';
import 'view feedback.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserSentFeedback(title: 'Send Feedback'),
  ));
}

class UserSentFeedback extends StatefulWidget {
  const UserSentFeedback({super.key, required this.title});
  final String title;

  @override
  State<UserSentFeedback> createState() => _UserSentFeedbackState();
}

class _UserSentFeedbackState extends State<UserSentFeedback> {
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UserViewFreedbackPage(title: '')),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0F0F12),
        appBar: AppBar(
          backgroundColor: const Color(0xFF111116),
          foregroundColor: Colors.white,
          title: Text(widget.title),
          centerTitle: true,
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
                  "Share Your Feedback",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Help us improve your KSRTC CONNECT experience",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[400],
                  ),
                ),

                const SizedBox(height: 40),

                // Feedback Input
                TextField(
                  controller: _feedbackController,
                  maxLines: 6,
                  minLines: 4,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter your feedback here...",
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    filled: true,
                    fillColor: const Color(0xFF1E1E24),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),

                const SizedBox(height: 32),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.send_rounded, color: Colors.white),
                    label: const Text(
                      "Submit Feedback",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEF4444),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    onPressed: () {
                      _send_data();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _send_data() async {
    String feed = _feedbackController.text.trim();

    if (feed.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter your feedback");
      return;
    }

    SharedPreferences sh = await SharedPreferences.getInstance();
    String lid = sh.getString('lid').toString();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/user_sent_feedback/');
    try {
      final response = await http.post(urls, body: {
        'feed': feed,
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: "Feedback sent successfully");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const UserViewFreedbackPage(title: '')),
          );
        } else {
          Fluttertoast.showToast(msg: 'Failed to send feedback');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}