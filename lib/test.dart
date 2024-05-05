import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  // String uri = Uri.https("34.64.206.2:8080/", "user/1");

  getData() async {
    String URL = "34.47.98.239:8080";
    final response = await http.get(Uri.http(URL, 'users'));

    print("자 조회 들어갑니다~");
    print(jsonDecode(response.body));
  }

  PostData() async {
    String URL = "34.47.98.239:8080";
    var test = Uri.http(URL, 'user');

    print("값 넣기");
    var response = await http.post(test, headers: {
      'Content-Type': 'application/json',
    }, body: jsonEncode({
      "user_name": "1234",
      "google_id": "1235@gmail.com",
      "guardian_contact": "123421",
      "bulb_ip": "43214"
    }));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  @override
  void initState()  {
  // MYApp 위젯이 로드될 때 실행
    super.initState();
    // getData();
    PostData();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text("hello", style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
