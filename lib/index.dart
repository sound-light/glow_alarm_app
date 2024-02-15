import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class index extends StatefulWidget {
  index ({super.key});

  @override
  State<index> createState() => _indexState();
}

class _indexState extends State<index> {
  @override

  List<String> str = [];
  List<bool> switch_list = [];
  List<String> blub_list = <String>['bulb1', 'bulb2', 'bulb3'];
  bool connect = true;
  GoogleSignInAccount? googleUser;
  var user_id;
  var user_email;
  var alarms_result;

  void initState() {
    super.initState();
    print("tester");
    update();
  }

  state_update() async {
    var storage = await SharedPreferences.getInstance();
    storage.setStringList('list', str);
  }


  update() async {
      googleUser = await GoogleSignIn().signIn();
      var email = googleUser?.email;


      String URL = "34.64.206.2:8080";
      var user_check = await http.get(Uri.http(URL, 'user/google/' + email!));
      var result = jsonDecode(user_check.body);

      setState(() {
        user_email = email;
        user_id = result["id"];
      });

      var alarms_check = await http.get(Uri.http(URL, '/alarms/user/' + user_id!));
      alarms_result = jsonDecode(alarms_check.body);
      print("alarms LIST");
      print(alarms_result);

      setState(() {
        for(var alarm in alarms_result) {
          var time = alarm["alarm_time"][11] + alarm["alarm_time"][12] + alarm["alarm_time"][13] + alarm["alarm_time"][14] + alarm["alarm_time"][15];
          str.add(time);
          // str.add(jsonEncode(alarm));
        }
      });
  }

  Widget build(BuildContext context) {

    Object? user = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Column(
          children: [
            Container(
              height: 10,
            ),
            AppBar(
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.all(0),
                child: Text("Alarms", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              actions: [
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: IconButton(
                            icon: Icon(connect? Icons.lightbulb : Icons.warning,
                                color: connect? Colors.green : Colors.redAccent
                            ),
                            onPressed: (){

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        "연결 상태를 바꾸시겠습니까?",
                                        style: TextStyle(color: Colors.black, fontSize: 20),
                                      ),
                                      content: Container(
                                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),

                                        child: DropdownMenuExample(blub_list: blub_list),
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 0.5, color: Colors.black12)
                                        ),
                                      ),
                                      actions: [
                                        Row(
                                          children: [
                                            TextButton(
                                              onPressed: (){
                                                setState(() {
                                                  connect = false;
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: Text("연결 해제", style: TextStyle(color: Colors.red)),
                                            ),
                                            TextButton(
                                              onPressed: (){
                                                setState(() {
                                                  connect = true;
                                                  Navigator.pop(context);

                                                });
                                              },
                                              child: Text("상태 변경"),
                                            ),
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        )

                                      ],
                                    );
                                  }
                              );


                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: IconButton(
                            icon: Icon(Icons.bug_report),
                            onPressed: (){
                              // 임시로 두기
                              setState(() {
                                Navigator.pushNamed(context, '/test');
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: IconButton(
                            icon: Icon(Icons.settings),
                            onPressed: (){
                              // 임시로 두기
                              setState(() {
                                initState();
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(user_email.toString(), style: TextStyle(color: Colors.black, fontSize: 12),),
                // OutlinedButton(
                //     onPressed: () async {
                //       // var storage = await SharedPreferences.getInstance();
                //       // storage.remove('list');
                //       // setState(() async {
                //       //   initState();
                //       //   str = [];
                //       // });
                //
                //       // await GoogleSignIn().signOut();
                //       //
                //       // Navigator.pushNamed(context, '/loading');
                //
                //       print("출력");
                //       print(user);
                //
                //     },
                //     child: Text("out")
                // ),
                IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () async{
                      await GoogleSignIn().signOut();
                      Navigator.pushNamed(context, '/loading');
                    },
                    icon: Icon(Icons.cancel_outlined, size: 12,)
                )
              ],
            )

          ],
        ),
      ),
      body: ListView.builder(
        itemCount: str.length,
        itemBuilder: (c, i) => Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Row(
                children: [
                  Text(
                      // jsonEncode(str[i]["alarm_time"]).toString(),
                    str[i].toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)
                  ),
                  Container(
                    width: 15,
                  ),
                  // Text("M", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: (str[i][4] == "1") ? CupertinoColors.systemIndigo : Colors.grey),),
                  // Text("T", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: (str[i][5] == "1") ? CupertinoColors.systemIndigo : Colors.grey),),
                  // Text("W", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: (str[i][6] == "1") ? CupertinoColors.systemIndigo : Colors.grey),),
                  // Text("T", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: (str[i][7] == "1") ? CupertinoColors.systemIndigo : Colors.grey),),
                  // Text("F", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: (str[i][8] == "1") ? CupertinoColors.systemIndigo : Colors.grey),),
                  // Text("S", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: (str[i][9] == "1") ? CupertinoColors.systemIndigo : Colors.grey),),
                  // Text("S", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: (str[i][10] == "1") ? CupertinoColors.systemIndigo : Colors.grey),),
                  Container(
                    width: 20,
                  ),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: CupertinoSwitch(
                  //     value: switch_list[i],
                  //     activeColor: (str[i][11] == "1") ? CupertinoColors.systemIndigo : CupertinoColors.inactiveGray,
                  //     onChanged: (bool? value){
                  //       setState(() {
                  //         var check = str[i][11];
                  //         str[i] = str[i].substring(0, str[i].length - 1);
                  //         str[i] += (check == "1") ? "0" : "1";
                  //         switch_list[i] = (check == "1") ? false : true;
                  //         state_update();
                  //         // print(str);
                  //       });
                  //     },
                  //   ),
                  // ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    "현재 알람을 삭제하겠습니까?",
                                    style: TextStyle(color: Colors.black, fontSize: 18),
                                  ),
                                  content: Text(
                                    "삭제된 알람은 되돌릴 수 없습니다.",
                                    style: TextStyle(color: Colors.black, fontSize: 14),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {

                                          String URL = "34.64.206.2:8080";
                                          String id = alarms_result[i]["id"];
                                          print("삭제한다" + id);
                                          var user_check = await http.delete(Uri.http(URL, '/alarm/' + id!));

                                          setState(() {
                                            str.removeAt(i);
                                            // state_update();
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: Center(child: Text("삭제", style: TextStyle(color: Colors.redAccent, fontSize: 18),))
                                    ),
                                  ],
                                );
                              }
                          );
                        },
                        icon: Icon(Icons.close, size: 15,)
                    ),
                  )
                ],
                        ),
            ),
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_box_outlined, color: Colors.white),
        backgroundColor: CupertinoColors.systemIndigo,
        onPressed: (){
          Navigator.pushNamed(context, '/add');
        },
      ),
    );
  }
}


// class topBar extends StatelessWidget {
//   topBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Placeholder();
//   }
// }

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key, this.blub_list});
  final blub_list;

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  var dropdownValue = "test";

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: widget.blub_list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: widget.blub_list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
      width: double.maxFinite,
    );
  }
}


