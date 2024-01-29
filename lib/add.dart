import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class add extends StatelessWidget {
  add({super.key});

  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: 'New Alarm');
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

  change_repeat(i){
    setState(() {
      repeat[i] = !repeat[i];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          padding: EdgeInsets.only(
              top: 100
          ),
          child: Column(
            children: <Widget>[
              Text(
                  "what time do you want to get the Light Alarm?",
                style: TextStyle(color: Colors.black),
              ),
              hourMinute12H(),
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
              Text(
                "Repeat",
                style: TextStyle(color: Colors.black),
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
              Text(
                "Light Color",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "Smart Bulb Connection Status",
                style: TextStyle(color: Colors.black),
              ),

              OutlinedButton(
                  onPressed: () async {

                    var re = "";
                    repeat.forEach((element) {
                      if(element == true) {
                        re += "1";
                      } else {
                        re += "0";
                      }
                    });

                    var test = _dateTime.hour.toString() + _dateTime.minute.toString() + re;
                    if (test.length == 9) {
                      test = "0" + test;
                    }

                    var storage = await SharedPreferences.getInstance();

                    var str = storage.getStringList("list") ?? null;
                    if(str == null) {
                      storage.setStringList('list', [test]);
                    } else {
                      str.add(test);
                      storage.setStringList('list', str);
                    }

                    // Navigator.pop(context);
                    Navigator.pushNamed(context, '/');
                  },
                  style: ButtonStyle(
                  ),
                  child: Text("SET ALARM")
              ),
            ],
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
  // Widget hourMinute12HCustomStyle(){
  //   return new TimePickerSpinner(
  //     is24HourMode: false,
  //     normalTextStyle: TextStyle(
  //         fontSize: 24,
  //         color: Colors.deepOrange
  //     ),
  //     highlightedTextStyle: TextStyle(
  //         fontSize: 24,
  //         color: Colors.yellow
  //     ),
  //     spacing: 50,
  //     itemHeight: 80,
  //     isForce2Digits: true,
  //     minutesInterval: 15,
  //     onTimeChange: (time) {
  //       setState(() {
  //         _dateTime = time;
  //       });
  //     },
  //   );
  // }
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
          color: widget.when[2][widget.when[1]] ? Color.fromRGBO(207, 192, 221, 100) : Colors.white60
        ),
        height: 60,
        width: 40,
        child: Text(widget.when[0], style: TextStyle(color: Colors.black),),
      ),
    );
  }
}
