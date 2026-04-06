// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'user viewbus.dart';
//
// void main() {
//   runApp(const UserViewSeat());
// }
//
// class UserViewSeat extends StatelessWidget {
//   const UserViewSeat({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'View Seat Details',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const UserViewSeatPage(title: 'Select Seat'),
//     );
//   }
// }
//
// class UserViewSeatPage extends StatefulWidget {
//   const UserViewSeatPage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<UserViewSeatPage> createState() => _UserViewSeatPageState();
// }
//
// class _UserViewSeatPageState extends State<UserViewSeatPage> {
//   List<Map<String, dynamic>> seatList = [];
//   List<bool> selectedSeats = [];
//
//   _UserViewSeatPageState() {
//     _fetchSeats();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => UserViewBusPage(title: '')),
//         );
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           leading: BackButton(),
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           title: Text(widget.title),
//         ),
//         body: seatList.isEmpty
//             ? const Center(child: CircularProgressIndicator())
//             : Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: seatList.length,
//                 itemBuilder: (context, index) {
//                   return CheckboxListTile(
//                     title: Text(
//                         "Seat ${seatList[index]['seat_no']} - ${seatList[index]['seat_type']}"),
//                     value: selectedSeats[index],
//                     onChanged: (bool? value) {
//                       setState(() {
//                         selectedSeats[index] = value ?? false;
//                       });
//                     },
//                   );
//                 },
//               ),
//             ),
//             ElevatedButton(
//               onPressed: _bookSeats,
//               child: const Text('Book Selected Seats'),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // --------------------------------------------------------------------
//   // FUNCTION: Fetch seat list from Django
//   // --------------------------------------------------------------------
//   void _fetchSeats() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String bid = sh.getString('bid').toString();
//
//     final urls = Uri.parse('$url/user_view_seat/');
//
//     try {
//       final response = await http.post(urls, body: {'bid': bid});
//
//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body);
//
//         if (data['status'] == 'ok') {
//           List<dynamic> seats = data['data'];
//
//           setState(() {
//             seatList = seats
//                 .map((s) => {
//               'seat_no': s['seat_no'].toString(),
//               'seat_type': s['seat_type'].toString(),
//             })
//                 .toList();
//
//             selectedSeats = List<bool>.filled(seatList.length, false);
//           });
//         } else {
//           Fluttertoast.showToast(msg: 'Seats Not Found');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//   // --------------------------------------------------------------------
//   // FUNCTION: Booking seats
//   // --------------------------------------------------------------------
//   void _bookSeats() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String bid = sh.getString('bid').toString();
//     String lid = sh.getString('lid').toString();
//
//     // Collect selected seats
//     List<String> selectedSeatNumbers = [];
//
//     for (int i = 0; i < seatList.length; i++) {
//       if (selectedSeats[i]) {
//         selectedSeatNumbers.add(seatList[i]['seat_no']);
//       }
//     }
//
//     if (selectedSeatNumbers.isEmpty) {
//       Fluttertoast.showToast(msg: "Please select at least one seat!");
//       return;
//     }
//
//     final urls = Uri.parse('$url/user_book_seat/');
//
//     try {
//       final response = await http.post(urls, body: {
//         'bid': bid,
//         'lid': lid,
//         'seats': jsonEncode(selectedSeatNumbers)
//       });
//
//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body);
//
//         if (data['status'] == 'ok') {
//           Fluttertoast.showToast(msg: "Booking Successful!");
//         } else {
//           Fluttertoast.showToast(msg: "Booking Failed!");
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
// }
//


import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'user viewbus.dart';

void main() {
  runApp(const UserViewSeat());
}

class UserViewSeat extends StatelessWidget {
  const UserViewSeat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KSRTC CONNECT - Seat Selection',
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
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF111116),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEF4444),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
          ),
        ),
      ),
      home: const UserViewSeatPage(title: 'Select Seats'),
    );
  }
}

class UserViewSeatPage extends StatefulWidget {
  const UserViewSeatPage({super.key, required this.title});
  final String title;

  @override
  State<UserViewSeatPage> createState() => _UserViewSeatPageState();
}

