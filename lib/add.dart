import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';

const List<String> color_list = <String>['Red', 'Orange', 'Yellow', 'Green', 'Blue', 'White'];

class add extends StatelessWidget {
  add({super.key});

  @override
  Widget build(BuildContext context) {
    return MyHomePage(
        title: 'New Alarm',
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  DateTime _dateTime = DateTime.now();
  List<bool> repeat = [false, false, false, false, false, false, false];
  String color = "red";

  void openPopup() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 100,
          width: double.infinity,
          margin: EdgeInsets.all(10),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // 원하는 radius 값을 지정
            ),
            backgroundColor: Colors.white,
            alignment: Alignment.center,
            scrollable: true,
            // 색선택
            // titlePadding: EdgeInsets.all(4),
            // title: Container(
            //   color: Color(0xFFEDEBF6),
            //   child: Text(""),
            // ),
            contentPadding: EdgeInsets.all(20),
            content: Container(
              height: 100,
              width: double.infinity,
              child: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, 'red');
                      },
                      child: Row(
                        children: [
                          Icon(Icons.circle, color: Colors.red),
                          Container(width: 10),
                          Text('red', style: TextStyle(
                              color: Colors.black,
                              fontSize: 18
                          )),
                        ],
                      ),
                    ),
                    Container(height: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, 'orange');
                      },
                      child: Row(
                        children: [
                          Icon(Icons.circle, color: Colors.orange),
                          Container(width: 10),
                          Text('orange', style: TextStyle(
                              color: Colors.black,
                              fontSize: 18
                          )),
                        ],
                      ),
                    ),
                    Container(height: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, 'yellow');
                      },
                      child: Row(
                        children: [
                          Icon(Icons.circle, color: Colors.yellow),
                          Container(width: 10),
                          Text('yellow', style: TextStyle(
                              color: Colors.black,
                              fontSize: 18
                          )),
                        ],
                      ),
                    ),
                    Container(height: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, 'green');
                      },
                      child: Row(
                        children: [
                          Icon(Icons.circle, color: Colors.green),
                          Container(width: 10),
                          Text('green', style: TextStyle(
                              color: Colors.black,
                              fontSize: 18
                          )),
                        ],
                      ),
                    ),
                    Container(height: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, 'blue');
                      },
                      child: Row(
                        children: [
                          Icon(Icons.circle, color: Colors.blue),
                          Container(width: 10),
                          Text('blue', style: TextStyle(
                              color: Colors.black,
                              fontSize: 18
                          )),
                        ],
                      ),
                    ),
                    Container(height: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, 'white');
                      },
                      child: Row(
                        children: [
                          Icon(Icons.circle, color: Colors.white),
                          Container(width: 10),
                          Text('white', style: TextStyle(
                              color: Colors.black,
                              fontSize: 18
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        color = result;
      });
    }
  }

  change_repeat(i){
    setState(() {
      repeat[i] = !repeat[i];
    });
  }

  change_color(j) {

    setState(() {
      color = j;
      print(color);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(

            // icon: Image.asset('assets/img/back.png"', height: 30, width: 30,),
            icon: Icon(Icons.close),
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          title: Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),),

        ),
        body: Container(
          padding: EdgeInsets.only(
              top: 0
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "What time do you want\nto get the Light Alarm?",
                      style: TextStyle(
                          // fontFamily: 'ProtestRiot',
                          color: Colors.black, fontSize: 24
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black45, // 테두리 색상 설정
                        width: 1, // 테두리 두께 설정
            
                      ),
                    ),
                    child: hourMinute12H()
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 0
                  ),
                  child: Text(
                    _dateTime.hour.toString().padLeft(2, '0') + ':' +
                        _dateTime.minute.toString().padLeft(2, '0') + ':' +
                        _dateTime.second.toString().padLeft(2, '0'),
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Repeat",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    repeat_box(change_repeat: change_repeat, when: ["MON", 0, repeat]),
                    repeat_box(change_repeat: change_repeat, when: ["TUE", 1, repeat]),
                    repeat_box(change_repeat: change_repeat, when: ["WED", 2, repeat]),
                    repeat_box(change_repeat: change_repeat, when: ["THR", 3, repeat]),
                    repeat_box(change_repeat: change_repeat, when: ["FRI", 4, repeat]),
                    repeat_box(change_repeat: change_repeat, when: ["SAT", 5, repeat]),
                    repeat_box(change_repeat: change_repeat, when: ["SUN", 6, repeat]),
            
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 30, 0, 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Light Color",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
            
                Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black54), borderRadius: BorderRadius.all(Radius.circular(10))),
                    // child: DropdownMenuExample(color_list : color_list, change_color: change_color)
                  child: TextButton(
                    onPressed: openPopup,
                    child: Row(
                      children: [
                        Icon(Icons.circle, color: (color == "red" ? Colors.red :
                        color == "orange" ? Colors.orange :
                        color == "yellow" ? Colors.yellow :
                        color == "green" ? Colors.green :
                        color == "blue" ? Colors.blue :
                        color == "white" ? Colors.white10 :
                        Colors.red
                        ),),
                        Container(width: 10,),
                        Text(color, style: TextStyle(color: Colors.black),)
                      ],
                    ),
                  )
                ),
            
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Name of the Alarm",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
            
                Container(
                    height: 50,
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration( // 입력 필드 위에 나타날 힌트 텍스트 나타나는 힌트 텍스트
                        contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 1,
                          ),
                            gapPadding: double.maxFinite
                        ), // 입력 필드 주위에 테두리 생성
                      ),
                      onChanged: (text) {
                        // 입력 내용이 변경될 때 실행될 콜백 함수
                        print('Input: $text');
                      },
                    ),
                ),
            
                Container(height: 40,),
                Container(
                  width: double.infinity,
                  height: 60,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: OutlinedButton(
                        onPressed: () async {
            
                          int i = 0;
                          List<String> daily_set = ["MON", "TUE", "WED", "THR", "FRI", "SAT", "SUN"];
                          List<String> repeat_day = [];
                          repeat.forEach((element) {
                            if(element == true) {
                              repeat_day.add(daily_set[i]);
                            }
                            i += 1;
                          });
            
            
                          var googleUser = await GoogleSignIn().signIn();
                          var email = googleUser?.email;
                          String URL = "glow-alarm-xt5lqnxq3q-uc.a.run.app";
                          var user_check = await http.get(Uri.http(URL, 'user/google/' + email!));
                          var result = jsonDecode(user_check.body);
                          // var user_id = result["id"];
                          var user_id = "944c735f-2e7f-4676-896a-dfce97a9113e";
            
                          bool alarm_status = true;
            
                          print(repeat_day);
                          var test = Uri.http(URL, 'alarm');
            
                          try {
                            var response = await http.post(test, headers: {
                              'Content-Type': 'application/json',
                            }, body: jsonEncode({
                              "alarm_time": _dateTime.toString(),
                              "repeat_day": "1010011",
                              "light_color": color,
                              "name": "test",
                              "alarm_status": alarm_status,
                              "user_id": user_id
                            }));
            
                            print('Response body: ${response.body}');
                          } catch (error) {
                            print('Error: $error');
                          }
            
            
                          Navigator.pushReplacementNamed(context, '/');
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color(0xFFC39BFB)
                          ),
                          side: MaterialStateProperty.all(BorderSide.none)
                        ),
                        child: Text("Set Alarm", style: TextStyle( fontFamily: 'Karla', fontSize: 18, color: Colors.white),)
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }


  /// SAMPLE
  Widget hourMinute12H(){
    return TimePickerSpinner(
      is24HourMode: false,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
    );
  }
}

