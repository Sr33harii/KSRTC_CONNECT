




// // import 'package:flutter/material.dart';
// // import 'package:ksrtc/DRIVER/driver%20addbus.dart';
// // import 'package:ksrtc/DRIVER/driver%20editbus.dart';
// // import 'package:ksrtc/DRIVER/driver%20view%20profile.dart';
// // import 'package:ksrtc/login.dart';
// // import 'package:ksrtc/user/stopselection.dart';
// // import 'package:ksrtc/user/user%20view%20booking.dart';
// // import 'package:ksrtc/user/user_viewprofile.dart';
// //
// // import 'sent complainte.dart';
// // import 'sent feedback.dart';
// // import 'user viewbus.dart';
// // import 'view feedback.dart';
// // import 'view replay.dart';
// //
// //
// //
// // void main() {
// //   runApp(const MaterialApp(
// //     debugShowCheckedModeBanner: false,
// //     home: UserHomePage(),
// //   ));
// // }
// //
// // class UserHomePage extends StatefulWidget {
// //   const UserHomePage({super.key});
// //
// //   @override
// //   State<UserHomePage> createState() => _UserHomePageState();
// // }
// //
// // class _UserHomePageState extends State<UserHomePage> {
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
// //                       'Hi User,',
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
// //                         MaterialPageRoute(builder: (context) => userviewprofile(title: '',)),
// //                       );
// //                     },
// //                   ),
// //                   ActionCard(
// //                     title: 'Bus',
// //                     color: Colors.deepPurple,
// //                     icon: Icons.bus_alert,
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(builder: (context) =>UserViewBusPage(title: '',)),
// //                       );
// //                     },
// //                   ),
// //                   ActionCard(
// //                     title: 'Complaint',
// //                     color: Colors.deepPurple,
// //                     icon: Icons.bus_alert,
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(builder: (context) => UserViewReplyPage(title: '',)),
// //                       );
// //                     },
// //                   ),
// //                   ActionCard(
// //                     title: 'Feedback',
// //                     color: Colors.deepPurple,
// //                     icon: Icons.bus_alert,
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(builder: (context) => UserViewFreedbackPage(title: '',)),
// //                       );
// //                     },
// //                   ),
// //                   ActionCard(
// //                     title: 'view stop',
// //                     color: Colors.deepPurple,
// //                     icon: Icons.bus_alert,
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(builder: (context) => StopSelectionPage()),
// //                       );
// //                     },
// //                   ),
// //                   ActionCard(
// //                     title: 'view booking',
// //                     color: Colors.deepPurple,
// //                     icon: Icons.bus_alert,
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(builder: (context) => userviewbooking(title: '')),
// //                       );
// //                     },
// //                   ),
// //                   ActionCard(
// //                     title: 'logout',
// //                     color: Colors.deepPurple,
// //                     icon: Icons.bus_alert,
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(builder: (context) => MyLoginPage()),
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
//
//
// // class DrawerContent extends StatefulWidget {
// //   const DrawerContent({super.key});
// //
// //   @override
// //   State<DrawerContent> createState() => _DrawerContentState();
// // }
//
// // class _DrawerContentState extends State<DrawerContent> {
// //   void showDrawerMessage(String message) {
// //     Navigator.pop(context); // Close drawer
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text(message)),
// //     );
// //   }
// //
// //   // @override
// //   // Widget build(BuildContext context) {
// //   //   return ListView(
// //   //     padding: EdgeInsets.zero,
// //   //     children: [
// //   //       const DrawerHeader(
// //   //         decoration: BoxDecoration(color: Colors.blue),
// //   //         child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
// //   //       ),
// //   //       ListTile(
// //   //         leading: const Icon(Icons.dashboard),
// //   //         title: const Text('Dashboard'),
// //   //         onTap: () => showDrawerMessage('Dashboard selected'),
// //   //       ),
// //   //       ListTile(
// //   //         leading: const Icon(Icons.receipt),
// //   //         title: const Text('Add User'),
// //   //         onTap: () => showDrawerMessage('Bills selected'),
// //   //       ),
// //   //       ListTile(
// //   //         leading: const Icon(Icons.send),
// //   //         title: const Text('Transfers'),
// //   //         onTap: () => showDrawerMessage('Transfers selected'),
// //   //       ),
// //   //       ListTile(
// //   //         leading: const Icon(Icons.settings),
// //   //         title: const Text('Settings'),
// //   //         onTap: () => showDrawerMessage('Settings selected'),
// //   //       ),
// //   //     ],
// //   //   );
// //   // }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:ksrtc/DRIVER/driver%20addbus.dart';
// import 'package:ksrtc/DRIVER/driver%20editbus.dart';
// import 'package:ksrtc/DRIVER/driver%20view%20profile.dart';
// import 'package:ksrtc/login.dart';
// import 'package:ksrtc/user/stopselection.dart';
// import 'package:ksrtc/user/user%20view%20booking.dart';
// import 'package:ksrtc/user/user_viewprofile.dart';
//
// import 'sent complainte.dart';
// import 'sent feedback.dart';
// import 'user viewbus.dart';
// import 'view feedback.dart';
// import 'view replay.dart';
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: UserHomePage(),
//   ));
// }
//
// class UserHomePage extends StatefulWidget {
//   const UserHomePage({super.key});
//
//   @override
//   State<UserHomePage> createState() => _UserHomePageState();
// }
//
// class _UserHomePageState extends State<UserHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       backgroundColor: const Color(0xFF0A0E17),
//       body: Stack(
//         children: [
//           // Animated subtle background gradient
//           AnimatedContainer(
//             duration: const Duration(seconds: 8),
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   Color(0xFF0A0E17),
//                   Color(0xFF0F1624),
//                   Color(0xFF0A0E17),
//                 ],
//                 stops: [0.0, 0.5, 1.0],
//               ),
//             ),
//           ),
//
//           SafeArea(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   // Premium Hero Section
//                   Container(
//                     padding: const EdgeInsets.fromLTRB(24, 60, 24, 40),
//                     child: Column(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(40),
//                           child: Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: [
//                                   const Color(0xFFE63946).withOpacity(0.15),
//                                   const Color(0xFF111827),
//                                 ],
//                               ),
//                             ),
//                             child: Image.network(
//                               'https://toppng.com/uploads/preview/ksrtc-logo-11562902896j2j2j2j2j2.png',
//                               height: 110,
//                               fit: BoxFit.contain,
//                               errorBuilder: (_, __, ___) => const Icon(
//                                 Icons.directions_bus_filled_rounded,
//                                 size: 110,
//                                 color: Color(0xFFE63946),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 32),
//
//                         const Text(
//                           'KSRTC',
//                           style: TextStyle(
//                             fontSize: 48,
//                             fontWeight: FontWeight.w900,
//                             color: Colors.white,
//                             letterSpacing: 3,
//                             shadows: [
//                               Shadow(
//                                 color: Color(0xFFE63946),
//                                 blurRadius: 20,
//                                 offset: Offset(0, 5),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         Text(
//                           'Travel Smart. Travel KSRTC.',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.grey[300],
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 20),
//
//                   // Modern Action List – no boxes, elegant tiles
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Column(
//                       children: [
//                         _buildPremiumTile(
//                           title: 'My Profile',
//                           subtitle: 'View & update your account',
//                           icon: Icons.person_outline_rounded,
//                           color: const Color(0xFFE63946),
//                           onTap: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (_) => userviewprofile(title: '')),
//                           ),
//                         ),
//                         _buildPremiumTile(
//                           title: 'Find Buses',
//                           subtitle: 'Search routes & timings',
//                           icon: Icons.directions_bus_rounded,
//                           color: const Color(0xFF8B5CF6),
//                           onTap: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (_) => UserViewBusPage(title: '')),
//                           ),
//                         ),
//                         _buildPremiumTile(
//                           title: 'Complaints',
//                           subtitle: 'Raise & track issues',
//                           icon: Icons.report_problem_outlined,
//                           color: const Color(0xFFEF4444),
//                           onTap: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (_) => UserViewReplyPage(title: '')),
//                           ),
//                         ),
//                         _buildPremiumTile(
//                           title: 'Feedback',
//                           subtitle: 'Share your experience',
//                           icon: Icons.rate_review_outlined,
//                           color: const Color(0xFF10B981),
//                           onTap: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (_) => UserViewFreedbackPage(title: '')),
//                           ),
//                         ),
//                         _buildPremiumTile(
//                           title: 'Stops & Routes',
//                           subtitle: 'Explore nearby stops',
//                           icon: Icons.location_on_outlined,
//                           color: const Color(0xFF3B82F6),
//                           onTap: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (_) => StopSelectionPage()),
//                           ),
//                         ),
//                         _buildPremiumTile(
//                           title: 'My Bookings',
//                           subtitle: 'View upcoming & past trips',
//                           icon: Icons.book_online_outlined,
//                           color: const Color(0xFFF59E0B),
//                           onTap: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (_) => userviewbooking(title: '')),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 120), // extra space for bottom nav
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//
//       // Modern bottom navigation bar
//       bottomNavigationBar: Container(
//         height: 90,
//         decoration: BoxDecoration(
//           color: const Color(0xFF161B22).withOpacity(0.92),
//           borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.5),
//               blurRadius: 30,
//               offset: const Offset(0, -10),
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
//           child: BottomNavigationBar(
//             backgroundColor: Colors.transparent,
//             selectedItemColor: const Color(0xFFE63946),
//             unselectedItemColor: Colors.grey[600],
//             showSelectedLabels: false,
//             showUnselectedLabels: false,
//             type: BottomNavigationBarType.fixed,
//             currentIndex: 0,
//             elevation: 0,
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home_rounded, size: 28),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.directions_bus_rounded, size: 28),
//                 label: 'Buses',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.book_online_rounded, size: 28),
//                 label: 'Bookings',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person_rounded, size: 28),
//                 label: 'Profile',
//               ),
//             ],
//             onTap: (index) {
//               if (index == 1) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => UserViewBusPage(title: '')),
//                 );
//               } else if (index == 2) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => userviewbooking(title: '')),
//                 );
//               } else if (index == 3) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => userviewprofile(title: '')),
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPremiumTile({
//     required String title,
//     required String subtitle,
//     required IconData icon,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 180),
//         margin: const EdgeInsets.only(bottom: 20),
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               const Color(0xFF161B22),
//               const Color(0xFF1E2530),
//             ],
//           ),
//           borderRadius: BorderRadius.circular(28),
//           border: Border.all(color: color.withOpacity(0.25), width: 1.5),
//           boxShadow: [
//             BoxShadow(
//               color: color.withOpacity(0.15),
//               blurRadius: 20,
//               offset: const Offset(0, 10),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.15),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Icon(icon, size: 32, color: color),
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     subtitle,
//                     style: TextStyle(
//                       color: Colors.grey[400],
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Icon(
//               Icons.arrow_forward_ios_rounded,
//               color: Colors.grey[600],
//               size: 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:ksrtc/DRIVER/driver addbus.dart';
// import 'package:ksrtc/DRIVER/driver editbus.dart';
// import 'package:ksrtc/DRIVER/driver view profile.dart';
// import 'package:ksrtc/login.dart';
// import 'package:ksrtc/user/stopselection.dart';
// import 'package:ksrtc/user/user view booking.dart';
// import 'package:ksrtc/user/user_viewprofile.dart';
//
// import 'sent complainte.dart';
// import 'sent feedback.dart';
// import 'user viewbus.dart';
// import 'view feedback.dart';
// import 'view replay.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         useMaterial3: true,
//         scaffoldBackgroundColor: Colors.white,
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color(0xFF5B5CE2), // iOS premium indigo
//           primary: const Color(0xFF5B5CE2),
//         ),
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.white,
//           elevation: 0.5,
//           centerTitle: true,
//           titleTextStyle: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.w700,
//           ),
//           iconTheme: IconThemeData(color: Colors.black),
//         ),
//       ),
//       home: const UserHomePage(),
//     );
//   }
// }
//
// /// iOS-style page transition
// Route iosRoute(Widget page) {
//   return PageRouteBuilder(
//     transitionDuration: const Duration(milliseconds: 380),
//     pageBuilder: (_, animation, __) => FadeTransition(
//       opacity: animation,
//       child: SlideTransition(
//         position: Tween<Offset>(
//           begin: const Offset(0.15, 0),
//           end: Offset.zero,
//         ).animate(CurvedAnimation(
//           parent: animation,
//           curve: Curves.easeOutQuart,
//         )),
//         child: page,
//       ),
//     ),
//   );
// }
//
// class UserHomePage extends StatefulWidget {
//   const UserHomePage({super.key});
//
//   @override
//   State<UserHomePage> createState() => _UserHomePageState();
// }
//
// class _UserHomePageState extends State<UserHomePage> {
//   int _currentIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("KSRTC"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.person_outline),
//             onPressed: () {
//               Navigator.push(context, iosRoute(userviewprofile(title: '')));
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.logout_rounded, color: Colors.red),
//             onPressed: () {
//               Navigator.pushReplacement(context, iosRoute(MyLoginPage()));
//             },
//           ),
//         ],
//       ),
//
//       body: ListView(
//         padding: const EdgeInsets.all(20),
//         children: [
//           const Text("Welcome 👋",
//               style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 6),
//           Text("Travel smart with KSRTC",
//               style: TextStyle(color: Colors.grey[600])),
//           const SizedBox(height: 30),
//
//           iosCard(
//             title: "My Profile",
//             subtitle: "View & update your account",
//             icon: Icons.person_outline,
//             onTap: () {
//               Navigator.push(context, iosRoute(userviewprofile(title: '')));
//             },
//           ),
//
//           iosCard(
//             title: "Find Buses",
//             subtitle: "Search routes & timings",
//             icon: Icons.directions_bus_rounded,
//             onTap: () {
//               Navigator.push(context, iosRoute(UserViewBusPage(title: '')));
//             },
//           ),
//
//           iosCard(
//             title: "Complaints",
//             subtitle: "Raise & track issues",
//             icon: Icons.report_problem_outlined,
//             onTap: () {
//               Navigator.push(context, iosRoute(UserViewReplyPage(title: '')));
//             },
//           ),
//
//           iosCard(
//             title: "Feedback",
//             subtitle: "Share your experience",
//             icon: Icons.rate_review_outlined,
//             onTap: () {
//               Navigator.push(context, iosRoute(UserViewFreedbackPage(title: '')));
//             },
//           ),
//
//           iosCard(
//             title: "Stops & Routes",
//             subtitle: "Explore nearby stops",
//             icon: Icons.location_on_outlined,
//             onTap: () {
//               Navigator.push(context, iosRoute(StopSelectionPage()));
//             },
//           ),
//
//           iosCard(
//             title: "My Bookings",
//             subtitle: "View upcoming & past trips",
//             icon: Icons.book_online_outlined,
//             onTap: () {
//               Navigator.push(context, iosRoute(userviewbooking(title: '')));
//             },
//           ),
//         ],
//       ),
//
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.95),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 20,
//               offset: const Offset(0, -5),
//             ),
//           ],
//         ),
//         child: BottomNavigationBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           currentIndex: _currentIndex,
//           selectedItemColor: const Color(0xFF5B5CE2),
//           unselectedItemColor: Colors.grey,
//           onTap: (index) {
//             setState(() => _currentIndex = index);
//
//             if (index == 1) {
//               Navigator.push(context, iosRoute(UserViewBusPage(title: '')));
//             } else if (index == 2) {
//               Navigator.push(context, iosRoute(userviewbooking(title: '')));
//             } else if (index == 3) {
//               Navigator.push(context, iosRoute(userviewprofile(title: '')));
//             }
//           },
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
//             BottomNavigationBarItem(icon: Icon(Icons.directions_bus), label: "Buses"),
//             BottomNavigationBarItem(icon: Icon(Icons.book_online), label: "Bookings"),
//             BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// /// Premium iOS Card
// Widget iosCard({
//   required String title,
//   required String subtitle,
//   required IconData icon,
//   required VoidCallback onTap,
// }) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 24,
//             backgroundColor: const Color(0xFF5B5CE2).withOpacity(0.1),
//             child: Icon(icon, color: const Color(0xFF5B5CE2)),
//           ),
//           const SizedBox(width: 16),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(title,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.w600, fontSize: 17)),
//               const SizedBox(height: 4),
//               Text(subtitle, style: TextStyle(color: Colors.grey[600])),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }


import 'package:flutter/material.dart';
import 'package:ksrtc/DRIVER/driver addbus.dart';
import 'package:ksrtc/DRIVER/driver editbus.dart';
import 'package:ksrtc/DRIVER/driver view profile.dart';
import 'package:ksrtc/login.dart';
import 'package:ksrtc/user/stopselection.dart';
import 'package:ksrtc/user/user view booking.dart';
import 'package:ksrtc/user/user_viewprofile.dart';
import 'sent complainte.dart';
import 'sent feedback.dart';
import 'user viewbus.dart';
import 'view feedback.dart';
import 'view replay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KSRTC CONNECT',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0F12),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFEF4444),
          brightness: Brightness.dark,
          primary: const Color(0xFFEF4444),
          secondary: const Color(0xFF22D3EE),
          surface: const Color(0xFF1A1A1F),
          surfaceTint: Colors.transparent,
          background: const Color(0xFF0F0F12),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF111116),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF1E1E24),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF111116),
          selectedItemColor: Color(0xFFEF4444),
          unselectedItemColor: Colors.grey,
          elevation: 8,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFE5E7EB)),
          bodyMedium: TextStyle(color: Color(0xFF9CA3AF)),
        ),
      ),
      home: const UserHomePage(),
    );
  }
}

