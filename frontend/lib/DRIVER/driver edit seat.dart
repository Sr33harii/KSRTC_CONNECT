// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'driver view seat.dart';
// import 'driver viewbus.dart';
//
// class EditSeatDetails extends StatefulWidget {
//   const EditSeatDetails({super.key});
//
//   @override
//   State<EditSeatDetails> createState() => _EditSeatDetailsState();
// }
//
// class _EditSeatDetailsState extends State<EditSeatDetails> {
//   TextEditingController seat_nocontroller = TextEditingController();
//   TextEditingController seat_typecontroller = TextEditingController();
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     _get_data();
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
//       String seid = sh.getString('seid') ?? '';
//
//       final uri = Uri.parse("$url/driver_edit_seat/");
//
//       final response = await http.post(uri, body: {
//         'seid': seid,
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
//
//   void _get_data() async{
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String bid = sh.getString('seid').toString();
//
//     final urls = Uri.parse('$url/driver_edit_seat_get/');
//     try {
//       final response = await http.post(urls, body: {
//         'seid':bid
//
//
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status=='ok') {
//           String seatno=jsonDecode(response.body)['seat_no'];
//           String seattype=jsonDecode(response.body)['seat_type'];
//
//
//           setState(() {
//             seat_nocontroller.text= seatno;
//             seat_typecontroller.text= seattype;
//
//           });
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
//
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope( onWillPop: ()async{
//       Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewSeatDetailsPage(title: '',)));
//       return false;
//     },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Edit Seat Details"),
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
//



import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'driver view seat.dart';
import 'driver viewbus.dart';

class EditSeatDetails extends StatefulWidget {
  const EditSeatDetails({super.key});

  @override
  State<EditSeatDetails> createState() => _EditSeatDetailsState();
}

class _EditSeatDetailsState extends State<EditSeatDetails> {
  TextEditingController seat_nocontroller = TextEditingController();
  TextEditingController seat_typecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _get_data();
  }

  Future<void> sendData() async {
    if (seat_nocontroller.text.isEmpty || seat_typecontroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url') ?? '';
      String bid = sh.getString('bid') ?? '';
      String seid = sh.getString('seid') ?? '';

      final uri = Uri.parse("$url/driver_edit_seat/");

      final response = await http.post(uri, body: {
        'seid': seid,
        'seat_no': seat_nocontroller.text,
        'seat_type': seat_typecontroller.text,
      });

      var data = jsonDecode(response.body);

      if (data['status'] == 'ok') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("seat Updated Successfully")),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewSeatDetailsPage(title: '')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update seat")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Network error: $e")),
      );
    }
  }

  void _get_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String seid = sh.getString('seid').toString();

    final urls = Uri.parse('$url/driver_edit_seat_get/');
    try {
      final response = await http.post(urls, body: {'seid': seid});

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String seatno = jsonDecode(response.body)['seat_no'];
          String seattype = jsonDecode(response.body)['seat_type'];

          setState(() {
            seat_nocontroller.text = seatno;
            seat_typecontroller.text = seattype;
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ViewSeatDetailsPage(title: '')),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0D1117),
        appBar: AppBar(
          title: const Text("Edit Seat Details"),
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

                // Logo (same as other screens)
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
                  'Edit Seat',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Update seat number & type',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[400],
                  ),
                ),

                const SizedBox(height: 50),

                _buildTextField(
                  controller: seat_nocontroller,
                  label: 'Seat Number',
                  hint: 'e.g. A1, 12, U5, L4',
                  icon: Icons.event_seat_outlined,
                ),
                const SizedBox(height: 24),

                _buildTextField(
                  controller: seat_typecontroller,
                  label: 'Seat Type',
                  hint: 'e.g. Sleeper, Seater, Semi-Sleeper, Ladies',
                  icon: Icons.category_outlined,
                ),

                const SizedBox(height: 50),

                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: sendData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE63946),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      "UPDATE SEAT",
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
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[400]),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(icon, color: Colors.grey[400]),
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
}