// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'driver viewbus.dart';
//
// class AddBus extends StatefulWidget {
//   const AddBus({super.key});
//
//   @override
//   State<AddBus> createState() => _AddBusState();
// }
//
// class _AddBusState extends State<AddBus> {
//   TextEditingController busnamecontroller = TextEditingController();
//   TextEditingController reg_nocontroller = TextEditingController();
//   TextEditingController descriptioncontroller = TextEditingController();
//
//   List routes = [];
//   String? selectedFromID;
//   String? selectedToID;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchRoutes();
//   }
//
//   // Fetch route list
//   Future<void> fetchRoutes() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url') ?? '';
//
//       final uri = Uri.parse("$url/driver_get_bus_root/");
//       final res = await http.post(uri);
//
//       if (res.statusCode == 200) {
//         var data = jsonDecode(res.body);
//         setState(() {
//           routes = data['data'];
//         });
//       } else {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text("Failed to load routes")));
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Error fetching routes: $e")));
//     }
//   }
//
//   // Send to backend
//   Future<void> sendData() async {
//     if (busnamecontroller.text.isEmpty ||
//         reg_nocontroller.text.isEmpty ||
//         selectedFromID == null ||
//         selectedToID == null ||
//         descriptioncontroller.text.isEmpty) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Please fill all fields")));
//       return;
//     }
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url') ?? '';
//       String lid = sh.getString('lid') ?? '';
//
//       final uri = Uri.parse("$url/add_bus/");
//
//       final response = await http.post(uri, body: {
//         'lid': lid,
//         'busname': busnamecontroller.text,
//         'reg_no': reg_nocontroller.text,
//         'fromroute': selectedFromID!, // SEND ID ✔
//         'toroute': selectedToID!,     // SEND ID ✔
//         'description': descriptioncontroller.text,
//       });
//
//       var data = jsonDecode(response.body);
//
//       if (data['status'] == 'ok') {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text("Bus Added Successfully")));
//       } else {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text("Failed to add bus")));
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Network error: $e")));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope( onWillPop: ()async{
//       Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewBusPage(title: '')));
//       return false;
//     },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Add Bus"),
//           backgroundColor: Colors.blue,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 TextField(
//                   controller: busnamecontroller,
//                   decoration: InputDecoration(labelText: "Bus Name"),
//                 ),
//                 SizedBox(height: 10),
//
//                 TextField(
//                   controller: reg_nocontroller,
//                   decoration: InputDecoration(labelText: "Registration No"),
//                 ),
//                 SizedBox(height: 10),
//
//                 // FROM ROUTE DROPDOWN
//                 DropdownButtonFormField<String>(
//                   decoration: InputDecoration(labelText: "From Route"),
//                   value: selectedFromID,
//                   items: routes.map<DropdownMenuItem<String>>((route) {
//                     return DropdownMenuItem<String>(
//                       value: route['id'].toString(),      // ✔ Correct
//                       child: Text(route['starting']),     // ✔ Correct
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedFromID = value;
//                     });
//                   },
//                 ),
//
//
//                 SizedBox(height: 10),
//
//                 // TO ROUTE DROPDOWN
//                 DropdownButtonFormField<String>(
//                   decoration: InputDecoration(labelText: "To Route"),
//                   value: selectedToID,
//                   items: routes.map<DropdownMenuItem<String>>((route) {
//                     return DropdownMenuItem<String>(
//                       value: route['id'].toString(),      // ✔ Correct
//                       child: Text(route['destination']),  // ✔ Correct
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedToID = value;
//                     });
//                   },
//                 ),
//
//                 SizedBox(height: 10),
//
//                 TextField(
//                   controller: descriptioncontroller,
//                   decoration: InputDecoration(labelText: "Description"),
//                 ),
//                 SizedBox(height: 20),
//
//                 ElevatedButton(
//                   onPressed: sendData,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
//                   ),
//                   child: Text("Submit", style: TextStyle(color: Colors.white)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ksrtc/DRIVER/driverhome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'driver viewbus.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AddBus(),
  ));
}

class AddBus extends StatefulWidget {
  const AddBus({super.key});

  @override
  State<AddBus> createState() => _AddBusState();
}

class _AddBusState extends State<AddBus> {
  final TextEditingController busNameController = TextEditingController();
  final TextEditingController regNoController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<dynamic> routes = [];
  String? selectedFromID;
  String? selectedToID;