class repeat_box extends StatefulWidget {
  repeat_box({super.key, this.change_repeat, this.when});
  final change_repeat;
  final when;

  @override
  State<repeat_box> createState() => _repeat_boxState();
}

class _repeat_boxState extends State<repeat_box> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget.change_repeat(widget.when[1]);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: widget.when[2][widget.when[1]] ? Color(0xFFC39BFB) : Colors.white60
        ),
        height: 60,
        width: 40,
        child: Text(widget.when[0], style: TextStyle(
            color: widget.when[2][widget.when[1]] ? Colors.white : Colors.black,
          // fontFamily: 'ProtestRiot',
        ),),
      ),
    );
  }
}


class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key, this.color_list, this.change_color});
  final color_list;
  final change_color;

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  var dropdownValue = color_list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(

      initialSelection: color_list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.change_color(dropdownValue);
          if (dropdownValue == null) {
            widget.change_color("red");
          }
        });
      },
      dropdownMenuEntries: color_list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value.toLowerCase(), label: value.toLowerCase());
      }).toList(),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, ),

      leadingIcon: Icon(Icons.circle,
        color: (dropdownValue == "red" ? Colors.red :
        dropdownValue == "orange" ? Colors.orange :
        dropdownValue == "yellow" ? Colors.yellow :
        dropdownValue == "green" ? Colors.green :
        dropdownValue == "blue" ? Colors.blue :
        dropdownValue == "white" ? Colors.white10 :
            Colors.red
        ),
    ),
    );
  }
}