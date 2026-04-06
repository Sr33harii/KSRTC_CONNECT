
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ksrtc/DRIVER/driverhome.dart';
import 'package:ksrtc/DRIVER/driversignup.dart';
import 'package:ksrtc/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'user home.dart';
import 'view replay.dart';


void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserSentComplaint(title: 'Login'),
  ));
}

class UserSentComplaint extends StatefulWidget {
  const UserSentComplaint({super.key, required this.title});
  final String title;

  @override
  State<UserSentComplaint> createState() => _UserSentComplaintState();
}

class _UserSentComplaintState extends State<UserSentComplaint> {
  final TextEditingController _complaintController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const UserViewReplyPage(title: '',)),
          );
          return false; // Prevent default pop
        },
        child:Scaffold(
          backgroundColor: const Color(0xFFEFF3FF), // Light blue background
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Top Shape and Logo
                Stack(
                  children: [
                    Container(
                      height: 180,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0047AB),
                        borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(80)),
                      ),
                    ),
                    const Positioned(
                      top: 100,
                      left: 20,
                      child: Text(
                        'Sent Complaint',
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("",
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _complaintController,
                        decoration: InputDecoration(
                          hintText: "Enter your complaint"
                              "",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none),
                        ),
                      ),

                      ElevatedButton(onPressed: (){
                        _send_data();
                      }, child: Text('submit'))

                      // Divider


                      // Facebook Button
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: ElevatedButton.icon(
                      //     onPressed: () {},
                      //     icon: const Icon(Icons.facebook, color: Colors.white),
                      //     label: const Text("Log in with Facebook"),
                      //     style: ElevatedButton.styleFrom(
                      //         backgroundColor: const Color(0xFF1877F2),
                      //         padding: const EdgeInsets.symmetric(vertical: 14),
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(8))),
                      //   ),
                      // ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _send_data() async {
    String complaint = _complaintController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String lid = sh.getString('lid').toString();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/user_sent_complaint/');
    try {
      final response = await http.post(urls, body: {
        'complaint': complaint,

        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => UserViewReplyPage(title: '',)),
          );
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
