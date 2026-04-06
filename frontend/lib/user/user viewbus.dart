// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:ksrtc/user/user%20home.dart';
// import 'package:ksrtc/user/user%20view%20avail%20seat.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
//
// import 'user view seat.dart';
//
//
//
//
//
// void main() {
//   runApp(const UserViewBus());
// }
//
// class UserViewBus extends StatelessWidget {
//   const UserViewBus({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: UserViewBusPage(title: 'View Users'),
//     );
//   }
// }
//
// class UserViewBusPage extends StatefulWidget {
//   const UserViewBusPage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<UserViewBusPage> createState() => _UserViewBusPageState();
// }
//
// class _UserViewBusPageState extends State<UserViewBusPage> {
//   List<Map<String, dynamic>> users = [];
//   List<Map<String, dynamic>> filteredUsers = [];
//   List<String> nameSuggestions = [];
//
//   @override
//   void initState() {
//     super.initState();
//     viewUsers("");
//   }
//
//   Future<void> viewUsers(String searchValue) async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url') ?? '';
//       String apiUrl = '$urls/user_view_bus/';
//
//       var response = await http.post(Uri.parse(apiUrl), body: {
//       });
//       var jsonData = json.decode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         List<Map<String, dynamic>> tempList = [];
//         for (var item in jsonData['data']) {
//           tempList.add({
//             'id': item['id'].toString(),
//             'busname': item['busname'],
//             'reg_no': item['reg_no'],
//             'FromROUTE': item['FromROUTE'],
//             'To_ROUTE': item['To_ROUTE'],
//             'description': item['description'],
//             'latitude': item['lat'],
//             'longitude': item['long'],
//           });
//         }
//         setState(() {
//           users = tempList;
//
//         });
//       }
//     } catch (e) {
//       print("Error fetching users: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//         onWillPop: () async {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) =>UserHomePage()),
//           );
//           return false; // Prevent default pop
//         },
//         child:Scaffold(
//           appBar: AppBar(
//             backgroundColor: Color.fromARGB(255, 232, 177, 61),
//             title: Text('Bus'),
//             // onSearch: (value) {
//             //   setState(() {
//             //     filteredUsers = users
//             //         .where((user) => user['name']
//             //         .toString()
//             //         .toLowerCase()
//             //         .contains(value.toLowerCase()))
//             //         .toList();
//             //   });
//             // },
//           ),
//           body: ListView.builder(
//             shrinkWrap: true,
//             physics: BouncingScrollPhysics(),
//             itemCount: users.length,
//             itemBuilder: (context, index) {
//               final user = users[index];
//               return Card(
//                 margin: const EdgeInsets.all(10),
//                 elevation: 5,
//                 child: ListTile(
//                   // leading: CircleAvatar(
//                   //   backgroundImage: NetworkImage(user['photo']),
//                   //   radius: 30,
//                   // ),
//                   title: Text(user['busname'], style: TextStyle(fontWeight: FontWeight.bold)),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Bus Name: ${user['busname']}"),
//                       Text("Reg No: ${user['reg_no']}"),
//                       Text("From ROUTE: ${user['FromROUTE']}"),
//                       Text("To ROUTE : ${user['To_ROUTE']}"),
//                       Text("Description: ${user['description']}"),
//
//
//                       ElevatedButton(onPressed: ()async{
//                         SharedPreferences sh=await SharedPreferences.getInstance();
//                         sh.setString("bid", user['id']);
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>UserViewAvailableSeat()));
//                       }, child: Text('Seat')),
//                       ElevatedButton(onPressed: () async {
//                         if (!await launchUrl(Uri.parse("https://maps.google.com/?q=${user['latitude']},${user['longitude']}"))) {
//                         throw Exception('Could not launch ');
//                         }
//
//                       }, child: Text('Track'))
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//
//         ));
//   }
// }



// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:ksrtc/user/seatlayout.dart';
// import 'package:ksrtc/user/user%20home.dart';
// import 'package:ksrtc/user/user%20view%20avail%20seat.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
//
// import 'user view seat.dart';
//
// void main() {
//   runApp(const UserViewBus());
// }
//
// class UserViewBus extends StatelessWidget {
//   const UserViewBus({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: UserViewBusPage(title: 'View Buses'),
//     );
//   }
// }
//
// class UserViewBusPage extends StatefulWidget {
//   const UserViewBusPage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<UserViewBusPage> createState() => _UserViewBusPageState();
// }
//
// class _UserViewBusPageState extends State<UserViewBusPage> {
//   List<Map<String, dynamic>> users = [];
//   List<Map<String, dynamic>> filteredUsers = [];
//   List<String> nameSuggestions = [];
//
//   @override
//   void initState() {
//     super.initState();
//     viewUsers("");
//   }
//
//   Future<void> viewUsers(String searchValue) async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url') ?? '';
//       String apiUrl = '$urls/user_view_bus/';
//
//       var response = await http.post(Uri.parse(apiUrl), body: {});
//       var jsonData = json.decode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         List<Map<String, dynamic>> tempList = [];
//         for (var item in jsonData['data']) {
//           tempList.add({
//             'id': item['id'].toString(),
//             'busname': item['busname'],
//             'reg_no': item['reg_no'],
//             'FromROUTE': item['FromROUTE'],
//             'To_ROUTE': item['To_ROUTE'],
//             'description': item['description'],
//             'latitude': item['lat'],
//             'longitude': item['long'],
//           });
//         }
//         setState(() {
//           users = tempList;
//         });
//       }
//     } catch (e) {
//       print("Error fetching buses: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => UserHomePage()),
//         );
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: const Color(0xFF0F0F12),
//         appBar: AppBar(
//           title: const Text("Buses"),
//           centerTitle: true,
//           backgroundColor: const Color(0xFF111116),
//           foregroundColor: Colors.white,
//           elevation: 0,
//         ),
//         body: users.isEmpty
//             ? const Center(
//           child: CircularProgressIndicator(
//             color: Color(0xFFEF4444),
//           ),
//         )
//             : ListView.builder(
//           padding: const EdgeInsets.all(16),
//           physics: const BouncingScrollPhysics(),
//           itemCount: users.length,
//           itemBuilder: (context, index) {
//             final bus = users[index];
//             return Card(
//               margin: const EdgeInsets.only(bottom: 16),
//               elevation: 0,
//               color: const Color(0xFF1E1E24),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 side: const BorderSide(color: Color(0xFF2D2D35), width: 0.8),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFEF4444).withOpacity(0.15),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: const Icon(
//                             Icons.directions_bus_rounded,
//                             color: Color(0xFFEF4444),
//                             size: 28,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 bus['busname'] ?? "Unknown Bus",
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 "Reg No: ${bus['reg_no'] ?? '-'}",
//                                 style: TextStyle(
//                                   color: Colors.grey[400],
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     _buildDetailRow("From", bus['FromROUTE'] ?? "-"),
//                     _buildDetailRow("To", bus['To_ROUTE'] ?? "-"),
//                     _buildDetailRow("Description", bus['description'] ?? "-"),
//                     const SizedBox(height: 20),
//
//                     Row(
//                       children: [
//                         Expanded(
//                           child: ElevatedButton.icon(
//                             icon: const Icon(Icons.event_seat_rounded, size: 18),
//                             label: const Text("View Seats"),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFFEF4444),
//                               foregroundColor: Colors.white,
//                               padding: const EdgeInsets.symmetric(vertical: 12),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               elevation: 0,
//                             ),
//                             onPressed: () async {
//                               SharedPreferences sh = await SharedPreferences.getInstance();
//                               sh.setString("bid", bus['id']);
//                               // Navigator.push(
//                               //   context,
//                               //   MaterialPageRoute(
//                               //     builder: (context) => UserViewAvailableSeat(),
//                               //   ),
//                               // );
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => SeatViewPage(
//                                     busId: bus['id'],
//                                     price: 0, // backend calculates actual price
//                                   ),
//                                 ),
//                               );
//
//                             },
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: OutlinedButton.icon(
//                             icon: const Icon(Icons.location_searching_rounded, size: 18),
//                             label: const Text("Track Bus"),
//                             style: OutlinedButton.styleFrom(
//                               foregroundColor: const Color(0xFF22D3EE),
//                               side: const BorderSide(color: Color(0xFF22D3EE)),
//                               padding: const EdgeInsets.symmetric(vertical: 12),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             onPressed: () async {
//                               final url = Uri.parse(
//                                 "https://maps.google.com/?q=${bus['latitude']},${bus['longitude']}",
//                               );
//                               if (!await launchUrl(url)) {
//                                 throw Exception('Could not launch map');
//                               }
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 90,
//             child: Text(
//               label,
//               style: TextStyle(
//                 color: Colors.grey[400],
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ksrtc/user/seatlayout.dart';
import 'package:ksrtc/user/user home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'user view seat.dart';

void main() {
  runApp(const UserViewBus());
}

class UserViewBus extends StatelessWidget {
  const UserViewBus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserViewBusPage(title: 'View Buses'),
    );
  }
}

