// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:ksrtc/DRIVER/driver%20view%20profile.dart';
// import 'package:ksrtc/login.dart';
// import 'package:ksrtc/user/user_viewprofile.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
//
//
// void main() {
//   runApp( UserEditProfile(title: '',));
// }
//
// class UserEditProfile extends StatefulWidget {
//   const UserEditProfile({super.key, required this.title});
//
//   final String title;
//   @override
//   State<UserEditProfile> createState() => _UserEditProfileState();
//
// }
// class _UserEditProfileState extends State<UserEditProfile> {
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String gender = '';
//   String photo = '';
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController placeController = TextEditingController();
//   final TextEditingController pinController = TextEditingController();
//   final TextEditingController postController = TextEditingController();
//   final TextEditingController dobController = TextEditingController();
//   final TextEditingController districtController = TextEditingController();
//   final TextEditingController stateController = TextEditingController();
//
//   File? _selectedImage;
//
//   Future<void> _chooseImage() async {
//     final pickedFile = await ImagePicker().pickImage(
//         source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//     else {
//       Fluttertoast.showToast(msg: "No image selected");
//     }
//   }
//
//   Future<void> _sendData() async {
//     String name = nameController.text;
//     String email = emailController.text;
//     String phone = phoneController.text;
//     String place = placeController.text;
//     String pin = pinController.text;
//     String post = postController.text;
//     String dob = dobController.text;
//     String district = districtController.text;
//     String state = stateController.text;
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String? url = sh.getString('url');
//     String? lid = sh.getString('lid')??'';
//
//     if (url == null) {
//       Fluttertoast.showToast(msg: "Server URL not found.");
//       return;
//     }
//
//     final uri = Uri.parse('$url/user_edit_profile/');
//     var request = http.MultipartRequest('POST', uri);
//     request.fields['name'] = name;
//     request.fields['lid'] = lid;
//     request.fields['email'] = email;
//     request.fields['phone'] = phone;
//     request.fields['place'] = place;
//     request.fields['pin'] = pin;
//     request.fields['post'] = post;
//     request.fields['gender'] = gender;
//     request.fields['dob'] = dob;
//     request.fields['district'] = district;
//     request.fields['state'] = state;
//
//     if (_selectedImage != null) {
//       request.files.add(
//           await http.MultipartFile.fromPath('photo', _selectedImage!.path));
//     }
//
//     try {
//       var response = await request.send();
//       var respStr = await response.stream.bytesToString();
//       var data = jsonDecode(respStr);
//
//       if (response.statusCode == 200 && data['status'] == 'ok') {
//         Fluttertoast.showToast(msg: "Submitted successfully.");
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const userviewprofile(title: '',)),
//         );
//       } else {
//         Fluttertoast.showToast(msg: "Submission failed.");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error: $e");
//     }
//   }
//
//   @override
//   _UserEditProfileState(){
//     _send_data();
//   }
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const userviewprofile(title: '',)),
//         );
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//           centerTitle: true,
//           backgroundColor: Theme
//               .of(context)
//               .colorScheme
//               .primary,
//           foregroundColor: Colors.white,
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 _selectedImage != null
//                     ? Image.file(_selectedImage!, height: 150)
//                     : Image.network(photo,height: 150,),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: _chooseImage,
//                   child: const Text("Choose Image"),
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: nameController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your Name',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value
//                         .trim()
//                         .isEmpty) {
//                       return 'Name is required';
//                     }
//                     return null;
//                   },
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 Row(
//                   children: [
//                     Text('gender:   '),
//                     Text('male'),
//                     Radio(
//                         value: 'male', groupValue: gender, onChanged: (value) =>
//                     {
//                       setState(() {
//                         gender = value!;
//                       })
//                     }),
//                     Text('female'),
//                     Radio(value: 'female',
//                         groupValue: gender,
//                         onChanged: (value) =>
//                         {
//                           setState(() {
//                             gender = value!;
//                           })
//                         }),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//
//                 TextFormField(
//                   controller: emailController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your Email',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value
//                         .trim()
//                         .isEmpty) {
//                       return 'Email is required';
//                     }
//                     if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
//                       return 'Enter a valid email';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: phoneController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your Phone Number',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.phone,
//
//                 ),
//
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: placeController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your place',
//                     border: OutlineInputBorder(),
//                   ),
//
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: pinController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your Pin Number',
//                     border: OutlineInputBorder(),
//                   ),
//
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: postController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your post ',
//                     border: OutlineInputBorder(),
//                   ),
//
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: dobController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your dob',
//                     border: OutlineInputBorder(),
//                   ),
//
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: districtController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your district',
//                     border: OutlineInputBorder(),
//                   ),
//
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: stateController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your state',
//                     border: OutlineInputBorder(),
//                   ),
//
//                 ),
//
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _sendData();
//                     } else {
//                       Fluttertoast.showToast(
//                           msg: "Please fix errors in the form");
//                     }
//                   },
//                   child: const Text("Submit"),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size.fromHeight(50),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
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
//
//
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status=='ok') {
//           String name=jsonDecode(response.body)['name'];
//           String email=jsonDecode(response.body)['email'];
//           String phone=jsonDecode(response.body)['phone'];
//           String place=jsonDecode(response.body)['place'];
//           String pin=jsonDecode(response.body)['pin'];
//           String post=jsonDecode(response.body)['post'];
//           String dob=jsonDecode(response.body)['dob'];
//           String state=jsonDecode(response.body)['state'];
//           String district=jsonDecode(response.body)['district'];
//
//           setState(() {
//             nameController.text= name;
//             dobController.text= dob;
//             gender= jsonDecode(response.body)['gender'];
//             emailController.text= email;
//             phoneController.text= phone;
//             placeController.text= place;
//             postController.text= post;
//             pinController.text= pin;
//             districtController.text= district;
//             stateController.text= state;
//             photo= img_url+jsonDecode(response.body)['photo'];
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
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ksrtc/DRIVER/driver%20view%20profile.dart';
import 'package:ksrtc/login.dart';
import 'package:ksrtc/user/user_viewprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const UserEditProfile(title: 'Edit Profile'));
}

