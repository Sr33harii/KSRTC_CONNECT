// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:ksrtc/user/seatlayout.dart';
// import 'package:ksrtc/user/viewseatselection.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class BusListPage extends StatefulWidget {
//   final String fromStop;
//   final String toStop;
//
//   const BusListPage({super.key, required this.fromStop, required this.toStop});
//
//   @override
//   State<BusListPage> createState() => _BusListPageState();
// }
//
// class _BusListPageState extends State<BusListPage> {
//   List buses = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchBuses();
//   }
//
//   void fetchBuses() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//
//     final response = await http.post(
//       Uri.parse("$url/search_buses/"),
//       body: {
//         "from_stop": widget.fromStop,
//         "to_stop": widget.toStop,
//       },
//     );
//
//     var data = jsonDecode(response.body);
//
//     if (data["status"] == "ok") {
//       setState(() {
//         buses = data["data"];
//       });
//     } else {
//       Fluttertoast.showToast(msg: data["message"]);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Available Buses")),
//       body: buses.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//         itemCount: buses.length,
//         itemBuilder: (context, index) {
//           var bus = buses[index];
//           return Card(
//             child: ListTile(
//               title: Text(bus["busname"]),
//               subtitle: Text("Driver: ${bus['driver']}"),
//               trailing: Text("₹${bus['price']}"),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                     MaterialPageRoute(
//                       builder: (_) => SeatViewPageSelection(
//                         busId: bus["id"].toString(),
//                         price: double.tryParse(bus['price'].toString()) ?? 0.0,
//                       ),
//                     ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ksrtc/user/seatlayout.dart';
import 'package:ksrtc/user/viewseatselection.dart';

class BusListPage extends StatefulWidget {
  final String fromStop;
  final String toStop;

  const BusListPage({super.key, required this.fromStop, required this.toStop});

  @override
  State<BusListPage> createState() => _BusListPageState();
}

class _BusListPageState extends State<BusListPage> {
  List buses = [];

  @override
  void initState() {
    super.initState();
    fetchBuses();
  }

  void fetchBuses() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url') ?? '';

    if (url.isEmpty) {
      Fluttertoast.showToast(msg: "Server URL not found");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("$url/search_buses/"),
        body: {
          "from_stop": widget.fromStop,
          "to_stop": widget.toStop,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data["status"] == "ok") {
          setState(() {
            buses = data["data"] ?? [];
          });
        } else {
          Fluttertoast.showToast(msg: data["message"] ?? "No buses found");
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
        title: const Text("Available Buses"),
        centerTitle: true,
        backgroundColor: const Color(0xFF111116),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: buses.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.directions_bus_outlined,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              "No buses available",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Try different stops or check back later",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: buses.length,
        itemBuilder: (context, index) {
          var bus = buses[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 0,
            color: const Color(0xFF1E1E24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Color(0xFF2D2D35), width: 0.8),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SeatViewPageSelection(
                      busId: bus["id"].toString(),
                      price: double.tryParse(bus['price']?.toString() ?? '0') ?? 0.0,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.directions_bus_rounded,
                        color: Color(0xFFEF4444),
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bus["busname"] ?? "Unknown Bus",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Driver: ${bus['driver'] ?? 'N/A'}",
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "₹${bus['price'] ?? '0'}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF22D3EE),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey,
                          size: 18,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}