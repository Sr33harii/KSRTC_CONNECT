// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:ksrtc/user/user%20home.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import 'sent complainte.dart';
// import 'sent feedback.dart';
// import 'user view seat.dart';
//
//
//
//
//
// void main() {
//   runApp(const UserViewFreedback());
// }
//
// class UserViewFreedback extends StatelessWidget {
//   const UserViewFreedback({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: UserViewFreedbackPage(title: 'View Users'),
//     );
//   }
// }
//
// class UserViewFreedbackPage extends StatefulWidget {
//   const UserViewFreedbackPage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<UserViewFreedbackPage> createState() => _UserViewFreedbackPageState();
// }
//
// class _UserViewFreedbackPageState extends State<UserViewFreedbackPage> {
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
//       String apiUrl = '$urls/user_view_feedback/';
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
//             'feedback': item['feedback'],
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
//             title: Text('Feedback'),
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
//                   title: Text('', style: TextStyle(fontWeight: FontWeight.bold)),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Date: ${user['date']}"),
//                       Text("Feedback: ${user['feedback']}"),
//
//
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//           floatingActionButton: FloatingActionButton(onPressed: (){
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>UserSentFeedback(title: '',)));
//           },child: Icon(Icons.add),),
//
//         ));
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ksrtc/user/user%20home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'sent complainte.dart';
import 'sent feedback.dart';
import 'user view seat.dart';

void main() {
  runApp(const UserViewFreedback());
}

class UserViewFreedback extends StatelessWidget {
  const UserViewFreedback({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserViewFreedbackPage(title: 'View Feedback'),
    );
  }
}

class UserViewFreedbackPage extends StatefulWidget {
  const UserViewFreedbackPage({super.key, required this.title});
  final String title;

  @override
  State<UserViewFreedbackPage> createState() => _UserViewFreedbackPageState();
}

class _UserViewFreedbackPageState extends State<UserViewFreedbackPage> {
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
      String lid = sh.getString('lid').toString();
      String apiUrl = '$urls/user_view_feedback/';

      var response = await http.post(Uri.parse(apiUrl), body: {
        'lid': lid
      });
      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        List<Map<String, dynamic>> tempList = [];
        for (var item in jsonData['data']) {
          tempList.add({
            'id': item['id'].toString(),
            'date': item['date'],
            'feedback': item['feedback'],
          });
        }
        setState(() {
          users = tempList;
        });
      }
    } catch (e) {
      print("Error fetching feedback: $e");
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
          title: const Text("My Feedback"),
          centerTitle: true,
          backgroundColor: const Color(0xFF111116),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: users.isEmpty
            ? const Center(
          child: CircularProgressIndicator(
            color: Color(0xFFEF4444),
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final feedback = users[index];
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
                            Icons.rate_review_rounded,
                            color: Color(0xFFEF4444),
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Feedback #${feedback['id']}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Date: ${feedback['date'] ?? 'N/A'}",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      feedback['feedback'] ?? "No feedback text",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFFEF4444),
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserSentFeedback(title: ''),
              ),
            );
          },
          child: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}