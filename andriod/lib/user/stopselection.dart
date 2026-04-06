// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'buslist.dart';
//
// class StopSelectionPage extends StatefulWidget {
//   const StopSelectionPage({super.key});
//
//   @override
//   State<StopSelectionPage> createState() => _StopSelectionPageState();
// }
//
// class _StopSelectionPageState extends State<StopSelectionPage> {
//   List stops = [];
//   String? fromStop, toStop;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchStops();
//   }
//
//   void fetchStops() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//
//     final response = await http.get(Uri.parse("$url/get_stops/"));
//
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       if (data["status"] == "ok") {
//         setState(() {
//           stops = data["data"];
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Select Stops")),
//       body: stops.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             DropdownButtonFormField(
//               value: fromStop,
//               items: stops.map<DropdownMenuItem<String>>((s) {
//                 return DropdownMenuItem(
//                   value: s["id"].toString(),
//                   child: Text(s["stop"]),
//                 );
//               }).toList(),
//               onChanged: (v) => setState(() => fromStop = v),
//               decoration: const InputDecoration(labelText: "From Stop"),
//             ),
//             const SizedBox(height: 20),
//             DropdownButtonFormField(
//               value: toStop,
//               items: stops.map<DropdownMenuItem<String>>((s) {
//                 return DropdownMenuItem(
//                   value: s["id"].toString(),
//                   child: Text(s["stop"]),
//                 );
//               }).toList(),
//               onChanged: (v) => setState(() => toStop = v),
//               decoration: const InputDecoration(labelText: "To Stop"),
//             ),
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 if (fromStop == null || toStop == null) {
//                   Fluttertoast.showToast(msg: "Select both stops");
//                   return;
//                 }
//
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => BusListPage(
//                       fromStop: fromStop!,
//                       toStop: toStop!,
//                     ),
//                   ),
//                 );
//               },
//               child: const Text("Search Buses"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'buslist.dart';

class StopSelectionPage extends StatefulWidget {
  const StopSelectionPage({super.key});

  @override
  State<StopSelectionPage> createState() => _StopSelectionPageState();
}

class _StopSelectionPageState extends State<StopSelectionPage> {
  List stops = [];
  String? fromStop, toStop;

  @override
  void initState() {
    super.initState();
    fetchStops();
  }

  void fetchStops() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url') ?? '';

    if (url.isEmpty) {
      Fluttertoast.showToast(msg: "Server URL not found");
      return;
    }

    try {
      final response = await http.get(Uri.parse("$url/get_stops/"));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["status"] == "ok") {
          setState(() {
            stops = data["data"] ?? [];
          });
        } else {
          Fluttertoast.showToast(msg: data["message"] ?? "No stops found");
        }
      } else {
        Fluttertoast.showToast(msg: "Network Error (${response.statusCode})");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F12),
      appBar: AppBar(
        title: const Text("Select Stops"),
        centerTitle: true,
        backgroundColor: const Color(0xFF111116),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: stops.isEmpty
          ? const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFEF4444),
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            // Header
            const Text(
              "Choose Your Journey",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Select departure and arrival stops",
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 40),

            // From Stop Dropdown
            _buildDropdown(
              label: "From Stop",
              value: fromStop,
              onChanged: (v) => setState(() => fromStop = v),
              hint: "Select departure stop",
            ),

            const SizedBox(height: 24),

            // To Stop Dropdown
            _buildDropdown(
              label: "To Stop",
              value: toStop,
              onChanged: (v) => setState(() => toStop = v),
              hint: "Select arrival stop",
            ),

            const SizedBox(height: 48),

            // Search Button
            SizedBox(
              height: 54,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.search_rounded),
                label: const Text(
                  "Search Buses",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF4444),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  if (fromStop == null || toStop == null) {
                    Fluttertoast.showToast(msg: "Please select both stops");
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BusListPage(
                        fromStop: fromStop!,
                        toStop: toStop!,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required ValueChanged<String?> onChanged,
    required String hint,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint, style: TextStyle(color: Colors.grey[500])),
      items: stops.map<DropdownMenuItem<String>>((s) {
        return DropdownMenuItem<String>(
          value: s["id"]?.toString(),
          child: Text(
            s["stop"]?.toString() ?? "Unknown Stop",
            style: const TextStyle(color: Colors.white),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      dropdownColor: const Color(0xFF1E1E24),
      style: const TextStyle(color: Colors.white),
      iconEnabledColor: const Color(0xFFEF4444),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[400]),
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
    );
  }
}