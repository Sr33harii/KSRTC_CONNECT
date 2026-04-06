// // // import 'dart:convert';
// // // import 'package:flutter/material.dart';
// // // import 'package:fluttertoast/fluttertoast.dart';
// // // import 'package:shared_preferences/shared_preferences.dart';
// // // import 'package:http/http.dart' as http;
// // //
// // // class SeatViewPage extends StatefulWidget {
// // //   final String busId;
// // //
// // //   const SeatViewPage({super.key, required this.busId});
// // //
// // //   @override
// // //   State<SeatViewPage> createState() => _SeatViewPageState();
// // // }
// // //
// // // class _SeatViewPageState extends State<SeatViewPage> {
// // //   List seats = [];
// // //   List<int> selectedSeatIds = [];
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     fetchSeats();
// // //   }
// // //
// // //   void fetchSeats() async {
// // //     SharedPreferences sh = await SharedPreferences.getInstance();
// // //     String url = sh.getString('url')!;
// // //
// // //     final response = await http.post(
// // //       Uri.parse("$url/user_view_seat/"),
// // //       body: {"bus_id": widget.busId},
// // //     );
// // //
// // //     var data = jsonDecode(response.body);
// // //
// // //     if (data["status"] == "ok") {
// // //       setState(() {
// // //         seats = data["data"];
// // //       });
// // //     }
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: const Text("Select Seats")),
// // //       body: seats.isEmpty
// // //           ? const Center(child: CircularProgressIndicator())
// // //           : Padding(
// // //         padding: const EdgeInsets.all(16),
// // //         child: Column(
// // //           children: [
// // //             Expanded(
// // //               child: ListView.builder(
// // //                 itemCount: seats.length,
// // //                 itemBuilder: (context, index) {
// // //                   var seat = seats[index];
// // //                   bool selected = selectedSeatIds.contains(seat["id"]);
// // //
// // //                   return CheckboxListTile(
// // //                     title: Text("Seat ${seat['seat_no']} (${seat['seat_type']})"),
// // //                     value: selected,
// // //                     onChanged: (v) {
// // //                       setState(() {
// // //                         v!
// // //                             ? selectedSeatIds.add(seat["id"])
// // //                             : selectedSeatIds.remove(seat["id"]);
// // //                       });
// // //                     },
// // //                   );
// // //                 },
// // //               ),
// // //             ),
// // //             ElevatedButton(
// // //               onPressed: bookSeats,
// // //               child: const Text("Book Selected Seats"),
// // //             )
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   void bookSeats() async {
// // //     if (selectedSeatIds.isEmpty) {
// // //       Fluttertoast.showToast(msg: "Select at least one seat");
// // //       return;
// // //     }
// // //
// // //     SharedPreferences sh = await SharedPreferences.getInstance();
// // //     String url = sh.getString('url')!;
// // //     String userId = sh.getString('lid')!;
// // //
// // //     final response = await http.post(
// // //       Uri.parse("$url/user_book_seat/"),
// // //       body: {
// // //         "user_id": userId,
// // //         "seats": jsonEncode(selectedSeatIds),
// // //       },
// // //     );
// // //
// // //     var data = jsonDecode(response.body);
// // //
// // //     if (data["status"] == "ok") {
// // //       Fluttertoast.showToast(msg: "Booking Successful!");
// // //     } else {
// // //       Fluttertoast.showToast(msg: "Booking Failed");
// // //     }
// // //   }
// // // }
// //
// //
// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:http/http.dart' as http;
// //
// // class SeatViewPage extends StatefulWidget {
// //   final String busId;
// //   final double price;
// //
// //   const SeatViewPage({super.key, required this.busId, required this.price});
// //
// //   @override
// //   State<SeatViewPage> createState() => _SeatViewPageState();
// // }
// //
// // class _SeatViewPageState extends State<SeatViewPage> {
// //   List seats = [];
// //   List<int> selectedSeatIds = [];
// //   double totalAmount = 0.0;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchSeats();
// //   }
// //
// //   void fetchSeats() async {
// //     SharedPreferences sh = await SharedPreferences.getInstance();
// //     String url = sh.getString('url')!;
// //
// //     final response = await http.post(
// //       Uri.parse("$url/user_view_seat/"),
// //       body: {"bus_id": widget.busId},
// //     );
// //
// //     var data = jsonDecode(response.body);
// //
// //     if (data["status"] == "ok") {
// //       setState(() {
// //         seats = data["data"];
// //       });
// //     } else {
// //       Fluttertoast.showToast(msg: data["message"]);
// //     }
// //   }
// //
// //   void updateTotalAmount() {
// //     totalAmount = selectedSeatIds.fold(
// //         0,
// //             (sum, id) =>
// //         sum +
// //             (double.tryParse(seats.firstWhere((s) => s['id'] == id)['price']
// //                 .toString()) ??
// //                 0));
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Select Seats")),
// //       body: seats.isEmpty
// //           ? const Center(child: CircularProgressIndicator())
// //           : Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           children: [
// //             Expanded(
// //               child: ListView.builder(
// //                 itemCount: seats.length,
// //                 itemBuilder: (context, index) {
// //                   var seat = seats[index];
// //                   bool selected = selectedSeatIds.contains(seat["id"]);
// //                   bool booked = seat["booked"] ?? false;
// //                   double price =
// //                       double.tryParse(seat["price"].toString()) ?? 0.0;
// //
// //                   return CheckboxListTile(
// //                     title: Text(
// //                         "Seat ${seat['seat_no']} (${seat['seat_type']}) - ₹$price"),
// //                     value: selected,
// //                     onChanged: booked
// //                         ? null
// //                         : (v) {
// //                       setState(() {
// //                         v!
// //                             ? selectedSeatIds.add(seat["id"])
// //                             : selectedSeatIds.remove(seat["id"]);
// //                         updateTotalAmount();
// //                       });
// //                     },
// //                     secondary: booked
// //                         ? const Icon(Icons.block, color: Colors.red)
// //                         : null,
// //                   );
// //                 },
// //               ),
// //             ),
// //             Text("Total Amount: ₹$totalAmount",
// //                 style: const TextStyle(
// //                     fontSize: 18, fontWeight: FontWeight.bold)),
// //             const SizedBox(height: 10),
// //             ElevatedButton(
// //               onPressed: bookSeats,
// //               child: const Text("Book Selected Seats"),
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   void bookSeats() async {
// //     if (selectedSeatIds.isEmpty) {
// //       Fluttertoast.showToast(msg: "Select at least one seat");
// //       return;
// //     }
// //
// //     SharedPreferences sh = await SharedPreferences.getInstance();
// //     String url = sh.getString('url')!;
// //     String userId = sh.getString('lid')!;
// //
// //     final response = await http.post(
// //       Uri.parse("$url/user_book_seat/"),
// //       body: {
// //         "user_id": userId,
// //         "seats": jsonEncode(selectedSeatIds),
// //         "amount": totalAmount.toString(),
// //       },
// //     );
// //
// //     var data = jsonDecode(response.body);
// //
// //     Fluttertoast.showToast(msg: data["message"]);
// //
// //     if (data["status"] == "ok") {
// //       // Refresh seat list after booking
// //       selectedSeatIds.clear();
// //       totalAmount = 0.0;
// //       fetchSeats();
// //     }
// //   }
// // }
//
//
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// /// ------------------- Seat View Page -------------------
// class SeatViewPage extends StatefulWidget {
//   final String busId;
//   final double price;
//
//   const SeatViewPage({super.key, required this.busId, required this.price});
//
//   @override
//   State<SeatViewPage> createState() => _SeatViewPageState();
// }
//
// class _SeatViewPageState extends State<SeatViewPage> {
//   List seats = [];
//   List<int> selectedSeatIds = [];
//   double totalAmount = 0.0;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchSeats();
//   }
//
//   /// Fetch seat data from backend
//   void fetchSeats() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//
//     final response = await http.post(
//       Uri.parse("$url/user_view_seat/"),
//       body: {"bus_id": widget.busId},
//     );
//
//     var data = jsonDecode(response.body);
//
//     if (data["status"] == "ok") {
//       setState(() {
//         seats = data["data"];
//       });
//     } else {
//       Fluttertoast.showToast(msg: data["message"]);
//     }
//   }
//
//   /// Update total amount dynamically
//   void updateTotalAmount() {
//     totalAmount = selectedSeatIds.fold(
//       0,
//           (sum, id) =>
//       sum +
//           (double.tryParse(
//               seats.firstWhere((s) => s['id'] == id)['price'].toString()) ??
//               0),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Select Seats")),
//       body: seats.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: seats.length,
//                 itemBuilder: (context, index) {
//                   var seat = seats[index];
//                   bool selected = selectedSeatIds.contains(seat["id"]);
//                   bool booked = seat["booked"] ?? false;
//                   double price =
//                       double.tryParse(seat["price"].toString()) ?? 0.0;
//
//                   return CheckboxListTile(
//                     title: Text(
//                         "Seat ${seat['seat_no']} (${seat['seat_type']}) - ₹$price"),
//                     value: selected,
//                     onChanged: booked
//                         ? null
//                         : (v) {
//                       setState(() {
//                         v!
//                             ? selectedSeatIds.add(seat["id"])
//                             : selectedSeatIds.remove(seat["id"]);
//                         updateTotalAmount();
//                       });
//                     },
//                     secondary: booked
//                         ? const Icon(Icons.block, color: Colors.red)
//                         : null,
//                   );
//                 },
//               ),
//             ),
//             Text(
//               "Total Amount: ₹$totalAmount",
//               style: const TextStyle(
//                   fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: bookSeats,
//               child: const Text("Book Selected Seats"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Book seats and navigate to payment page
//   void bookSeats() async {
//     if (selectedSeatIds.isEmpty) {
//       Fluttertoast.showToast(msg: "Select at least one seat");
//       return;
//     }
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//     String userId = sh.getString('lid')!;
//
//     final response = await http.post(
//       Uri.parse("$url/user_book_seat/"),
//       body: {
//         "user_id": userId,
//         "seats": jsonEncode(selectedSeatIds),
//         "amount": totalAmount.toString(),
//       },
//     );
//
//     var data = jsonDecode(response.body);
//
//     Fluttertoast.showToast(msg: data["message"]);
//
//     if (data["status"] == "ok") {
//       selectedSeatIds.clear();
//       totalAmount = 0.0;
//
//       // Navigate to payment page
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => PayAmount(
//             title: 'Bus Booking Payment',
//             bookingIds: data['booking_ids'], // list of booking IDs
//             amount: data['total_amount'].toString(),
//           ),
//         ),
//       );
//     }
//   }
// }
//
// /// ------------------- Payment Page -------------------
// class PayAmount extends StatefulWidget {
//   final String title;
//   final List<dynamic> bookingIds; // list of booking IDs
//   final String amount;
//
//   const PayAmount({
//     super.key,
//     required this.title,
//     required this.bookingIds,
//     required this.amount,
//   });
//
//   @override
//   State<PayAmount> createState() => _PayAmountState();
// }
//
// class _PayAmountState extends State<PayAmount> {
//   late Razorpay _razorpay;
//
//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       openCheckout();
//     });
//   }
//
//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }
//
//   /// Open Razorpay checkout
//   void openCheckout() {
//     var options = {
//       'key': 'rzp_test_HKCAwYtLt0rwQe',
//       'amount': (double.parse(widget.amount) * 100).toInt(),
//       'name': 'Bus Booking Payment',
//       'description': 'Booking IDs: ${widget.bookingIds.join(',')}',
//       'prefill': {'contact': '9747360170', 'email': 'test@gmail.com'},
//       'external': {'wallets': ['paytm']}
//     };
//
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint('Error: $e');
//     }
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) async {
//     await _sendData(response.paymentId ?? "");
//     Fluttertoast.showToast(msg: "Payment Successful");
//     Navigator.pop(context, true);
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     Fluttertoast.showToast(msg: "Payment Failed: ${response.message}");
//     Navigator.pop(context, false);
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     Fluttertoast.showToast(
//         msg: "External Wallet Selected: ${response.walletName}");
//   }
//
//   /// Send booking IDs and payment ID to backend
//   Future<void> _sendData(String paymentId) async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url') ?? "";
//
//     final uri = Uri.parse('$url/makepayment/');
//     var request = http.MultipartRequest('POST', uri);
//
//     request.fields['booking_ids'] = jsonEncode(widget.bookingIds);
//     request.fields['amount'] = widget.amount;
//     request.fields['payment_id'] = paymentId;
//
//     try {
//       var response = await request.send();
//       var respStr = await response.stream.bytesToString();
//       var data = jsonDecode(respStr);
//
//       if (!(response.statusCode == 200 && data['status'] == 'ok')) {
//         Fluttertoast.showToast(msg: "Server rejected payment");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         centerTitle: true,
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//       ),
//       body: const Center(
//         child: Text("Processing Payment...", style: TextStyle(fontSize: 18)),
//       ),
//     );
//   }
// }
//


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// class SeatViewPage extends StatefulWidget {
//   final String busId;
//   final double price;
//
//   const SeatViewPage({
//     super.key,
//     required this.busId,
//     required this.price,
//   });
//
//   @override
//   State<SeatViewPage> createState() => _SeatViewPageState();
// }
//
// class _SeatViewPageState extends State<SeatViewPage> {
//   List seats = [];
//   List<int> selectedSeatIds = [];
//   double totalAmount = 0;
//
//   late Razorpay _razorpay;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchSeats();
//
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//   }
//
//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }
//
//   /// FETCH SEATS
//   Future<void> fetchSeats() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//
//     final response = await http.post(
//       Uri.parse("$url/user_view_seat/"),
//       body: {"bid": widget.busId},
//     );
//
//     var data = jsonDecode(response.body);
//
//     if (data["status"] == "ok") {
//       setState(() {
//         seats = data["data"];
//       });
//     }
//   }
//
//   /// SELECT SEAT
//   void toggleSeat(Map seat) {
//     if (seat["booked"]) return;
//
//     setState(() {
//       if (selectedSeatIds.contains(seat["id"])) {
//         selectedSeatIds.remove(seat["id"]);
//       } else {
//         selectedSeatIds.add(seat["id"]);
//       }
//
//       totalAmount = selectedSeatIds.length *
//           (double.tryParse(seat["price"].toString()) ?? 0);
//     });
//   }
//
//   /// BOOK SEATS
//   Future<void> bookSeats() async {
//     if (selectedSeatIds.isEmpty) {
//       Fluttertoast.showToast(msg: "Select at least one seat");
//       return;
//     }
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//     String userId = sh.getString('lid')!;
//
//     final response = await http.post(
//       Uri.parse("$url/user_book_seat/"),
//       body: {
//         "user_id": userId,
//         "seats": jsonEncode(selectedSeatIds),
//         "amount": totalAmount.toString(),
//       },
//     );
//
//     var data = jsonDecode(response.body);
//
//     if (data["status"] == "ok") {
//       openCheckout(data["booking_ids"]);
//     } else {
//       Fluttertoast.showToast(msg: data["message"]);
//     }
//   }
//
//   /// OPEN RAZORPAY
//   void openCheckout(List bookingIds) {
//     var options = {
//       'key': 'rzp_test_HKCAwYtLt0rwQe',
//       'amount': (totalAmount * 100).toInt(),
//       'name': 'Bus Booking',
//       'description': 'Seat Booking Payment',
//     };
//
//     _razorpay.open(options);
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//
//     await http.post(
//       Uri.parse("$url/makepayment/"),
//       body: {
//         "amount": totalAmount.toString(),
//         "payment_id": response.paymentId,
//         "booking_ids": jsonEncode(selectedSeatIds),
//       },
//     );
//
//     Fluttertoast.showToast(msg: "Payment Successful");
//
//     selectedSeatIds.clear();
//     totalAmount = 0;
//     fetchSeats();
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     Fluttertoast.showToast(msg: "Payment Failed");
//   }
//
//   /// UI
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Select Seats")),
//       body: seats.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//         children: [
//           Expanded(
//             child: GridView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: seats.length,
//               gridDelegate:
//               const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//               ),
//               itemBuilder: (context, index) {
//                 var seat = seats[index];
//                 bool selected =
//                 selectedSeatIds.contains(seat["id"]);
//
//                 Color color;
//
//                 if (seat["booked"]) {
//                   color = Colors.red;
//                 } else if (selected) {
//                   color = Colors.blue;
//                 } else {
//                   color = Colors.green;
//                 }
//
//                 return GestureDetector(
//                   onTap: () => toggleSeat(seat),
//                   child: Container(
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: color,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(
//                       seat["seat_no"].toString(),
//                       style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 Text(
//                   "Total: ₹$totalAmount",
//                   style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: bookSeats,
//                   child: const Text("Proceed to Payment"),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// class SeatViewPage extends StatefulWidget {
//   final String busId;
//   final double price;
//
//   const SeatViewPage({
//     super.key,
//     required this.busId,
//     required this.price,
//   });
//
//   @override
//   State<SeatViewPage> createState() => _SeatViewPageState();
// }
//
// class _SeatViewPageState extends State<SeatViewPage> {
//   List seats = [];
//   List<int> selectedSeatIds = [];
//   double totalAmount = 0;
//
//   late Razorpay _razorpay;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchSeats();
//
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//   }
//
//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }
//
//   /// FETCH SEATS
//   Future<void> fetchSeats() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//
//     final response = await http.post(
//       Uri.parse("$url/user_view_seat/"),
//       body: {"bid": widget.busId},
//     );
//
//     var data = jsonDecode(response.body);
//
//     if (data["status"] == "ok") {
//       setState(() {
//         seats = data["data"];
//       });
//     }
//   }
//
//   /// SELECT SEAT
//   void toggleSeat(Map seat) {
//     if (seat["booked"]) return;
//
//     setState(() {
//       if (selectedSeatIds.contains(seat["id"])) {
//         selectedSeatIds.remove(seat["id"]);
//       } else {
//         selectedSeatIds.add(seat["id"]);
//       }
//
//       totalAmount = selectedSeatIds.length * widget.price;
//     });
//   }
//
//   /// BOOK SEATS
//   Future<void> bookSeats() async {
//     if (selectedSeatIds.isEmpty) {
//       Fluttertoast.showToast(msg: "Select at least one seat");
//       return;
//     }
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//     String userId = sh.getString('lid')!;
//
//     final response = await http.post(
//       Uri.parse("$url/user_book_seat/"),
//       body: {
//         "user_id": userId,
//         "seats": jsonEncode(selectedSeatIds),
//         "amount": totalAmount.toString(),
//       },
//     );
//
//     var data = jsonDecode(response.body);
//
//     if (data["status"] == "ok") {
//       openCheckout(data["booking_ids"]);
//     } else {
//       Fluttertoast.showToast(msg: data["message"]);
//     }
//   }
//
//   /// OPEN RAZORPAY
//   void openCheckout(List bookingIds) {
//     var options = {
//       'key': 'rzp_test_HKCAwYtLt0rwQe',
//       'amount': (totalAmount * 100).toInt(),
//       'name': 'Bus Booking',
//       'description': 'Seat Booking Payment',
//     };
//
//     _razorpay.open(options);
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url')!;
//
//     await http.post(
//       Uri.parse("$url/makepayment/"),
//       body: {
//         "amount": totalAmount.toString(),
//         "payment_id": response.paymentId,
//         "booking_ids": jsonEncode(selectedSeatIds),
//       },
//     );
//
//     Fluttertoast.showToast(msg: "Payment Successful");
//
//     selectedSeatIds.clear();
//     totalAmount = 0;
//     fetchSeats();
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     Fluttertoast.showToast(msg: "Payment Failed");
//   }
//
//   /// UI
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0F0F12),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF111116),
//         foregroundColor: Colors.white,
//         title: const Text("Select Seats"),
//         centerTitle: true,
//       ),
//       body: seats.isEmpty
//           ? const Center(child: CircularProgressIndicator(color: Color(0xFFEF4444)))
//           : Column(
//         children: [
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 4,
//                   crossAxisSpacing: 12,
//                   mainAxisSpacing: 16,
//                   childAspectRatio: 0.85,
//                 ),
//                 itemCount: seats.length,
//                 itemBuilder: (context, index) {
//                   var seat = seats[index];
//                   bool selected = selectedSeatIds.contains(seat["id"]);
//                   bool booked = seat["booked"] ?? false;
//
//                   return GestureDetector(
//                     onTap: booked ? null : () => toggleSeat(seat),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         AnimatedContainer(
//                           duration: const Duration(milliseconds: 300),
//                           width: 68,
//                           height: 78,
//                           decoration: BoxDecoration(
//                             color: booked
//                                 ? Colors.red.withOpacity(0.3)
//                                 : selected
//                                 ? const Color(0xFF2196F3).withOpacity(0.25)
//                                 : const Color(0xFF1E1E24),
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(18),
//                               topRight: Radius.circular(18),
//                               bottomLeft: Radius.circular(10),
//                               bottomRight: Radius.circular(10),
//                             ),
//                             border: Border.all(
//                               color: booked
//                                   ? Colors.red
//                                   : selected
//                                   ? const Color(0xFF2196F3)
//                                   : Colors.grey[700]!,
//                               width: 2.5,
//                             ),
//                             boxShadow: selected
//                                 ? [
//                               BoxShadow(
//                                 color: const Color(0xFF2196F3).withOpacity(0.4),
//                                 blurRadius: 12,
//                                 spreadRadius: 2,
//                                 offset: const Offset(0, 4),
//                               ),
//                             ]
//                                 : null,
//                           ),
//                           child: Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               // Backrest (upper part)
//                               Positioned(
//                                 top: 8,
//                                 child: Container(
//                                   width: 44,
//                                   height: 32,
//                                   decoration: BoxDecoration(
//                                     color: booked
//                                         ? Colors.red.withOpacity(0.6)
//                                         : selected
//                                         ? const Color(0xFF2196F3).withOpacity(0.6)
//                                         : Colors.grey[800],
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                 ),
//                               ),
//                               // Seat cushion (lower part)
//                               Positioned(
//                                 bottom: 6,
//                                 child: Container(
//                                   width: 54,
//                                   height: 28,
//                                   decoration: BoxDecoration(
//                                     color: booked
//                                         ? Colors.red.withOpacity(0.7)
//                                         : selected
//                                         ? const Color(0xFF2196F3).withOpacity(0.7)
//                                         : Colors.grey[700],
//                                     borderRadius: const BorderRadius.only(
//                                       bottomLeft: Radius.circular(12),
//                                       bottomRight: Radius.circular(12),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               // Seat number
//                               Center(
//                                 child: Text(
//                                   seat["seat_no"].toString(),
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                     shadows: const [
//                                       Shadow(
//                                         color: Colors.black54,
//                                         blurRadius: 4,
//                                         offset: Offset(1, 1),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         Text(
//                           seat["seat_no"].toString(),
//                           style: TextStyle(
//                             color: booked
//                                 ? Colors.red
//                                 : selected
//                                 ? const Color(0xFF2196F3)
//                                 : Colors.white70,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: const Color(0xFF111116),
//               border: Border(
//                 top: BorderSide(color: Colors.grey[800]!, width: 1),
//               ),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _legendItem("Available", Colors.grey[700]!),
//                     _legendItem("Selected", const Color(0xFF2196F3)),
//                     _legendItem("Booked", Colors.red),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   "Total Amount: ₹${totalAmount.toStringAsFixed(2)}",
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 54,
//                   child: ElevatedButton.icon(
//                     icon: const Icon(
//                       Icons.payment_rounded,
//                       color: Colors.white,
//                       size: 24,
//                     ),
//                     label: const Text(
//                       "Proceed to Payment",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,           // Whole button green
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 0,
//                     ),
//                     onPressed: bookSeats,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _legendItem(String label, Color color) {
//     return Row(
//       children: [
//         Container(
//           width: 20,
//           height: 20,
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.3),
//             borderRadius: BorderRadius.circular(6),
//             border: Border.all(color: color, width: 2.5),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Text(
//           label,
//           style: const TextStyle(color: Colors.white70, fontSize: 14),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SeatViewPage extends StatefulWidget {
  final String busId;
  final double price;

  const SeatViewPage({
    super.key,
    required this.busId,
    required this.price,
  });

  @override
  State<SeatViewPage> createState() => _SeatViewPageState();
}

class _SeatViewPageState extends State<SeatViewPage> {
  List seats = [];
  List<int> selectedSeatIds = [];
  double totalAmount = 0;

  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    fetchSeats();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  /// FETCH SEATS
  Future<void> fetchSeats() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url')!;

    final response = await http.post(
      Uri.parse("$url/user_view_seat/"),
      body: {"bid": widget.busId},
    );

    var data = jsonDecode(response.body);

    if (data["status"] == "ok") {
      setState(() {
        seats = data["data"];
      });
    }
  }

  /// SELECT SEAT
  void toggleSeat(Map seat) {
    if (seat["booked"]) return;

    setState(() {
      if (selectedSeatIds.contains(seat["id"])) {
        selectedSeatIds.remove(seat["id"]);
      } else {
        selectedSeatIds.add(seat["id"]);
      }

      totalAmount = selectedSeatIds.length * widget.price;
    });
  }

  /// BOOK SEATS
  Future<void> bookSeats() async {
    if (selectedSeatIds.isEmpty) {
      Fluttertoast.showToast(msg: "Select at least one seat");
      return;
    }

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url')!;
    String userId = sh.getString('lid')!;

    final response = await http.post(
      Uri.parse("$url/user_book_seat/"),
      body: {
        "user_id": userId,
        "seats": jsonEncode(selectedSeatIds),
        "amount": totalAmount.toString(),
      },
    );

    var data = jsonDecode(response.body);

    if (data["status"] == "ok") {
      openCheckout(data["booking_ids"]);
    } else {
      Fluttertoast.showToast(msg: data["message"]);
    }
  }

  /// OPEN RAZORPAY
  void openCheckout(List bookingIds) {
    var options = {
      'key': 'rzp_test_HKCAwYtLt0rwQe',
      'amount': (totalAmount * 100).toInt(),
      'name': 'Bus Booking',
      'description': 'Seat Booking Payment',
    };

    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url')!;

    await http.post(
      Uri.parse("$url/makepayment/"),
      body: {
        "amount": totalAmount.toString(),
        "payment_id": response.paymentId,
        "booking_ids": jsonEncode(selectedSeatIds),
      },
    );

    Fluttertoast.showToast(msg: "Payment Successful");

    selectedSeatIds.clear();
    totalAmount = 0;
    fetchSeats();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment Failed");
  }

  /// UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111116),
        foregroundColor: Colors.white,
        title: const Text("Select Seats"),
        centerTitle: true,
      ),
      body: seats.isEmpty
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFEF4444)))
          : SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            // Driver cabin area visual hint
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.directions_car_rounded, color: Colors.amber, size: 24),
                  SizedBox(width: 8),
                  Text(
                    "Driver",
                    style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            // Bus seat layout (2 - aisle - 2)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: List.generate((seats.length / 4).ceil(), (rowIndex) {
                  int startIndex = rowIndex * 4;
                  List rowSeats = seats.skip(startIndex).take(4).toList();

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left side (2 seats)
                        ...rowSeats.take(2).map((seat) => _buildBusSeat(seat)),

                        // Aisle gap
                        const SizedBox(width: 50),

                        // Right side (2 seats)
                        ...rowSeats.skip(2).map((seat) => _buildBusSeat(seat)),
                      ],
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF111116),
          border: Border(
            top: BorderSide(color: Colors.grey[800]!, width: 1),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _legendItem("Available", Colors.grey[700]!),
                _legendItem("Selected", const Color(0xFF2196F3)),
                _legendItem("Booked", Colors.red),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              "Total Amount: ₹${totalAmount.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.payment_rounded,
                  color: Colors.white,
                  size: 22,
                ),
                label: const Text(
                  "Proceed to Payment",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                onPressed: bookSeats,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusSeat(Map seat) {
    bool selected = selectedSeatIds.contains(seat["id"]);
    bool booked = seat["booked"] ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: booked ? null : () => toggleSeat(seat),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 60,
          height: 76,
          decoration: BoxDecoration(
            color: booked
                ? Colors.red.withOpacity(0.25)
                : selected
                ? const Color(0xFF2196F3).withOpacity(0.25)
                : const Color(0xFF1E1E24),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            border: Border.all(
              color: booked
                  ? Colors.red
                  : selected
                  ? const Color(0xFF2196F3)
                  : Colors.grey[700]!,
              width: 2.2,
            ),
            boxShadow: selected
                ? [
              BoxShadow(
                color: const Color(0xFF2196F3).withOpacity(0.35),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 3),
              ),
            ]
                : null,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Backrest
              Positioned(
                top: 8,
                child: Container(
                  width: 44,
                  height: 30,
                  decoration: BoxDecoration(
                    color: booked
                        ? Colors.red.withOpacity(0.65)
                        : selected
                        ? const Color(0xFF2196F3).withOpacity(0.65)
                        : Colors.grey[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              // Cushion
              Positioned(
                bottom: 6,
                child: Container(
                  width: 50,
                  height: 26,
                  decoration: BoxDecoration(
                    color: booked
                        ? Colors.red.withOpacity(0.75)
                        : selected
                        ? const Color(0xFF2196F3).withOpacity(0.75)
                        : Colors.grey[700],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                ),
              ),
              // Seat number
              Center(
                child: Text(
                  seat["seat_no"].toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    shadows: const [
                      Shadow(
                        color: Colors.black54,
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
      ),
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: color, width: 2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ],
    );
  }
}