/// iOS-style smooth page transition
Route iosRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 380),
    pageBuilder: (_, animation, __) => FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.15, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutQuart,
        )),
        child: page,
      ),
    ),
  );
}

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const _HomeBody(),
    UserViewBusPage(title: ''),
    userviewbooking(title: ''),
    userviewprofile(title: ''),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate to logout/login page
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => MyLoginPage()), // or LoginPage()
        // );
        return false; // prevent default back action
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("KSRTC CONNECT"),
          actions: [
            IconButton(
              icon: const Icon(Icons.person_outline),
              onPressed: () {
                Navigator.push(context, iosRoute(const userviewprofile(title: '')));
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout_rounded, color: Color(0xFFFCA5A5)),
              onPressed: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: const Color(0xFF1E1E24),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    title: const Text("Logout"),
                    content: const Text("Are you sure you want to logout?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(foregroundColor: const Color(0xFFFCA5A5)),
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Logout"),
                      ),
                    ],
                  ),
                );

                if (confirmed == true) {
                  Navigator.pushReplacement(context, iosRoute(const MyLoginPage()));
                }
              },
            ),
          ],
        ),
        body: IndexedStack(
          key: PageStorageKey(_currentIndex),
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: const Color(0xFFEF4444),
          unselectedItemColor: Colors.grey[500],
          onTap: (index) {
            setState(() => _currentIndex = index);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.directions_bus), label: "Buses"),
            BottomNavigationBarItem(icon: Icon(Icons.book_online), label: "Bookings"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Header
          const Text(
            "Hello, Traveller 👋",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Where would you like to go today?",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 32),

          // Main Hero Action Card
          _buildHeroCard(
            context,
            title: "Find & Book Buses",
            subtitle: "Search routes, check timings, and reserve your seat instantly.",
            icon: Icons.directions_bus_rounded,
            onTap: () => Navigator.push(context, iosRoute(UserViewBusPage(title: ''))),
          ),
          const SizedBox(height: 32),

          // Section Title
          const Text(
            "Quick Services",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),

          // Modern Grid Layout for Secondary Features
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.05,
            children: [
              _buildGridCard(
                context,
                title: "My Bookings",
                subtitle: "View trips",
                icon: Icons.confirmation_number_rounded,
                iconColor: const Color(0xFF3B82F6), // Blue
                onTap: () => Navigator.push(context, iosRoute(userviewbooking(title: ''))),
              ),
              _buildGridCard(
                context,
                title: "Stops & Routes",
                subtitle: "Explore maps",
                icon: Icons.location_on_rounded,
                iconColor: const Color(0xFF10B981), // Green
                onTap: () => Navigator.push(context, iosRoute(StopSelectionPage())),
              ),
              _buildGridCard(
                context,
                title: "Complaints",
                subtitle: "Raise issues",
                icon: Icons.report_problem_rounded,
                iconColor: const Color(0xFFF59E0B), // Orange
                onTap: () => Navigator.push(context, iosRoute(UserViewReplyPage(title: ''))),
              ),
              _buildGridCard(
                context,
                title: "Feedback",
                subtitle: "Rate us",
                icon: Icons.rate_review_rounded,
                iconColor: const Color(0xFF8B5CF6), // Purple
                onTap: () => Navigator.push(context, iosRoute(UserViewFreedbackPage(title: ''))),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Beautiful Hero Card for Primary Action (Booking Buses)
  Widget _buildHeroCard(BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFEF4444), Color(0xFFB91C1C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFEF4444).withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 40),
            ),
          ],
        ),
      ),
    );
  }

  // Clean, Modern Grid Cards for Secondary Actions
  Widget _buildGridCard(BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E24),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF2D2D35)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}