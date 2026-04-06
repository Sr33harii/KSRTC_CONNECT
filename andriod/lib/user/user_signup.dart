// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:ksrtc/login.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
//
//
// void main() {
//   runApp( UserSignup(title: '',));
// }
//
// class UserSignup extends StatefulWidget {
//   const UserSignup({super.key, required this.title});
//
//   final String title;
//   @override
//   State<UserSignup> createState() => _UserSignupState();
//
// }
// class _UserSignupState extends State<UserSignup> {
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String gender='';
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController placeController = TextEditingController();
//   final TextEditingController pinController = TextEditingController();
//   final TextEditingController postController = TextEditingController();
//   final TextEditingController genderController = TextEditingController();
//   final TextEditingController dobController = TextEditingController();
//   final TextEditingController districtController = TextEditingController();
//   final TextEditingController stateController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   File? _selectedImage;
//   Future<void> _chooseImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
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
//     String password = passwordController.text;
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String? url = sh.getString('url');
//
//     if (url == null) {
//       Fluttertoast.showToast(msg: "Server URL not found.");
//       return;
//     }
//
//     final uri = Uri.parse('$url/user_signip/');
//     var request = http.MultipartRequest('POST', uri);
//     request.fields['name'] = name;
//     request.fields['email'] =email;
//     request.fields['phone'] = phone;
//     request.fields['place'] = place;
//     request.fields['pin'] = pin;
//     request.fields['post'] = post;
//     request.fields['gender'] = gender;
//     request.fields['dob'] = dob;
//     request.fields['district'] = district;
//     request.fields['state'] = state;
//     request.fields['password'] = password;
//
//     if (_selectedImage != null) {
//       request.files.add(await http.MultipartFile.fromPath('photo', _selectedImage!.path));
//     }
//
//     try {
//       var response = await request.send();
//       var respStr = await response.stream.bytesToString();
//       var data = jsonDecode(respStr);
//
//       if (response.statusCode == 200 && data['status'] == 'ok') {
//         Fluttertoast.showToast(msg: "Submitted successfully.");
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>MyLoginPage()));
//       } else {
//         Fluttertoast.showToast(msg: "Submission failed.");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const MyLoginPage()),
//         );
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//           centerTitle: true,
//           backgroundColor: Theme.of(context).colorScheme.primary,
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
//                     : const Text("No Image Selected"),
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
//                     if (value == null || value.trim().isEmpty) {
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
//                     Radio(value: 'male', groupValue: gender, onChanged: (value)=>{
//                       setState(() {
//                         gender=value!;
//                       })
//                     }),
//                     Text('female'),
//                     Radio(value: 'female', groupValue: gender, onChanged: (value)=>{
//                       setState(() {
//                         gender=value!;
//                       })
//                     }),
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
//                     if (value == null || value.trim().isEmpty) {
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
//                       ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: districtController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your district',
//                     border: OutlineInputBorder(),
//                   ),
//
//                             ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: stateController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your state',
//                     border: OutlineInputBorder(),
//                   ),
//
//                             ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: passwordController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your password',
//                     border: OutlineInputBorder(),
//                   ),
//
//
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _sendData();
//                     } else {
//                       Fluttertoast.showToast(msg: "Please fix errors in the form");
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
// }

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ksrtc/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(UserSignup(title: ''));
}

class UserSignup extends StatefulWidget {
  const UserSignup({super.key, required this.title});

  final String title;

  @override
  State<UserSignup> createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String gender = '';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController postController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  File? _selectedImage;
  bool _isLoading = false;
  bool _obscurePassword = true;

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

    setState(() => _isLoading = true);

    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String place = placeController.text.trim();
    String pin = pinController.text.trim();
    String post = postController.text.trim();
    String dob = dobController.text.trim();
    String district = districtController.text.trim();
    String state = stateController.text.trim();
    String password = passwordController.text.trim();

    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');

    if (url == null || url.isEmpty) {
      Fluttertoast.showToast(msg: "Server URL not found.");
      setState(() => _isLoading = false);
      return;
    }

    final uri = Uri.parse('$url/user_signip/');
    var request = http.MultipartRequest('POST', uri);

    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['phone'] = phone;
    request.fields['place'] = place;
    request.fields['pin'] = pin;
    request.fields['post'] = post;
    request.fields['gender'] = gender;
    request.fields['dob'] = dob;
    request.fields['district'] = district;
    request.fields['state'] = state;
    request.fields['password'] = password;