class _UserViewSeatPageState extends State<UserViewSeatPage> {
  List<Map<String, dynamic>> seatList = [];
  List<bool> selectedSeats = [];

  _UserViewSeatPageState() {
    _fetchSeats();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserViewBusPage(title: '')),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(widget.title),
        ),
        body: seatList.isEmpty
            ? const Center(child: CircularProgressIndicator(color: Color(0xFFEF4444)))
            : Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: seatList.length,
                  itemBuilder: (context, index) {
                    bool isSelected = selectedSeats[index];
                    String seatNo = seatList[index]['seat_no'] ?? '—';
                    String seatType = seatList[index]['seat_type'] ?? '';

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSeats[index] = !isSelected;
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 60,
                            height: 68,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFEF4444).withOpacity(0.25)
                                  : const Color(0xFF1E1E24),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFFEF4444)
                                    : Colors.grey[700]!,
                                width: 2.2,
                              ),
                              boxShadow: isSelected
                                  ? [
                                BoxShadow(
                                  color: const Color(0xFFEF4444).withOpacity(0.4),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                                  : null,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Realistic seat backrest effect
                                Positioned(
                                  top: 8,
                                  child: Container(
                                    width: 38,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFFEF4444).withOpacity(0.6)
                                          : Colors.grey[800],
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                                // Seat bottom (cushion)
                                Positioned(
                                  bottom: 4,
                                  child: Container(
                                    width: 48,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFFEF4444).withOpacity(0.7)
                                          : Colors.grey[700],
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                // Seat number overlay
                                Center(
                                  child: Text(
                                    seatNo,
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.white70,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      shadows: const [
                                        Shadow(
                                          color: Colors.black45,
                                          blurRadius: 4,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          if (seatType.isNotEmpty)
                            Text(
                              seatType,
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 11,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF111116),
                border: Border(
                  top: BorderSide(color: Colors.grey[800]!, width: 1),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _legendItem("Available", Colors.grey[700]!),
                      _legendItem("Selected", const Color(0xFFEF4444)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.confirmation_number_rounded),
                      label: Text(
                        "Book ${selectedSeats.where((s) => s).length} Seat${selectedSeats.where((s) => s).length != 1 ? 's' : ''}",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      onPressed: _bookSeats,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color, width: 2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }

  // --------------------------------------------------------------------
  // FUNCTION: Fetch seat list from Django
  // --------------------------------------------------------------------
  void _fetchSeats() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String bid = sh.getString('bid').toString();

    final urls = Uri.parse('$url/user_view_seat/');

    try {
      final response = await http.post(urls, body: {'bid': bid});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data['status'] == 'ok') {
          List<dynamic> seats = data['data'];

          setState(() {
            seatList = seats
                .map((s) => {
              'seat_no': s['seat_no']?.toString() ?? '',
              'seat_type': s['seat_type']?.toString() ?? '',
            })
                .toList();

            selectedSeats = List<bool>.filled(seatList.length, false);
          });
        } else {
          Fluttertoast.showToast(msg: 'Seats Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  // --------------------------------------------------------------------
  // FUNCTION: Booking seats
  // --------------------------------------------------------------------
  void _bookSeats() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String bid = sh.getString('bid').toString();
    String lid = sh.getString('lid').toString();

    // Collect selected seats
    List<String> selectedSeatNumbers = [];

    for (int i = 0; i < seatList.length; i++) {
      if (selectedSeats[i]) {
        selectedSeatNumbers.add(seatList[i]['seat_no']);
      }
    }

    if (selectedSeatNumbers.isEmpty) {
      Fluttertoast.showToast(msg: "Please select at least one seat!");
      return;
    }

    final urls = Uri.parse('$url/user_book_seat/');

    try {
      final response = await http.post(urls, body: {
        'bid': bid,
        'lid': lid,
        'seats': jsonEncode(selectedSeatNumbers)
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data['status'] == 'ok') {
          Fluttertoast.showToast(msg: "Booking Successful!");
        } else {
          Fluttertoast.showToast(msg: "Booking Failed!");
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}