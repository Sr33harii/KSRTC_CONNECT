// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:ksrtc/DRIVER/driver%20view%20profile.dart';
// import 'package:ksrtc/login.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
//
//
// void main() {
//   runApp( driver_editprofile(title: '',));
// }
//
// class driver_editprofile extends StatefulWidget {
//   const driver_editprofile({super.key, required this.title});
//
//   final String title;
//   @override
//   State<driver_editprofile> createState() => _driver_editprofileState();
//
// }
// class _driver_editprofileState extends State<driver_editprofile> {
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String gender = '';
//   String photo = '';
//   final TextEditingController licencenocontroller = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController placeController = TextEditingController();
//   final TextEditingController pinController = TextEditingController();
//   final TextEditingController postController = TextEditingController();
//   final TextEditingController dobController = TextEditingController();
//   final TextEditingController districtController = TextEditingController();
//   final TextEditingController stateController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController photoController = TextEditingController();
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
//     String licenseno = licencenocontroller.text;
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
//     final uri = Uri.parse('$url/driver_edit_profile/');
//     var request = http.MultipartRequest('POST', uri);
//     request.fields['licenceno'] = licenseno;
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
//       } else {
//         Fluttertoast.showToast(msg: "Submission failed.");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error: $e");
//     }
//   }
//
//   @override
//   _driver_editprofileState(){
//     _send_data();
//   }
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const driverViewProfile()),
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
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: licencenocontroller,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your licenceno Number',
//                     border: OutlineInputBorder(),
//                   ),
//
//                 ),
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
//           String dob=jsonDecode(response.body)['dob'];
//           String state=jsonDecode(response.body)['state'];
//           String district=jsonDecode(response.body)['district'];
//
//           setState(() {
//             licencenocontroller.text= licenceno;
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../user/user_viewprofile.dart';
import 'driver view profile.dart'; // driverViewProfilePage

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: driver_editprofile(title: ''),
  ));
}

class driver_editprofile extends StatefulWidget {
  const driver_editprofile({super.key, required this.title});

  final String title;

  @override
  State<driver_editprofile> createState() => _driver_editprofileState();
}