  bool _isLoading = true;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _fetchRoutes();
  }

  Future<void> _fetchRoutes() async {
    setState(() => _isLoading = true);

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? baseUrl = sh.getString('url');

      if (baseUrl == null || baseUrl.isEmpty) {
        Fluttertoast.showToast(msg: "Server URL not configured");
        return;
      }

      final uri = Uri.parse("$baseUrl/driver_get_bus_root/");
      final res = await http.post(uri);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data['status'] == 'ok') {
          setState(() {
            routes = data['data'] ?? [];
          });
        } else {
          Fluttertoast.showToast(msg: data['message'] ?? "Failed to load routes");
        }
      } else {
        Fluttertoast.showToast(msg: "Server error (${res.statusCode})");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error fetching routes");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _addBus() async {
    final busName = busNameController.text.trim();
    final regNo = regNoController.text.trim();
    final desc = descriptionController.text.trim();

    if (busName.isEmpty || regNo.isEmpty || selectedFromID == null || selectedToID == null || desc.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all fields");
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

      final uri = Uri.parse("$baseUrl/add_bus/");

      final response = await http.post(uri, body: {
        'lid': lid,
        'busname': busName,
        'reg_no': regNo,
        'fromroute': selectedFromID!,
        'toroute': selectedToID!,
        'description': desc,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'ok') {
          Fluttertoast.showToast(msg: "Bus added successfully");
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => ViewBusPage(title: '')),
            );
          }
        } else {
          Fluttertoast.showToast(msg: data['message'] ?? "Failed to add bus");
        }
      } else {
        Fluttertoast.showToast(msg: "Server error (${response.statusCode})");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Network error");
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
          MaterialPageRoute(builder: (_) => driverHomePage()),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0D1117),
        appBar: AppBar(
          title: const Text('Add New Bus'),
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
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
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

                const Text(
                  'Register a New Bus',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add bus details & assign routes',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[400],
                  ),
                ),

                const SizedBox(height: 40),

                _buildTextField(
                  controller: busNameController,
                  label: 'Bus Name',
                  hint: 'Enter bus name / service name',
                  icon: Icons.directions_bus_outlined,
                ),
                const SizedBox(height: 24),

                _buildTextField(
                  controller: regNoController,
                  label: 'Registration Number',
                  hint: 'KL-07-AB-1234',
                  icon: Icons.confirmation_number_outlined,
                ),
                const SizedBox(height: 24),

                // From Route Dropdown
                DropdownButtonFormField<String>(
                  value: selectedFromID,
                  decoration: InputDecoration(
                    labelText: 'From Route',
                    labelStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: const Icon(Icons.location_on_outlined, color: Colors.grey),
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
                  ),
                  dropdownColor: const Color(0xFF1E252E),
                  style: const TextStyle(color: Colors.white),
                  items: routes.map<DropdownMenuItem<String>>((route) {
                    return DropdownMenuItem<String>(
                      value: route['id'].toString(),
                      child: Text(
                        route['starting'] ?? 'Unknown',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => selectedFromID = value);
                  },
                ),
                const SizedBox(height: 24),

                // To Route Dropdown
                DropdownButtonFormField<String>(
                  value: selectedToID,
                  decoration: InputDecoration(
                    labelText: 'To Route',
                    labelStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: const Icon(Icons.location_on_outlined, color: Colors.grey),
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
                  ),
                  dropdownColor: const Color(0xFF1E252E),
                  style: const TextStyle(color: Colors.white),
                  items: routes.map<DropdownMenuItem<String>>((route) {
                    return DropdownMenuItem<String>(
                      value: route['id'].toString(),
                      child: Text(
                        route['destination'] ?? 'Unknown',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => selectedToID = value);
                  },
                ),
                const SizedBox(height: 24),

                _buildTextField(
                  controller: descriptionController,
                  label: 'Description',
                  hint: 'Additional notes / route info',
                  icon: Icons.description_outlined,
                  maxLines: 3,
                ),

                const SizedBox(height: 50),

                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _addBus,
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
                      'ADD BUS',
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
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    IconData? icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
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
    );
  }

  @override
  void dispose() {
    busNameController.dispose();
    regNoController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}