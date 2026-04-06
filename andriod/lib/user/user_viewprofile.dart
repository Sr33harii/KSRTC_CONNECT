// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:ksrtc/DRIVER/driver%20edit%20profile.dart';
// import 'package:ksrtc/DRIVER/driverchangepassword.dart';
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'user change password.dart';
// import 'user home.dart';
// import 'user_editprofile.dart';
//
// void main() {
//   runApp(const myapp());
// }
//
// class myapp extends StatelessWidget {
//   const myapp({super.key});
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
//       home: const userviewprofile(title: 'View Profile'),
//     );
//   }
// }
//
// class userviewprofile extends StatefulWidget {
//   const userviewprofile({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<userviewprofile> createState() => _userviewprofileState();
// }
//
// class _userviewprofileState extends State<userviewprofile> {
//
//   _userviewprofileState()
//   {
//     _send_data();
//   }
//   @override
//   Widget build(BuildContext context) {
//
//
//
//     return WillPopScope(
//       onWillPop: () async{
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>UserHomePage()));
//         return false;
//         },
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
//               CircleAvatar(backgroundImage: NetworkImage(photo_),radius: 50,),
//               Column(
//                 children: [
//                   // Image(image: NetworkImage(photo_),height: 200,width: 200,),
//
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
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>UserEditProfile(title: '')));
//                   }, child: Text('edit profile')),
//                   ElevatedButton(onPressed: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>UserChangePassword(title: '')));
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
//
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
//     final urls = Uri.parse('$url/user_view_profile/');
//     try {
//       final response = await http.post(urls, body: {
//         'lid':lid
//
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status=='ok') {
//
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
//
//             name_= name;
//             dob_= dob;
//             gender_= gender;
//             email_= email;
//             phone_= phone;
//             place_= place;
//             post_= post;
//             pin_= pin;
//             state_=state;
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

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ksrtc/DRIVER/driver%20edit%20profile.dart';
import 'package:ksrtc/DRIVER/driverchangepassword.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'user change password.dart';
import 'user home.dart';
import 'user_editprofile.dart';

void main() {
  runApp(const myapp());
}

class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KSRTC CONNECT - Profile',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0F12),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFEF4444),
          brightness: Brightness.dark,
          primary: const Color(0xFFEF4444),
          secondary: const Color(0xFF22D3EE),
          surface: const Color(0xFF1A1A1F),
          background: const Color(0xFF0F0F12),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF111116),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEF4444),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      home: const userviewprofile(title: 'View Profile'),
    );
  }
}

class userviewprofile extends StatefulWidget {
  const userviewprofile({super.key, required this.title});

  final String title;

  @override
  State<userviewprofile> createState() => _userviewprofileState();
}

class _userviewprofileState extends State<userviewprofile> {
  _userviewprofileState() {
    _send_data();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserHomePage()));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Profile Photo
              CircleAvatar(
                radius: 60,
                backgroundColor: const Color(0xFFEF4444).withOpacity(0.2),
                child: CircleAvatar(
                  radius: 58,
                  backgroundColor: const Color(0xFF1E1E24),
                  backgroundImage: photo_.isNotEmpty
                      ? NetworkImage(photo_)
                      : null,
                  child: photo_.isEmpty
                      ? const Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.grey,
                  )
                      : null,
                ),
              ),

              const SizedBox(height: 28),

              // Name (bigger & bolder)
              Text(
                name_.isNotEmpty ? name_ : "Loading...",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 32),

              // Info Cards
              _buildInfoRow("Email", email_),
              _buildInfoRow("Phone", phone_),
              _buildInfoRow("Gender", gender_),
              _buildInfoRow("Date of Birth", dob_),
              _buildInfoRow("Place", place_),
              _buildInfoRow("Post", post_),
              _buildInfoRow("PIN", pin_),
              _buildInfoRow("District", district_),
              _buildInfoRow("State", state_),

              const SizedBox(height: 40),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.edit, size: 20),
                        label: const Text("Edit Profile"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserEditProfile(title: ''),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.lock_reset, size: 20),
                        label: const Text("Change Password"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF374151),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserChangePassword(title: ''),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E24),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2D2D35), width: 0.8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
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
              value.isNotEmpty ? value : "-",
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

  String name_ = "";
  String email_ = "";
  String phone_ = "";
  String place_ = "";
  String pin_ = "";
  String post_ = "";
  String gender_ = "";
  String dob_ = "";
  String district_ = "";
  String state_ = "";
  String photo_ = "";

  void _send_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String img_url = sh.getString('img_url').toString();

    final urls = Uri.parse('$url/user_view_profile/');
    try {
      final response = await http.post(urls, body: {'lid': lid});
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String name = jsonDecode(response.body)['name'];
          String email = jsonDecode(response.body)['email'];
          String phone = jsonDecode(response.body)['phone'];
          String place = jsonDecode(response.body)['place'];
          String pin = jsonDecode(response.body)['pin'];
          String post = jsonDecode(response.body)['post'];
          String gender = jsonDecode(response.body)['gender'];
          String dob = jsonDecode(response.body)['dob'];
          String state = jsonDecode(response.body)['state'];
          String district = jsonDecode(response.body)['district'];
          String photo = img_url + jsonDecode(response.body)['photo'];

          setState(() {
            name_ = name;
            dob_ = dob;
            gender_ = gender;
            email_ = email;
            phone_ = phone;
            place_ = place;
            post_ = post;
            pin_ = pin;
            state_ = state;
            district_ = district;
            photo_ = photo;
          });
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