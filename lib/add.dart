import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

const List<String> color_list = <String>['Red', 'Orange', 'Yellow', 'Green', 'Blue', 'White'];

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
  String color = "red";

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
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          padding: EdgeInsets.only(
              top: 40
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "what time do you want to\nget the Light Alarm?",
                    style: TextStyle(
                        fontFamily: 'ProtestRiot',
                        color: Colors.black, fontSize: 26
                    ),


                  ),
                ),
              ),
              Container(
                height: 20,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
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
                padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
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
                margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
                  child: DropdownMenuExample(color_list : color_list, change_color: change_color)
              ),

              Container(height: 50,),



              Container(
                width: double.infinity,
                height: 55,
                child: OutlinedButton(
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
                      if (test.length < 11) {
                        test = "0" + test;
                      }
                
                      test += "1";
                
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
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(207, 192, 221, 100)
                      ),
                    ),
                    child: Text("SET ALARM", style: TextStyle(fontFamily: 'ProtestRiot', fontSize: 18),)
                ),
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
        child: Text(widget.when[0], style: TextStyle(
            color: widget.when[2][widget.when[1]] ? Color.fromRGBO(91, 60, 190, 100) : Colors.black12,
          fontFamily: 'ProtestRiot',
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
        });
      },
      dropdownMenuEntries: color_list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value.toLowerCase(), label: value.toLowerCase());
      }).toList(),
      width: double.maxFinite,
    );
  }
}