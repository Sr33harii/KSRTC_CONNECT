// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// class UserViewAvailableSeat extends StatefulWidget {
//   const UserViewAvailableSeat({super.key});
//
//   @override
//   State<UserViewAvailableSeat> createState() => _UserViewAvailableSeatState();
// }
//
// class _UserViewAvailableSeatState extends State<UserViewAvailableSeat> {
//   List<Map<String, dynamic>> seatList = [];
//   List<int> bookedSeats = [];
//   int totalSeats = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     loadSeats();
//   }
//
//   // ---------------- LOAD BOTH APIs ----------------
//   Future<void> loadSeats() async {
//     await _fetchAllSeats();     // load all seats
//     await _fetchBookedSeats();  // then load booked seat numbers
//   }
//
//   // ---------------- FETCH ALL SEATS (GREEN/RED BASE) ----------------
//   Future<void> _fetchAllSeats() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//     String bid = sh.getString('bid')!;
//
//     final api = Uri.parse('$url/user_view_seat/');
//
//     try {
//       final response = await http.post(api, body: {'bid': bid});
//       var data = jsonDecode(response.body);
//
//       if (data['status'] == 'ok') {
//         setState(() {
//           seatList = data['data']
//               .map<Map<String, dynamic>>(
//                   (s) => {'id': s['id'], 'seat_no': s['seat_no']})
//               .toList();
//
//           totalSeats = seatList.length; // dynamic seat count from DB
//         });
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//   // ---------------- FETCH BOOKED SEATS ----------------
//   Future<void> _fetchBookedSeats() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//     String bid = sh.getString('bid')!;
//
//     final api = Uri.parse('$url/user_view_seat_boooking/');
//
//     try {
//       final response = await http.post(api, body: {'bid': bid});
//       var data = jsonDecode(response.body);
//
//       if (data['status'] == 'ok') {
//         setState(() {
//           bookedSeats = data['data']
//               .map<int>((s) => int.parse(s['seatid'].toString()))
//               .toList();
//         });
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//   // ---------------- UI ----------------
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text("Seat Availability"),
//         backgroundColor: Colors.black,
//       ),
//       body: totalSeats == 0
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//         padding: const EdgeInsets.all(16),
//         child: ListView.builder(
//           itemCount: (totalSeats / 5).ceil(),
//           itemBuilder: (context, rowIndex) {
//             int startSeat = rowIndex * 5;
//
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   seatWidget(startSeat + 1),
//                   const SizedBox(width: 12),
//                   seatWidget(startSeat + 2),
//
//                   const SizedBox(width: 40), // aisle gap
//
//                   seatWidget(startSeat + 3),
//                   const SizedBox(width: 12),
//                   seatWidget(startSeat + 4),
//                   const SizedBox(width: 12),
//                   seatWidget(startSeat + 5),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   // ---------------- SEAT WIDGET ----------------
//   Widget seatWidget(int seatNo) {
//     if (seatNo > totalSeats) return const SizedBox(width: 50);
//
//     bool isBooked = bookedSeats.contains(seatNo);
//
//     return Column(
//       children: [
//         AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           width: 45,
//           height: 45,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(
//               color: isBooked ? Colors.red : Colors.greenAccent,
//               width: 2,
//             ),
//             color: isBooked
//                 ? Colors.red.withOpacity(0.4)
//                 : Colors.transparent,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           seatNo.toString(),
//           style: const TextStyle(color: Colors.white),
//         )
//       ],
//     );
//   }
// }



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserViewAvailableSeat extends StatefulWidget {
  const UserViewAvailableSeat({super.key});

  @override
  State<UserViewAvailableSeat> createState() => _UserViewAvailableSeatState();
}

class _UserViewAvailableSeatState extends State<UserViewAvailableSeat> {
  List<Map<String, dynamic>> seatList = [];

  @override
  void initState() {
    super.initState();
    fetchSeats();
  }

  // ---------------- FETCH SEATS ----------------
  Future<void> fetchSeats() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url')!;
    String bid = sh.getString('bid')!;

    try {
      final response = await http.post(
        Uri.parse('$url/user_view_seat/'),
        body: {'bid': bid},
      );

      final data = jsonDecode(response.body);

      if (data['status'] == 'ok') {
        setState(() {
          seatList = List<Map<String, dynamic>>.from(data['data']);
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Seat Availability"),
        backgroundColor: Colors.black,
      ),
      body: seatList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: (seatList.length / 5).ceil(),
          itemBuilder: (context, rowIndex) {
            int start = rowIndex * 5;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  seatWidget(start),
                  const SizedBox(width: 12),
                  seatWidget(start + 1),

                  const SizedBox(width: 40), // aisle

                  seatWidget(start + 2),
                  const SizedBox(width: 12),
                  seatWidget(start + 3),
                  const SizedBox(width: 12),
                  seatWidget(start + 4),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ---------------- SEAT WIDGET ----------------
  Widget seatWidget(int index) {
    if (index >= seatList.length) return const SizedBox(width: 50);

    final seat = seatList[index];
    bool isBooked = seat['booked'];

    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isBooked ? Colors.red : Colors.greenAccent,
              width: 2,
            ),
            color: isBooked
                ? Colors.red.withOpacity(0.4)
                : Colors.transparent,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          seat['seat_no'].toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