class UserEditProfile extends StatefulWidget {
  const UserEditProfile({super.key, required this.title});

  final String title;

  @override
  State<UserEditProfile> createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String gender = '';
  String photo = '';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController postController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  File? _selectedImage;

  Future<void> _chooseImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    } else {
      Fluttertoast.showToast(msg: "No image selected");
    }
  }

  Future<void> _sendData() async {
    String name = nameController.text;
    String email = emailController.text;
    String phone = phoneController.text;
    String place = placeController.text;
    String pin = pinController.text;
    String post = postController.text;
    String dob = dobController.text;
    String district = districtController.text;
    String state = stateController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');
    String? lid = sh.getString('lid') ?? '';

    if (url == null) {
      Fluttertoast.showToast(msg: "Server URL not found.");
      return;
    }

    final uri = Uri.parse('$url/user_edit_profile/');
    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = name;
    request.fields['lid'] = lid;
    request.fields['email'] = email;
    request.fields['phone'] = phone;
    request.fields['place'] = place;
    request.fields['pin'] = pin;
    request.fields['post'] = post;
    request.fields['gender'] = gender;
    request.fields['dob'] = dob;
    request.fields['district'] = district;
    request.fields['state'] = state;

    if (_selectedImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath('photo', _selectedImage!.path),
      );
    }

    try {
      var response = await request.send();
      var respStr = await response.stream.bytesToString();
      var data = jsonDecode(respStr);

      if (response.statusCode == 200 && data['status'] == 'ok') {
        Fluttertoast.showToast(msg: "Profile updated successfully.");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const userviewprofile(title: '')),
        );
      } else {
        Fluttertoast.showToast(msg: "Update failed.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }

  _UserEditProfileState() {
    _send_data();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const userviewprofile(title: '')),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          backgroundColor: const Color(0xFF111116),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 12),

                // Profile Photo Section
                GestureDetector(
                  onTap: _chooseImage,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFEF4444), width: 3),
                        ),
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: const Color(0xFF1E1E24),
                          backgroundImage: _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : (photo.isNotEmpty ? NetworkImage(photo) : null),
                          child: (_selectedImage == null && photo.isEmpty)
                              ? const Icon(Icons.person, size: 70, color: Colors.grey)
                              : null,
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: const Color(0xFFEF4444),
                          child: const Icon(Icons.camera_alt, size: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),
                Text(
                  "Tap photo to change",
                  style: TextStyle(color: Colors.grey[400], fontSize: 13),
                ),

                const SizedBox(height: 32),

                // Form Fields
                _buildTextField(nameController, "Full Name", Icons.person_outline),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Gender:  ", style: TextStyle(color: Colors.white70)),
                    const Text("Male", style: TextStyle(color: Colors.white)),
                    Radio<String>(
                      value: 'male',
                      groupValue: gender,
                      activeColor: const Color(0xFFEF4444),
                      onChanged: (value) => setState(() => gender = value!),
                    ),
                    const Text("Female", style: TextStyle(color: Colors.white)),
                    Radio<String>(
                      value: 'female',
                      groupValue: gender,
                      activeColor: const Color(0xFFEF4444),
                      onChanged: (value) => setState(() => gender = value!),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                _buildTextField(emailController, "Email", Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 16),
                _buildTextField(phoneController, "Phone Number", Icons.phone_outlined,
                    keyboardType: TextInputType.phone),
                const SizedBox(height: 16),
                _buildTextField(placeController, "Place", Icons.location_on_outlined),
                const SizedBox(height: 16),
                _buildTextField(pinController, "PIN Code", Icons.pin),
                const SizedBox(height: 16),
                _buildTextField(postController, "Post Office", Icons.local_post_office_outlined),
                const SizedBox(height: 16),
                _buildTextField(dobController, "Date of Birth (YYYY-MM-DD)", Icons.calendar_today_outlined),
                const SizedBox(height: 16),
                _buildTextField(districtController, "District", Icons.map_outlined),
                const SizedBox(height: 16),
                _buildTextField(stateController, "State", Icons.public_outlined),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save_rounded),
                    label: const Text("Update Profile", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEF4444),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _sendData();
                      } else {
                        Fluttertoast.showToast(msg: "Please fix errors in the form");
                      }
                    },
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

  Widget _buildTextField(
      TextEditingController controller,
      String label,
      IconData icon, {
        TextInputType keyboardType = TextInputType.text,
      }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[400]),
        prefixIcon: Icon(icon, color: Colors.grey[400]),
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
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label is required';
        }
        if (label == "Email" && !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return 'Enter a valid email';
        }
        return null;
      },
    );
  }

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
          String dob = jsonDecode(response.body)['dob'];
          String state = jsonDecode(response.body)['state'];
          String district = jsonDecode(response.body)['district'];

          setState(() {
            nameController.text = name;
            dobController.text = dob;
            gender = jsonDecode(response.body)['gender'];
            emailController.text = email;
            phoneController.text = phone;
            placeController.text = place;
            postController.text = post;
            pinController.text = pin;
            districtController.text = district;
            stateController.text = state;
            photo = img_url + jsonDecode(response.body)['photo'];
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