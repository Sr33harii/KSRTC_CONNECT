// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:ksrtc/login.dart';
// import 'package:location/location.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'package:ksrtc/DRIVER/driver addbus.dart';
// import 'package:ksrtc/DRIVER/driver editbus.dart';
// import 'package:ksrtc/DRIVER/driver view profile.dart';
// import 'driver viewbus.dart';
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: driverHomePage(),
//   ));
// }
//
// class driverHomePage extends StatefulWidget {
//   const driverHomePage({super.key});
//
//   @override
//   State<driverHomePage> createState() => _driverHomePageState();
// }
//
// class _driverHomePageState extends State<driverHomePage> {
//   Timer? locationTimer;
//
//   @override
//   void initState() {
//     super.initState();
//     startLocationUpdates();
//   }
//
//   @override
//   void dispose() {
//     locationTimer?.cancel(); // STOP timer when leaving page
//     super.dispose();
//   }
//
//   // ----------------------------------------------------------
//   // FUNCTION: Start sending location every 10 seconds
//   // ----------------------------------------------------------
//   void startLocationUpdates() {
//     locationTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
//       sendLocationToDjango();
//     });
//   }
//
//   // ----------------------------------------------------------
//   // FUNCTION: Get Location + Lid + Send to Django
//   // ----------------------------------------------------------
//   Future<void> sendLocationToDjango() async {
//     try {
//       // Read lid from SharedPreferences
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? lid = prefs.getString('lid');
//
//       if (lid == null) {
//         print("LID not found in SharedPreferences");
//         return;
//       }
//
//       // Get location
//       Location location = Location();
//
//       bool serviceEnabled = await location.serviceEnabled();
//       if (!serviceEnabled) {
//         serviceEnabled = await location.requestService();
//         if (!serviceEnabled) return;
//       }
//
//       PermissionStatus permission = await location.hasPermission();
//       if (permission == PermissionStatus.denied) {
//         permission = await location.requestPermission();
//         if (permission != PermissionStatus.granted) return;
//       }
//
//       LocationData loc = await location.getLocation();
//
//       double? lat = loc.latitude;
//       double? lon = loc.longitude;
//
//       print("Sending -> LAT: $lat, LON: $lon, LID: $lid");
//       // String lid = sh.getString('lid').toString();
//       String urls = prefs.getString('url').toString();
//
//       final url = Uri.parse('$urls/driver_location_update/');
//
//       // Django API endpoint
//       // final url = Uri.parse("http://YOUR_DJANGO_SERVER/driver_location_update/");
//
//       final response = await http.post(url, body: {
//         "latitude": lat.toString(),
//         "longitude": lon.toString(),
//         "lid": lid,
//       });
//
//       if (response.statusCode == 200) {
//         print("Location Sent Successfully");
//       } else {
//         print("Error: ${response.body}");
//       }
//     } catch (e) {
//       print("Error sending location: $e");
//     }
//   }
//
//   // ----------------------------------------------------------
//   // UI PART
//   // ----------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.black87),
//       ),
//       backgroundColor: const Color(0xFFF5F6FA),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Row(
//               children: [
//                 CircleAvatar(
//                   backgroundImage: AssetImage('assets/user.jpg'),
//                   radius: 25,
//                 ),
//                 SizedBox(width: 12),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Hi Admin,',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       'What do you want to do today?',
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30),
//             const SizedBox(height: 25),
//             const Text(
//               'Quick Actions',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 15),
//
//             // Grid Buttons
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 15,
//                 mainAxisSpacing: 15,
//                 children: [
//                   ActionCard(
//                     title: 'View Profile',
//                     color: Colors.pinkAccent,
//                     icon: Icons.verified_user,
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (_) => driverViewProfile()));
//                     },
//                   ),
//                   ActionCard(
//                     title: 'Add Bus',
//                     color: Colors.deepPurple,
//                     icon: Icons.bus_alert,
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (_) => AddBus()));
//                     },
//                   ),
//                   ActionCard(
//                     title: 'View Bus',
//                     color: Colors.teal,
//                     icon: Icons.directions_bus,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => ViewBusPage(title: '')),
//                       );
//                     },
//                   ), ActionCard(
//                     title: 'Logout',
//                     color: Colors.teal,
//                     icon: Icons.directions_bus,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => MyLoginPage()),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ActionCard extends StatelessWidget {
//   final String title;
//   final Color color;
//   final IconData icon;
//   final VoidCallback? onTap;
//
//   const ActionCard({
//     super.key,
//     required this.title,
//     required this.color,
//     required this.icon,
//     this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CircleAvatar(
//               backgroundColor: color,
//               child: Icon(icon, color: Colors.white),
//             ),
//             const SizedBox(height: 10),
//             Text(title,
//                 style:
//                 const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
// // import 'package:flutter/material.dart';
// // import 'package:ksrtc/DRIVER/driver%20addbus.dart';
// // import 'package:ksrtc/DRIVER/driver%20editbus.dart';
// // import 'package:ksrtc/DRIVER/driver%20view%20profile.dart';
// //
// // import 'driver viewbus.dart';
// //
// //
// // void main() {
// //   runApp(const MaterialApp(
// //     debugShowCheckedModeBanner: false,
// //     home: driverHomePage(),
// //   ));
// // }
// //
// // class driverHomePage extends StatefulWidget {
// //   const driverHomePage({super.key});
// //
// //   @override
// //   State<driverHomePage> createState() => _driverHomePageState();
// // }
// //
// // class _driverHomePageState extends State<driverHomePage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       // drawer: const Drawer(
// //       //   child: DrawerContent(),
// //       // ),
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         iconTheme: const IconThemeData(color: Colors.black87),
// //         // actions: const [
// //         //   Icon(Icons.notifications_none),
// //         //   SizedBox(width: 16),
// //         // ],
// //       ),
// //       backgroundColor: const Color(0xFFF5F6FA),
// //       body: Padding(
// //         padding: const EdgeInsets.all(20.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const Row(
// //               children: [
// //                 CircleAvatar(
// //                   backgroundImage: AssetImage('assets/user.jpg'),
// //                   radius: 25,
// //                 ),
// //                 SizedBox(width: 12),
// //                 Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       'Hi Admin,',
// //                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                     ),
// //                     Text(
// //                       'What do you want to do today?',
// //                       style: TextStyle(color: Colors.black54),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 30),
// //             Container(
// //               padding: const EdgeInsets.all(20),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(20),
// //               ),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: const [
// //                   Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(''),
// //                       SizedBox(height: 6),
// //                       Text(
// //                         '',
// //                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                       ),
// //                     ],
// //                   ),
// //                   Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(''),
// //                       SizedBox(height: 6),
// //                       Text(
// //                         '',
// //                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(height: 25),
// //             const Text(
// //               'Quick Actions',
// //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
// //             ),
// //             const SizedBox(height: 15),
// //             Expanded(
// //               child: GridView.count(
// //                 crossAxisCount: 2,
// //                 crossAxisSpacing: 15,
// //                 mainAxisSpacing: 15,
// //                 children: [
// //                   ActionCard(
// //                     title: 'view profile',
// //                     color: Colors.pinkAccent,
// //                     icon: Icons.verified_user,
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(builder: (context) => driverViewProfile()),
// //                       );
// //                     },
// //                   ),
// //                   ActionCard(
// //                     title: 'add bus',
// //                     color: Colors.deepPurple,
// //                     icon: Icons.bus_alert,
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(builder: (context) =>AddBus()),
// //                       );
// //                     },
// //                   ),
// //                   ActionCard(
// //                     title: 'View bus',
// //                     color: Colors.deepPurple,
// //                     icon: Icons.bus_alert,
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(builder: (context) => ViewBusPage(title: '',)),
// //                       );
// //                     },
// //                   ),
// //                 ],
// //               ),
// //             ),
// //
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class ActionCard extends StatelessWidget {
// //   final String title;
// //   final Color color;
// //   final IconData icon;
// //   final VoidCallback? onTap; // ADD this
// //
// //   const ActionCard({
// //     super.key,
// //     required this.title,
// //     required this.color,
// //     required this.icon,
// //     this.onTap, // ADD this
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: onTap, // USE this
// //       child: Container(
// //         padding: const EdgeInsets.all(16),
// //         decoration: BoxDecoration(
// //           color: color.withOpacity(0.1),
// //           borderRadius: BorderRadius.circular(20),
// //         ),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             CircleAvatar(
// //               backgroundColor: color,
// //               child: Icon(icon, color: Colors.white),
// //             ),
// //             const SizedBox(height: 10),
// //             Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// //
// // // class DrawerContent extends StatefulWidget {
// // //   const DrawerContent({super.key});
// // //
// // //   @override
// // //   State<DrawerContent> createState() => _DrawerContentState();
// // // }
// //
// // // class _DrawerContentState extends State<DrawerContent> {
// // //   void showDrawerMessage(String message) {
// // //     Navigator.pop(context); // Close drawer
// // //     ScaffoldMessenger.of(context).showSnackBar(
// // //       SnackBar(content: Text(message)),
// // //     );
// // //   }
// // //
// // //   // @override
// // //   // Widget build(BuildContext context) {
// // //   //   return ListView(
// // //   //     padding: EdgeInsets.zero,
// // //   //     children: [
// // //   //       const DrawerHeader(
// // //   //         decoration: BoxDecoration(color: Colors.blue),
// // //   //         child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
// // //   //       ),
// // //   //       ListTile(
// // //   //         leading: const Icon(Icons.dashboard),
// // //   //         title: const Text('Dashboard'),
// // //   //         onTap: () => showDrawerMessage('Dashboard selected'),
// // //   //       ),
// // //   //       ListTile(
// // //   //         leading: const Icon(Icons.receipt),
// // //   //         title: const Text('Add User'),
// // //   //         onTap: () => showDrawerMessage('Bills selected'),
// // //   //       ),
// // //   //       ListTile(
// // //   //         leading: const Icon(Icons.send),
// // //   //         title: const Text('Transfers'),
// // //   //         onTap: () => showDrawerMessage('Transfers selected'),
// // //   //       ),
// // //   //       ListTile(
// // //   //         leading: const Icon(Icons.settings),
// // //   //         title: const Text('Settings'),
// // //   //         onTap: () => showDrawerMessage('Settings selected'),
// // //   //       ),
// // //   //     ],
// // //   //   );
// // //   // }
// // // }


import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ksrtc/login.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../user/user_viewprofile.dart';
import 'driver addbus.dart';
import 'driver view profile.dart';
import 'driver viewbus.dart';

// Uncomment your actual imports
// import 'package:ksrtc/DRIVER/driver addbus.dart';
// import 'package:ksrtc/DRIVER/driver editbus.dart';
// import 'package:ksrtc/DRIVER/driver view profile.dart';
// import 'driver viewbus.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: driverHomePage(),
  ));
}

