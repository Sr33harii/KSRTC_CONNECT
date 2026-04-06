// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'driver view seat.dart';
// import 'driver viewbus.dart';
//
// class AddSeatDetails extends StatefulWidget {
//   const AddSeatDetails({super.key});
//
//   @override
//   State<AddSeatDetails> createState() => _AddSeatDetailsState();
// }
//
// class _AddSeatDetailsState extends State<AddSeatDetails> {
//   TextEditingController seat_nocontroller = TextEditingController();
//   TextEditingController seat_typecontroller = TextEditingController();
//
//
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   // Fetch route list
//
//   // Send to backend
//   Future<void> sendData() async {
//     if (seat_nocontroller.text.isEmpty ||
//         seat_typecontroller.text.isEmpty ) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Please fill all fields")));
//       return;
//     }
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url') ?? '';
//       String bid = sh.getString('bid') ?? '';
//
//       final uri = Uri.parse("$url/driver_add_seat/");
//
//       final response = await http.post(uri, body: {
//         'bid': bid,
//         'seat_no': seat_nocontroller.text,
//         'seat_type': seat_typecontroller.text,
//       });
//
//       var data = jsonDecode(response.body);
//
//       if (data['status'] == 'ok') {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text("seat Added Successfully")));
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewBusPage(title: '',)));
//       } else {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text("Failed to add seat")));
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
//       Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewSeatDetailsPage(title: '',)));
//       return false;
//     },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Add Seat Details"),
//           backgroundColor: Colors.blue,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 TextField(
//                   controller: seat_nocontroller,
//                   decoration: InputDecoration(labelText: "Seat No"),
//                 ),
//                 SizedBox(height: 10),
//
//                 TextField(
//                   controller: seat_typecontroller,
//                   decoration: InputDecoration(labelText: "Seat type"),
//                 ),
//
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'driver view seat.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AddSeatDetails(),
  ));
}

class AddSeatDetails extends StatefulWidget {
  const AddSeatDetails({super.key});

  @override
  State<AddSeatDetails> createState() => _AddSeatDetailsState();
}

class _AddSeatDetailsState extends State<AddSeatDetails> {
  final TextEditingController seatNoController = TextEditingController();
  final TextEditingController seatTypeController = TextEditingController();

  bool _isSubmitting = false;

  Future<void> _addSeat() async {
    final seatNo = seatNoController.text.trim();
    final seatType = seatTypeController.text.trim();

    if (seatNo.isEmpty || seatType.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all fields");
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? baseUrl = sh.getString('url');
      String? bid = sh.getString('bid');

      if (baseUrl == null || bid == null || baseUrl.isEmpty) {
        Fluttertoast.showToast(msg: "Session or bus not selected");
        return;
      }

      final uri = Uri.parse("$baseUrl/driver_add_seat/");

      final response = await http.post(uri, body: {
        'bid': bid,
        'seat_no': seatNo,
        'seat_type': seatType,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'ok') {
          Fluttertoast.showToast(msg: "Seat added successfully");
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => ViewSeatDetailsPage(title: '')),
            );
          }
        } else {
          Fluttertoast.showToast(msg: data['message'] ?? "Failed to add seat");
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
          MaterialPageRoute(builder: (_) => ViewSeatDetailsPage(title: '')),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0D1117),
        appBar: AppBar(
          title: const Text('Add New Seat'),
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
                  'Add Seat to Bus',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter seat number & type',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[400],
                  ),
                ),

                const SizedBox(height: 50),

                _buildTextField(
                  controller: seatNoController,
                  label: 'Seat Number',
                  hint: 'e.g. A1, 12, U5, L4',
                  icon: Icons.event_seat_outlined,
                ),
                const SizedBox(height: 24),

                _buildTextField(
                  controller: seatTypeController,
                  label: 'Seat Type',
                  hint: 'e.g. Sleeper, Seater, Semi-Sleeper, Ladies',
                  icon: Icons.category_outlined,
                ),

                const SizedBox(height: 50),

                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _addSeat,
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
                      'ADD SEAT',
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
  }) {
    return TextField(
      controller: controller,
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
    seatNoController.dispose();
    seatTypeController.dispose();
    super.dispose();
  }
}