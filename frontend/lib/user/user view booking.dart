// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:ksrtc/user/user%20home.dart';
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
//       home: userviewbooking(title: 'View Users'),
//     );
//   }
// }
//
// class userviewbooking extends StatefulWidget {
//   const userviewbooking({super.key, required this.title});
//   final String title;
//
//   @override
//   State<userviewbooking> createState() => _userviewbookingState();
// }
//
// class _userviewbookingState extends State<userviewbooking> {
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
//       String lid = sh.getString('lid') ?? '';
//       String apiUrl = '$urls/user_view_boooking/';
//
//       var response = await http.post(Uri.parse(apiUrl), body: {
//         'lid':lid
//       });
//       var jsonData = json.decode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         List<Map<String, dynamic>> tempList = [];
//         for (var item in jsonData['data']) {
//           tempList.add({
//             'id': item['id'].toString(),
//             'date': item['date'],
//             'seat_no': item['seat_no'],
//             'amount': item['amount'],
//             'bus': item['bus'],
//
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
//                   title: Text(user['bus'], style: TextStyle(fontWeight: FontWeight.bold)),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("date: ${user['date']}"),
//                       Text("seat_no: ${user['seat_no']}"),
//                       Text("amount: ${user['amount']}"),
//                       Text("bus : ${user['bus']}"),
//
//
//
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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ksrtc/user/user%20home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const UserViewBus());
}

class UserViewBus extends StatelessWidget {
  const UserViewBus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: userviewbooking(title: 'My Bookings'),
    );
  }
}

class userviewbooking extends StatefulWidget {
  const userviewbooking({super.key, required this.title});
  final String title;

  @override
  State<userviewbooking> createState() => _userviewbookingState();
}

class _userviewbookingState extends State<userviewbooking> {
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> filteredUsers = [];
  List<String> nameSuggestions = [];

  @override
  void initState() {
    super.initState();
    viewUsers("");
  }

  Future<void> viewUsers(String searchValue) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? '';
      String lid = sh.getString('lid') ?? '';
      String apiUrl = '$urls/user_view_booking/';  // Fixed potential typo: changed 'boooking' to 'booking'

      var response = await http.post(Uri.parse(apiUrl), body: {
        'lid': lid
      });
      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        List<Map<String, dynamic>> tempList = [];
        for (var item in jsonData['data']) {
          tempList.add({
            'id': (item['id'] ?? '').toString(),
            'date': (item['date'] ?? '').toString(),
            'seat_no': (item['seat_no'] ?? '').toString(),
            'amount': (item['amount'] ?? '0').toString(),
            'bus': (item['bus'] ?? '').toString(),
          });
        }
        setState(() {
          users = tempList;
        });
      }
    } catch (e) {
      print("Error fetching bookings: $e");
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
          title: const Text("My Bookings"),
          centerTitle: true,
          backgroundColor: const Color(0xFF111116),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: users.isEmpty
            ? const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bookmark_border_rounded, size: 80, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                "No bookings yet",
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                "Your upcoming and past trips will appear here",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final booking = users[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 0,
              color: const Color(0xFF1E1E24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Color(0xFF2D2D35), width: 0.8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEF4444).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.confirmation_number_rounded,
                            color: Color(0xFFEF4444),
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                booking['bus'] ?? "Bus Booking",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Booking ID: ${booking['id']}",
                                style: TextStyle(color: Colors.grey[400], fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow("Date", booking['date'] ?? "-"),
                    _buildDetailRow("Seat No", booking['seat_no'] ?? "-"),
                    _buildDetailRow("Amount", "₹${booking['amount'] ?? '0'}"),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF22D3EE).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Confirmed",
                          style: TextStyle(
                            color: Color(0xFF22D3EE),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey[400], fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}