class driverHomePage extends StatefulWidget {
  const driverHomePage({super.key});

  @override
  State<driverHomePage> createState() => _driverHomePageState();
}

class _driverHomePageState extends State<driverHomePage> {
  Timer? locationTimer;

  @override
  void initState() {
    super.initState();
    startLocationUpdates();
  }

  @override
  void dispose() {
    locationTimer?.cancel();
    super.dispose();
  }

  void startLocationUpdates() {
    locationTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      sendLocationToDjango();
    });
  }

  Future<void> sendLocationToDjango() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? lid = prefs.getString('lid');

      if (lid == null) {
        print("LID not found in SharedPreferences");
        return;
      }

      Location location = Location();

      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) return;
      }

      PermissionStatus permission = await location.hasPermission();
      if (permission == PermissionStatus.denied) {
        permission = await location.requestPermission();
        if (permission != PermissionStatus.granted) return;
      }

      LocationData loc = await location.getLocation();

      double? lat = loc.latitude;
      double? lon = loc.longitude;

      print("Sending -> LAT: $lat, LON: $lon, LID: $lid");

      String baseUrl = prefs.getString('url') ?? '';
      if (baseUrl.isEmpty) {
        print("Base URL not found");
        return;
      }

      final url = Uri.parse('$baseUrl/driver_location_update/');

      final response = await http.post(url, body: {
        "latitude": lat.toString(),
        "longitude": lon.toString(),
        "lid": lid,
      });

      if (response.statusCode == 200) {
        print("Location Sent Successfully");
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error sending location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        backgroundColor: const Color(0xFF161B22),
        elevation: 0,
        title: const Text(
          'Driver Dashboard',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MyLoginPage()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Logo + Greeting
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
                      'Welcome, Driver',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Manage your buses & routes',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Grid of Action Cards
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _buildActionCard(
                    title: 'View Profile',
                    icon: Icons.person_outline_rounded,
                    color: const Color(0xFFE63946),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => driverViewProfilePage(title: '',)));
                    },
                  ),
                  _buildActionCard(
                    title: 'Add Bus',
                    icon: Icons.add_road_rounded,
                    color: const Color(0xFF8B5CF6), // Purple-ish for variety
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => AddBus()));
                    },
                  ),
                  _buildActionCard(
                    title: 'View Bus',
                    icon: Icons.directions_bus_rounded,
                    color: const Color(0xFF10B981), // Teal/green
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ViewBusPage(title: '')));
                    },
                  ),
                  _buildActionCard(
                    title: 'Logout',
                    icon: Icons.logout_rounded,
                    color: Colors.redAccent,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const MyLoginPage()),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF161B22),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}