    if (_selectedImage != null) {
      request.files.add(await http.MultipartFile.fromPath('photo', _selectedImage!.path));
    }

    try {
      var response = await request.send();
      var respStr = await response.stream.bytesToString();
      var data = jsonDecode(respStr);

      if (!mounted) return;

      if (response.statusCode == 200 && data['status'] == 'ok') {
        Fluttertoast.showToast(msg: "Submitted successfully.");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyLoginPage()),
        );
      } else {
        Fluttertoast.showToast(msg: data['message'] ?? "Submission failed.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: ${e.toString().split('\n')[0]}");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyLoginPage()),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0D1117),
        appBar: AppBar(
          title: const Text('User Registration'),
          centerTitle: true,
          backgroundColor: const Color(0xFF161B22),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
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
                    'KSRTC CONNECT',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create your user account',
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
                      radius: 60,
                      backgroundColor: const Color(0xFF161B22),
                      backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
                      child: _selectedImage == null
                          ? const Icon(
                        Icons.person_add_alt_1_rounded,
                        size: 60,
                        color: Color(0xFFE63946),
                      )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _selectedImage == null ? 'Tap to upload photo' : 'Change photo',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 40),

                  _buildTextFormField(
                    controller: nameController,
                    label: 'Full Name',
                    hint: 'Enter your full name',
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

                  _buildTextFormField(
                    controller: emailController,
                    label: 'Email',
                    hint: 'yourname@example.com',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v?.trim().isEmpty ?? true) return 'Email is required';
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(v!)) return 'Invalid email';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  _buildTextFormField(
                    controller: phoneController,
                    label: 'Phone Number',
                    hint: 'Enter 10-digit mobile number',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    validator: (v) => (v?.trim().length != 10) ? 'Enter valid 10-digit phone' : null,
                  ),
                  const SizedBox(height: 20),

                  _buildTextFormField(
                    controller: placeController,
                    label: 'Place',
                    hint: 'Enter your place/locality',
                    icon: Icons.location_on_outlined,
                  ),
                  const SizedBox(height: 20),

                  _buildTextFormField(
                    controller: pinController,
                    label: 'PIN Code',
                    hint: '6-digit PIN',
                    icon: Icons.pin,
                    keyboardType: TextInputType.number,
                    validator: (v) => (v?.trim().length != 6) ? 'Enter valid 6-digit PIN' : null,
                  ),
                  const SizedBox(height: 20),

                  _buildTextFormField(
                    controller: postController,
                    label: 'Post Office',
                    hint: 'Enter your post office',
                    icon: Icons.local_post_office_outlined,
                  ),
                  const SizedBox(height: 20),

                  _buildTextFormField(
                    controller: dobController,
                    label: 'Date of Birth',
                    hint: 'YYYY-MM-DD',
                    icon: Icons.calendar_today_outlined,
                    validator: (v) => v?.trim().isEmpty ?? true ? 'DOB is required' : null,
                  ),
                  const SizedBox(height: 20),

                  _buildTextFormField(
                    controller: districtController,
                    label: 'District',
                    hint: 'Enter your district',
                    icon: Icons.map_outlined,
                  ),
                  const SizedBox(height: 20),

                  _buildTextFormField(
                    controller: stateController,
                    label: 'State',
                    hint: 'Kerala',
                    icon: Icons.public_outlined,
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      hintText: 'Create a strong password',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey[400],
                        ),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
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
                    validator: (v) => (v?.trim().length ?? 0) < 6 ? 'Password must be at least 6 characters' : null,
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _sendData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE63946),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                        height: 26,
                        width: 26,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                      )
                          : const Text(
                        'CREATE ACCOUNT',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, letterSpacing: 1.1),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  TextButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const MyLoginPage()),
                    ),
                    child: const Text(
                      'Already have an account? Login',
                      style: TextStyle(color: Color(0xFFE63946), fontSize: 15, fontWeight: FontWeight.w600),
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

  Widget _buildTextFormField({
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

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    placeController.dispose();
    pinController.dispose();
    postController.dispose();
    dobController.dispose();
    districtController.dispose();
    stateController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}