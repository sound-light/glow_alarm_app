import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class init extends StatelessWidget {
  init({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(143, 65, 214, 100),
            Color.fromRGBO(188, 141, 231, 100)
          ]
        )
      ),
      child: Center(
        child: Column(
          children: [
            Flexible(child: Container(), flex:2),

            Flexible(
              child: Column(
                children: [
                  Text("Glow Alarm", style: Theme.of(context).textTheme.headline2),
                  Container(height: 15,),
                  // Icon(Icons.lightbulb, color: Colors.white, size: 100, ),
                  Image.asset('assets/img/logo.png'),
                  Container(height: 15,),
                  Text(
                      "Experience special awakening with light,",
                      style: Theme.of(context).textTheme.headline6
                  ),
                  Text(
                      "regardless of hearing",
                      style: Theme.of(context).textTheme.headline6
                  ),
                ],
              ),
              flex:2
            ),

            Flexible(
              flex:2,
              child: GestureDetector(
                onTap: () async {
                  GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

                  if (googleUser != null) {
                    // print(googleUser.displayName);
                    // print(googleUser.email);

                    String URL = "34.64.206.2:8080";
                    var test = Uri.http(URL, 'user');

                    var user_check = await http.get(Uri.http(URL, 'user/google/' + googleUser.email));
                    var user_check_len = jsonDecode(user_check.body).length;

                    print("==로그인 체크==");
                    print(user_check_len);
                    if (user_check_len == 1) {
                      var response = await http.post(test, headers: {
                        'Content-Type': 'application/json',
                      }, body: jsonEncode({
                        "user_name": googleUser.displayName,
                        "google_id": googleUser.email,
                        "guardian_contact": "123421",
                        "location_id": "65decb2d-acaa-4a04-b506-9d456a0aeb5e",
                        "bulb_ip": "43214"
                      }));

                      print('Response status: ${response.statusCode}');
                      print('Response body: ${response.body}');
                    }

                    Navigator.pushNamed(context, '/', arguments: googleUser.email);
                    print("test");
                  }

                },
                child: Image.asset('assets/img/google.png'),
              ),
            )
          ],
        ),
      )
    );
  }
}
