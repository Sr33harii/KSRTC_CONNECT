// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:ksrtc/DRIVER/driver%20edit%20profile.dart';
// import 'package:ksrtc/DRIVER/driverchangepassword.dart';
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'driver add seat.dart';
// import 'driver edit seat.dart';
// import 'driver viewbus.dart';
//
// void main() {
//   runApp(const ViewSeatDetails());
// }
//
// class ViewSeatDetails extends StatelessWidget {
//   const ViewSeatDetails({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'View Seat Details',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const ViewSeatDetailsPage(title: 'View Profile'),
//     );
//   }
// }
//
// class ViewSeatDetailsPage extends StatefulWidget {
//
//   const ViewSeatDetailsPage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<ViewSeatDetailsPage> createState() => _ViewSeatDetailsPageState();
// }
//
// class _ViewSeatDetailsPageState extends State<ViewSeatDetailsPage> {
//   List<Map<dynamic, dynamic>> seat = [];
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _send_data();
//   }
//
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => ViewBusPage(title: '',)));
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           leading: BackButton(),
//           backgroundColor: Theme
//               .of(context)
//               .colorScheme
//               .primary,
//           title: Text(widget.title),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: seat.map((i) {
//               return Card(
//                 child: Container(
//                   width: double.infinity,
//                   color: Colors.amber,
//                   padding: EdgeInsets.all(40),
//                   child: Column(
//                     children: [
//                       Text(i['seatno']),
//                       Text(i['seattype']),
//
//                     ],
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(onPressed: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => AddSeatDetails()));
//         }, child: Icon(Icons.add),),
//       ),
//     );
//   }
//
//
//   void _send_data() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String bid = sh.getString('bid').toString();
//
//     final urls = Uri.parse('$url/driver_view_seat/');
//
//     try {
//       final response = await http.post(
//         urls,
//         body: {'bid': bid},
//       );
//
//       if (response.statusCode == 200) {
//         var jsondata = jsonDecode(response.body);
//
//         if (jsondata['status'] == 'ok') {
//           List<Map<String, dynamic>> temp = [];
//
//           for (var i in jsondata['data']) {
//             temp.add({
//               'id': i['id'].toString(),
//               'seatno': i['seatno'].toString(),
//               'seattype': i['seattype'].toString(),
//             });
//           }
//
//           setState(() {
//             seat = temp;
//           });
//         } else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'driver add seat.dart';
import 'driver edit seat.dart';
import 'driver viewbus.dart';

// Uncomment your actual imports
// import 'package:ksrtc/DRIVER/driver edit profile.dart';
// import 'package:ksrtc/DRIVER/driverchangepassword.dart';
// import 'driver add seat.dart';
// import 'driver edit seat.dart';
// import 'driver viewbus.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ViewSeatDetailsPage(title: 'Seat Details'),
  ));
}

class ViewSeatDetailsPage extends StatefulWidget {
  const ViewSeatDetailsPage({super.key, required this.title});
  final String title;

  @override
  State<ViewSeatDetailsPage> createState() => _ViewSeatDetailsPageState();
}

class _ViewSeatDetailsPageState extends State<ViewSeatDetailsPage> {
  List<Map<String, dynamic>> seats = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSeats();
  }

  Future<void> _fetchSeats() async {
    setState(() => _isLoading = true);

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? baseUrl = sh.getString('url');
      String? bid = sh.getString('bid');

      if (baseUrl == null || bid == null || baseUrl.isEmpty) {
        Fluttertoast.showToast(msg: "Session or bus not selected");
        return;
      }

      final uri = Uri.parse('$baseUrl/driver_view_seat/');

      final response = await http.post(uri, body: {'bid': bid});

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['status'] == 'ok') {
          List<Map<String, dynamic>> temp = [];
          for (var item in jsonData['data'] ?? []) {
            temp.add({
              'id': item['id']?.toString() ?? '',
              'seatno': item['seatno']?.toString() ?? '—',
              'seattype': item['seattype']?.toString() ?? 'Unknown',
            });
          }
          setState(() {
            seats = temp;
          });
        } else {
          Fluttertoast.showToast(
            msg: jsonData['message'] ?? 'No seats found',
          );
        }
      } else {
        Fluttertoast.showToast(msg: "Server error (${response.statusCode})");
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
          MaterialPageRoute(builder: (_) => ViewBusPage(title: '')),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0D1117),
        appBar: AppBar(
          title: const Text('Seat Details'),
          centerTitle: true,
          backgroundColor: const Color(0xFF161B22),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Logo + Title
              Center(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.network(
                        'https://toppng.com/uploads/preview/ksrtc-logo-11562902896j2j2j2j2j2.png',
                        height: 80,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 80,
                          width: 80,
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
                      'Bus Seat Configuration',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Manage seats for selected bus',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              if (_isLoading)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: Color(0xFFE63946)),
                  ),
                )
              else if (seats.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.event_seat_rounded,
                            size: 80, color: Colors.grey[700]),
                        const SizedBox(height: 16),
                        const Text(
                          'No seats added yet',
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Tap + to add new seats',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: seats.length,
                    itemBuilder: (context, index) {
                      final seat = seats[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        color: const Color(0xFF161B22),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                              color: const Color(0xFFE63946).withOpacity(0.15)),
                        ),
                        elevation: 3,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFFE63946).withOpacity(0.2),
                            radius: 26,
                            child: const Icon(
                              Icons.event_seat_rounded,
                              color: Color(0xFFE63946),
                            ),
                          ),
                          title: Text(
                            "Seat ${seat['seatno']}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              "Type: ${seat['seattype']}",
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit, color: Color(0xFF3B82F6)),
                            onPressed: () async{
                              SharedPreferences sh =await SharedPreferences.getInstance();
                              sh.setString("seid", seat['id'].toString());
                              // You can pass seat['id'] if you want to edit
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EditSeatDetails(),
                                  // builder: (_) => EditSeatDetails(seatId: seat['id']),
                                ),
                              );
                              // Fluttertoast.showToast(msg: "Edit feature coming soon");
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFFE63946),
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddSeatDetails()),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
