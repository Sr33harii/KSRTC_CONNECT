// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import 'driver add seat.dart';
// import 'driver addbus.dart';
// import 'driver editbus.dart';
// import 'driver view seat.dart';
// import 'driverhome.dart';
//
//
//
// void main() {
//   runApp(const ViewBus());
// }
//
// class ViewBus extends StatelessWidget {
//   const ViewBus({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: ViewBusPage(title: 'View Users'),
//     );
//   }
// }
//
// class ViewBusPage extends StatefulWidget {
//   const ViewBusPage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<ViewBusPage> createState() => _ViewBusPageState();
// }
//
// class _ViewBusPageState extends State<ViewBusPage> {
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
//       String lid = sh.getString('lid').toString();
//       String apiUrl = '$urls/driver_view_bus/';
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
//             'busname': item['busname'],
//             'reg_no': item['reg_no'],
//             'FromROUTE': item['FromROUTE'],
//             'To_ROUTE': item['To_ROUTE'],
//             'description': item['description'],
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
//             MaterialPageRoute(builder: (context) =>driverHomePage()),
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
//                       ElevatedButton(onPressed: () async {
//                         SharedPreferences sh=await SharedPreferences.getInstance();
//                         sh.setString("bid", user['id']);
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>EditBusPage()));
//                       }, child: Text('Edit')),
//                       ElevatedButton(onPressed: ()async{
//                         try {
//                           SharedPreferences sh = await SharedPreferences.getInstance();
//                           sh.setString("bid", user['id']);
//                           String url = sh.getString('url') ?? '';
//                           String bid = sh.getString('bid') ?? '';
//
//                           final uri = Uri.parse("$url/driver_delete_bus/");
//
//                           final response = await http.post(uri, body: {
//                             'bid': bid,
//
//                           });
//                           var data = jsonDecode(response.body);
//
//                           if (data['status'] == 'ok') {
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(SnackBar(content: Text("Bus Deleted Successfully")));
//                           } else {
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(SnackBar(content: Text("Failed to delete bus")));
//                           }
//                         } catch (e) {
//                           ScaffoldMessenger.of(context)
//                               .showSnackBar(SnackBar(content: Text("Network error: $e")));
//                         }
//                       }, child: Text('Delete')),
//                       ElevatedButton(onPressed: ()async{
//                         SharedPreferences sh=await SharedPreferences.getInstance();
//                         sh.setString("bid", user['id']);
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewSeatDetailsPage(title: '',)));
//                       }, child: Text('Seat')),
//
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//           floatingActionButton: FloatingActionButton(onPressed: (){
//
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>AddBus()));
//
//           },child: Icon(Icons.add),),
//         ));
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http ;

import 'driver editbus.dart';
import 'driver view seat.dart';
import 'driverhome.dart';


void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ViewBusPage(title: 'View Buses'),
  ));
}

class ViewBusPage extends StatefulWidget {
  const ViewBusPage({super.key, required this.title});
  final String title;

  @override
  State<ViewBusPage> createState() => _ViewBusPageState();
}

class _ViewBusPageState extends State<ViewBusPage> {
  List<Map<String, dynamic>> buses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    viewBuses();
  }

  Future<void> viewBuses() async {
    setState(() => _isLoading = true);

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? baseUrl = sh.getString('url');
      String? lid = sh.getString('lid');

      if (baseUrl == null || lid == null) {
        Fluttertoast.showToast(msg: "Session or server not configured");
        return;
      }

      final uri = Uri.parse('$baseUrl/driver_view_bus/');

      final response = await http.post(uri, body: {'lid': lid});

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['status'] == 'ok') {
          List<Map<String, dynamic>> tempList = [];
          for (var item in jsonData['data'] ?? []) {
            tempList.add({
              'id': item['id'].toString(),
              'busname': item['busname'] ?? 'Unnamed Bus',
              'reg_no': item['reg_no'] ?? '-',
              'FromROUTE': item['FromROUTE'] ?? '-',
              'To_ROUTE': item['To_ROUTE'] ?? '-',
              'description': item['description'] ?? 'No description',
            });
          }
          setState(() {
            buses = tempList;
          });
        } else {
          Fluttertoast.showToast(msg: jsonData['message'] ?? 'No buses found');
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

  Future<void> _deleteBus(String bid) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? baseUrl = sh.getString('url');

      if (baseUrl == null) return;

      final uri = Uri.parse('$baseUrl/driver_delete_bus/');

      final response = await http.post(uri, body: {'bid': bid});

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'ok') {
          Fluttertoast.showToast(msg: "Bus deleted successfully");
          viewBuses(); // Refresh list
        } else {
          Fluttertoast.showToast(msg: data['message'] ?? "Failed to delete bus");
        }
      } else {
        Fluttertoast.showToast(msg: "Server error");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Network error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const driverHomePage()),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0D1117),
        appBar: AppBar(
          title: const Text('My Buses'),
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
                      'Your Registered Buses',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
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
              else if (buses.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bus_alert_rounded,
                            size: 80, color: Colors.grey[700]),
                        const SizedBox(height: 16),
                        const Text(
                          'No buses registered yet',
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: buses.length,
                    itemBuilder: (context, index) {
                      final bus = buses[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        color: const Color(0xFF161B22),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                              color: const Color(0xFFE63946).withOpacity(0.2)),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bus['busname'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Reg No: ",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    TextSpan(
                                      text: bus['reg_no'],
                                      style: const TextStyle(color: Colors.white70),
                                    ),
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "From: ",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    TextSpan(
                                      text: bus['FromROUTE'],
                                      style: const TextStyle(color: Colors.white70),
                                    ),
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "To: ",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    TextSpan(
                                      text: bus['To_ROUTE'],
                                      style: const TextStyle(color: Colors.white70),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Description: ${bus['description']}",
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildActionButton(
                                    label: 'Edit',
                                    icon: Icons.edit,
                                    color: const Color(0xFF3B82F6),
                                    onPressed: () async {
                                      SharedPreferences sh =
                                      await SharedPreferences.getInstance();
                                      sh.setString("bid", bus['id']);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => EditBusPage()),
                                      );
                                    },
                                  ),
                                  _buildActionButton(
                                    label: 'Delete',
                                    icon: Icons.delete_forever,
                                    color: Colors.redAccent,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          backgroundColor:
                                          const Color(0xFF161B22),
                                          title: const Text('Delete Bus?',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          content: const Text(
                                            'This action cannot be undone.',
                                            style:
                                            TextStyle(color: Colors.white70),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text('Cancel',
                                                  style: TextStyle(
                                                      color: Color(0xFFE63946))),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                _deleteBus(bus['id']);
                                              },
                                              child: const Text('Delete',
                                                  style: TextStyle(
                                                      color: Colors.redAccent)),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  _buildActionButton(
                                    label: 'Seats',
                                    icon: Icons.event_seat,
                                    color: const Color(0xFF10B981),
                                    onPressed: () async {
                                      SharedPreferences sh =
                                      await SharedPreferences.getInstance();
                                      sh.setString("bid", bus['id']);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                ViewSeatDetailsPage(title: '',)),
                                      );
                                    },
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
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFFE63946),
          foregroundColor: Colors.white,
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (_) => AddBus()),
            // );
          },
          child: const Icon(Icons.add_road_rounded),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Text(label, style: const TextStyle(fontSize: 13)),
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color.withOpacity(0.6)),
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}