class _driver_editprofileState extends State<driver_editprofile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String gender = '';
  String existingPhoto = '';

  final TextEditingController licenseNoController = TextEditingController();
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
  bool _isLoading = true;
  bool _isSubmitting = false;

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
            licenseNoController.text = json['licenceno'] ?? '';
            nameController.text = json['name'] ?? '';
            emailController.text = json['email'] ?? '';
            phoneController.text = json['phone'] ?? '';
            placeController.text = json['place'] ?? '';
            pinController.text = json['pin'] ?? '';
            postController.text = json['post'] ?? '';
            dobController.text = json['dob'] ?? '';
            districtController.text = json['district'] ?? '';
            stateController.text = json['state'] ?? '';
            gender = json['gender'] ?? '';
            existingPhoto = imgBaseUrl + (json['photo'] ?? '');
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
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: "Please fix errors in the form");
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? baseUrl = sh.getString('url');
      String? lid = sh.getString('lid');

      if (baseUrl == null || lid == null) {
        Fluttertoast.showToast(msg: "Session error");
        return;
      }

      final uri = Uri.parse('$baseUrl/driver_edit_profile/');
      var request = http.MultipartRequest('POST', uri);

      request.fields['lid'] = lid;
      request.fields['licenceno'] = licenseNoController.text.trim();
      request.fields['name'] = nameController.text.trim();
      request.fields['email'] = emailController.text.trim();
      request.fields['phone'] = phoneController.text.trim();
      request.fields['place'] = placeController.text.trim();
      request.fields['pin'] = pinController.text.trim();
      request.fields['post'] = postController.text.trim();
      request.fields['gender'] = gender;
      request.fields['dob'] = dobController.text.trim();
      request.fields['district'] = districtController.text.trim();
      request.fields['state'] = stateController.text.trim();

      if (_selectedImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath('photo', _selectedImage!.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'ok') {
          Fluttertoast.showToast(msg: "Profile updated successfully");
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const driverViewProfilePage(title: '',)),
            );
          }
        } else {
          Fluttertoast.showToast(msg: data['message'] ?? "Update failed");
        }
      } else {
        Fluttertoast.showToast(msg: "Server error (${response.statusCode})");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Network error: ${e.toString().split('\n')[0]}");
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const driverViewProfilePage(title: '',)),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0D1117),
        appBar: AppBar(
          title: const Text('Edit Profile'),
          centerTitle: true,
          backgroundColor: const Color(0xFF161B22),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator(color: Color(0xFFE63946)))
              : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

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
                  const SizedBox(height: 16),

                  const Text(
                    'Update Your Profile',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Keep your information up to date',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[400],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Profile Photo
                  GestureDetector(
                    onTap: _chooseImage,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: const Color(0xFF161B22),
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : (existingPhoto.isNotEmpty ? NetworkImage(existingPhoto) : null),
                      child: _selectedImage == null && existingPhoto.isEmpty
                          ? const Icon(
                        Icons.person_add_alt_1_rounded,
                        size: 70,
                        color: Color(0xFFE63946),
                      )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _selectedImage != null
                        ? 'Tap to change photo'
                        : 'Tap to upload new photo',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 40),

                  _buildTextField(
                    controller: nameController,
                    label: 'Full Name',
                    icon: Icons.person_outline,
                    validator: (v) => v?.trim().isEmpty ?? true ? 'Name is required' : null,
                  ),
                  const SizedBox(height: 20),

                  // Gender
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF161B22),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.wc_outlined, color: Colors.grey[400]),
                        const SizedBox(width: 12),
                        Text('Gender', style: TextStyle(color: Colors.grey[300])),
                        const Spacer(),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'male',
                              groupValue: gender,
                              activeColor: const Color(0xFFE63946),
                              onChanged: (v) => setState(() => gender = v!),
                            ),
                            const Text('Male', style: TextStyle(color: Colors.white70)),
                            const SizedBox(width: 16),
                            Radio<String>(
                              value: 'female',
                              groupValue: gender,
                              activeColor: const Color(0xFFE63946),
                              onChanged: (v) => setState(() => gender = v!),
                            ),
                            const Text('Female', style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (gender.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 12),
                      child: Text(
                        'Please select gender',
                        style: TextStyle(color: Colors.redAccent[700], fontSize: 12),
                      ),
                    ),

                  const SizedBox(height: 20),

                  _buildTextField(
                    controller: emailController,
                    label: 'Email',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v?.trim().isEmpty ?? true) return 'Email is required';
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(v!)) return 'Invalid email';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    controller: phoneController,
                    label: 'Phone Number',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    validator: (v) => (v?.trim().length != 10) ? 'Enter valid 10-digit phone' : null,
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    controller: licenseNoController,
                    label: 'License Number',
                    icon: Icons.card_membership_outlined,
                    validator: (v) => v?.trim().isEmpty ?? true ? 'License is required' : null,
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    controller: placeController,
                    label: 'Place',
                    icon: Icons.location_on_outlined,
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    controller: pinController,
                    label: 'PIN Code',
                    icon: Icons.pin,
                    keyboardType: TextInputType.number,
                    validator: (v) => (v?.trim().length != 6) ? 'Enter valid 6-digit PIN' : null,
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    controller: postController,
                    label: 'Post Office',
                    icon: Icons.local_post_office_outlined,
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    controller: dobController,
                    label: 'Date of Birth',
                    hint: 'YYYY-MM-DD',
                    icon: Icons.calendar_today_outlined,
                    validator: (v) => v?.trim().isEmpty ?? true ? 'DOB is required' : null,
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    controller: districtController,
                    label: 'District',
                    icon: Icons.map_outlined,
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    controller: stateController,
                    label: 'State',
                    icon: Icons.public_outlined,
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : () {
                        if (_formKey.currentState!.validate()) {
                          _sendData();
                        } else {
                          Fluttertoast.showToast(msg: "Please fix errors in the form");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE63946),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: _isSubmitting
                          ? const SizedBox(
                        height: 26,
                        width: 26,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                          : const Text(
                        'UPDATE PROFILE',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
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
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[400]),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey[400]) : null,
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
      validator: validator,
    );
  }

  // Future<void> _sendData() async {
  //   // Same as your original _sendData, just renamed for clarity
  //   await sendData(); // ← calls the function above
  // }

  @override
  void dispose() {
    licenseNoController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    placeController.dispose();
    pinController.dispose();
    postController.dispose();
    dobController.dispose();
    districtController.dispose();
    stateController.dispose();
    super.dispose();
  }
}