class UserViewBusPage extends StatefulWidget {
  const UserViewBusPage({super.key, required this.title});
  final String title;

  @override
  State<UserViewBusPage> createState() => _UserViewBusPageState();
}

class _UserViewBusPageState extends State<UserViewBusPage> {
  List<Map<String, dynamic>> users = [];

  Map<String, String> busDistance = {};
  Map<String, String> busEta = {};

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    viewUsers("");

    _timer = Timer.periodic(const Duration(seconds: 25), (_) {
      viewUsers("");
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // 🔎 Convert place name → lat/lon (FREE)
  Future<Map<String, double>?> geocodePlace(String place) async {
    final url = Uri.parse(
      "https://nominatim.openstreetmap.org/search"
          "?q=${Uri.encodeComponent(place)}&format=json&limit=1",
    );

    final res = await http.get(url, headers: {
      "User-Agent": "ksrtc-app" // Nominatim requires User-Agent
    });

    final data = json.decode(res.body);

    if (data == null || data.isEmpty) return null;

    return {
      "lat": double.parse(data[0]['lat']),
      "lon": double.parse(data[0]['lon']),
    };
  }

  // 🚗 Free road distance + ETA
  Future<Map<String, String>> getRouteInfoFree(
      double fromLat,
      double fromLng,
      double toLat,
      double toLng,
      ) async {
    final url = Uri.parse(
      "https://router.project-osrm.org/route/v1/driving/"
          "$fromLng,$fromLat;$toLng,$toLat?overview=false",
    );

    final res = await http.get(url);
    final data = json.decode(res.body);

    if (data['code'] != 'Ok') {
      return {"distance": "-", "duration": "-"};
    }

    final route = data['routes'][0];
    double distanceKm = route['distance'] / 1000;
    double durationMin = route['duration'] / 60;

    return {
      "distance": "${distanceKm.toStringAsFixed(2)} km",
      "duration": "${durationMin.toStringAsFixed(0)} mins",
    };
  }

  Future<void> viewUsers(String searchValue) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? '';
      String apiUrl = '$urls/user_view_bus/';

      var response = await http.post(Uri.parse(apiUrl), body: {});
      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        List<Map<String, dynamic>> tempList = [];

        for (var item in jsonData['data']) {
          tempList.add({
            'id': item['id'].toString(),
            'busname': item['busname'],
            'reg_no': item['reg_no'],
            'FromROUTE': item['FromROUTE'],
            'To_ROUTE': item['To_ROUTE'],
            'description': item['description'],
            'latitude': item['lat'],   // bus current lat
            'longitude': item['long'], // bus current long
          });
        }

        setState(() {
          users = tempList;
        });

        for (var bus in users) {
          final dest = await geocodePlace(bus['To_ROUTE']);

          if (dest == null) continue;

          final info = await getRouteInfoFree(
            double.parse(bus['latitude']),
            double.parse(bus['longitude']),
            dest['lat']!,
            dest['lon']!,
          );

          setState(() {
            busDistance[bus['id']] = info['distance']!;
            busEta[bus['id']] = info['duration']!;
          });
        }
      }
    } catch (e) {
      print("Error fetching buses: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserHomePage()),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0F0F12),
        appBar: AppBar(
          title: const Text("Buses"),
          centerTitle: true,
          backgroundColor: const Color(0xFF111116),
          foregroundColor: Colors.white,
        ),
        body: users.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final bus = users[index];
            return Card(
              color: const Color(0xFF1E1E24),
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bus['busname'],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Reg No: ${bus['reg_no']}",
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow("From", bus['FromROUTE']),
                    _buildDetailRow("To", bus['To_ROUTE']),
                    _buildDetailRow(
                      "Distance",
                      busDistance[bus['id']] ?? "Calculating...",
                    ),
                    _buildDetailRow(
                      "ETA",
                      busEta[bus['id']] ?? "Calculating...",
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              SharedPreferences sh =
                              await SharedPreferences.getInstance();
                              sh.setString("bid", bus['id']);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SeatViewPage(
                                    busId: bus['id'],
                                    price: 0,
                                  ),
                                ),
                              );
                            },
                            child: const Text("View Seats"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () async {
                              final url = Uri.parse(
                                "https://maps.google.com/?q=${bus['latitude']},${bus['longitude']}",
                              );
                              await launchUrl(url);
                            },
                            child: const Text("Track Bus"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey[400], fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}