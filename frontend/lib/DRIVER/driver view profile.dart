// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:ksrtc/DRIVER/driver%20edit%20profile.dart';
// import 'package:ksrtc/DRIVER/driverchangepassword.dart';
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(const driverViewProfile());
// }
//
// class driverViewProfile extends StatelessWidget {
//   const driverViewProfile({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'View Profile',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const driverViewProfilePage(title: 'View Profile'),
//     );
//   }
// }
//
// class driverViewProfilePage extends StatefulWidget {
//   const driverViewProfilePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<driverViewProfilePage> createState() => _driverViewProfilePageState();
// }
//
// class _driverViewProfilePageState extends State<driverViewProfilePage> {
//
//   _driverViewProfilePageState()
//   {
//     _send_data();
//   }
//   @override
//   Widget build(BuildContext context) {
//
//
//
//     return WillPopScope(
//       onWillPop: () async{ return true; },
//       child: Scaffold(
//         appBar: AppBar(
//           leading: BackButton( ),
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           title: Text(widget.title),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//
//
//               CircleAvatar(radius: 50,),
//               Column(
//                 children: [
//                   Image(image: NetworkImage(photo_),height: 200,width: 200,),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(licenceno_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(name_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(email_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(phone_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(place_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(post_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(gender_),
//                   ),
//
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(pin_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(dob_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(district_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(state_),
//                   ),
//
//                   ElevatedButton(onPressed: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>driver_editprofile(title: '')));
//                   }, child: Text('edit profile')),
//                   ElevatedButton(onPressed: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>driverchangepassword(title: '')));
//                   }, child: Text('change password')),
//
//
//                 ],
//               ),
//               // ElevatedButton(
//               //   onPressed: () {
//               //     Navigator.push(context, MaterialPageRoute(
//               //       builder: (context) => MyEditPage(title: "Edit Profile"),));
//               //   },
//               //   child: Text("Edit Profile"),
//               // ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   String licenceno_="";
//   String name_="";
//   String email_="";
//   String phone_="";
//   String place_="";
//   String pin_="";
//   String post_="";
//   String gender_="";
//   String dob_="";
//   String district_="";
//   String state_="";
//   String photo_="";
//
//   void _send_data() async{
//
//
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid = sh.getString('lid').toString();
//     String img_url = sh.getString('img_url').toString();
//
//     final urls = Uri.parse('$url/driver_view_profile/');
//     try {
//       final response = await http.post(urls, body: {
//         'lid':lid
//
//
//
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status=='ok') {
//           String licenceno=jsonDecode(response.body)['licenceno'];
//           String name=jsonDecode(response.body)['name'];
//           String email=jsonDecode(response.body)['email'];
//           String phone=jsonDecode(response.body)['phone'];
//           String place=jsonDecode(response.body)['place'];
//           String pin=jsonDecode(response.body)['pin'];
//           String post=jsonDecode(response.body)['post'];
//           String gender=jsonDecode(response.body)['gender'];
//           String dob=jsonDecode(response.body)['dob'];
//           String state=jsonDecode(response.body)['state'];
//           String district=jsonDecode(response.body)['district'];
//           String photo=img_url+jsonDecode(response.body)['photo'];
//
//           setState(() {
//             licenceno_= licenceno;
//             name_= name;
//             dob_= dob;
//             gender_= gender;
//             email_= email;
//             phone_= phone;
//             place_= place;
//             post_= post;
//             pin_= pin;
//             district_= district;
//             photo_= photo;
//           });
//
//
//
//
//
//         }else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       }
//       else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     }
//     catch (e){
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'driver edit profile.dart';      // driver_editprofile
import 'driverchangepassword.dart';    // driverchangepassword

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: driverViewProfilePage(title: 'My Profile'),
  ));
}

class driverViewProfilePage extends StatefulWidget {
  const driverViewProfilePage({super.key, required this.title});

  final String title;

  @override
  State<driverViewProfilePage> createState() => _driverViewProfilePageState();
}

class _driverViewProfilePageState extends State<driverViewProfilePage> {
  bool _isLoading = true;

  String licenseNo = "";
  String name = "";
  String email = "";
  String phone = "";
  String place = "";
  String pin = "";
  String post = "";
  String gender = "";
  String dob = "";
  String district = "";
  String state = "";
  String photo = "";

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    setState(() => _isLoading = true);

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? baseUrl = sh.getString('url');
      String? lid = sh.getString('lid');
      String? imgBaseUrl = sh.getString('img_url');

      if (baseUrl == null || lid == null || imgBaseUrl == null) {
        Fluttertoast.showToast(msg: "Session or server not configured");
        return;
      }

      final uri = Uri.parse('$baseUrl/driver_view_profile/');

      final response = await http.post(uri, body: {'lid': lid});

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['status'] == 'ok') {
          setState(() {
            licenseNo = json['licenceno'] ?? '—';
            name = json['name'] ?? 'Driver';
            email = json['email'] ?? '—';
            phone = json['phone'] ?? '—';
            place = json['place'] ?? '—';
            pin = json['pin'] ?? '—';
            post = json['post'] ?? '—';
            gender = json['gender'] ?? '—';
            dob = json['dob'] ?? '—';
            district = json['district'] ?? '—';
            state = json['state'] ?? '—';
            photo = imgBaseUrl + (json['photo'] ?? '');
          });
        } else {
          Fluttertoast.showToast(msg: json['message'] ?? 'Profile not found');
        }
      } else {
        Fluttertoast.showToast(msg: "Server error (${response.statusCode})");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error loading profile");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0D1117),
        appBar: AppBar(
          title: const Text('My Profile'),
          centerTitle: true,
          backgroundColor: const Color(0xFF161B22),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: _isLoading
              ? const Center(
            child: CircularProgressIndicator(color: Color(0xFFE63946)),
          )
              : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),

                // Logo
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(
                    'https://toppng.com/uploads/preview/ksrtc-logo-11562902896j2j2j2j2j2.png',
                    height: 90,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE63946).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(
                        Icons.directions_bus_filled_rounded,
                        size: 50,
                        color: Color(0xFFE63946),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Profile Photo
                CircleAvatar(
                  radius: 70,
                  backgroundColor: const Color(0xFF161B22),
                  backgroundImage: photo.isNotEmpty ? NetworkImage(photo) : null,
                  child: photo.isEmpty
                      ? const Icon(
                    Icons.person,
                    size: 70,
                    color: Color(0xFFE63946),
                  )
                      : null,
                ),
                const SizedBox(height: 24),

                // Name + License
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Driver • $licenseNo',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[400],
                  ),
                ),

                const SizedBox(height: 40),

                // Details Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161B22),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: const Color(0xFFE63946).withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow("Email", email),
                      _buildDetailRow("Phone", phone),
                      _buildDetailRow("Gender", gender),
                      _buildDetailRow("Date of Birth", dob),
                      _buildDetailRow("Place", place),
                      _buildDetailRow("Post Office", post),
                      _buildDetailRow("PIN", pin),
                      _buildDetailRow("District", district),
                      _buildDetailRow("State", state),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Action Buttons
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const driver_editprofile(title: ''),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit, size: 20),
                    label: const Text(
                      'EDIT PROFILE',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE63946),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const driverchangepassword(title: ''),
                        ),
                      );
                    },
                    icon: const Icon(Icons.lock_reset, size: 20),
                    label: const Text(
                      'CHANGE PASSWORD',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFE63946),
                      side: const BorderSide(color: Color(0xFFE63946), width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? '—' : value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}