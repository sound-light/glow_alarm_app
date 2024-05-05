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


      String URL = "glow-alarm-xt5lqnxq3q-uc.a.run.app";
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
        var count = 0;
        for(var alarm in alarms_result) {

          var check;

          if (alarm["alarm_status"] == true) {
            check = "1";
          } else {
            check = "0";
          }

          if (switch_list.length < alarms_result.length) {
            switch_list.add((check == "1") ? true : false);
          } else {
            switch_list[count] = (check == "1") ? true : false;
          }

          count += 1;


          var time = alarm["alarm_time"][11] + alarm["alarm_time"][12] + alarm["alarm_time"][13] + alarm["alarm_time"][14] + alarm["alarm_time"][15] + check + alarm["repeat_day"] + alarm["name"];
          str.add(time);
          // str.add(jsonEncode(alarm));
        }
      });
  }

  Widget build(BuildContext context) {

    Object? user = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Column(
          children: [
            Container(
              height: 10,
            ),
            AppBar(
                backgroundColor: Colors.white,
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
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        //   child: IconButton(
                        //     icon: Icon(connect? Icons.lightbulb : Icons.warning,
                        //         color: connect? Colors.green : Colors.redAccent
                        //     ),
                        //     onPressed: (){
                        //
                        //       showDialog(
                        //           context: context,
                        //           builder: (BuildContext context) {
                        //             return AlertDialog(
                        //               title: Text(
                        //                 "연결 상태를 바꾸시겠습니까?",
                        //                 style: TextStyle(color: Colors.black, fontSize: 20),
                        //               ),
                        //               content: Container(
                        //                 margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        //
                        //                 child: DropdownMenuExample(blub_list: blub_list),
                        //                 decoration: BoxDecoration(
                        //                     border: Border.all(width: 0.5, color: Colors.black12)
                        //                 ),
                        //               ),
                        //               actions: [
                        //                 Row(
                        //                   children: [
                        //                     TextButton(
                        //                       onPressed: (){
                        //                         setState(() {
                        //                           connect = false;
                        //                           Navigator.pop(context);
                        //                         });
                        //                       },
                        //                       child: Text("연결 해제", style: TextStyle(color: Colors.red)),
                        //                     ),
                        //                     TextButton(
                        //                       onPressed: (){
                        //                         setState(() {
                        //                           connect = true;
                        //                           Navigator.pop(context);
                        //
                        //                         });
                        //                       },
                        //                       child: Text("상태 변경"),
                        //                     ),
                        //                   ],
                        //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //                 )
                        //
                        //               ],
                        //             );
                        //           }
                        //       );
                        //
                        //
                        //     },
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        //   child: IconButton(
                        //     icon: Icon(Icons.bug_report),
                        //     onPressed: (){
                        //       // 임시로 두기
                        //       setState(() {
                        //         Navigator.pushNamed(context, '/test');
                        //       });
                        //     },
                        //   ),
                        // ),
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
                // Text(user_email.toString(), style: TextStyle(color: Colors.black, fontSize: 12),),
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
                // 로그아웃 버튼
                // IconButton(
                //     padding: EdgeInsets.all(0),
                //     onPressed: () async{
                //       await GoogleSignIn().signOut();
                //       Navigator.pushNamed(context, '/loading');
                //     },
                //     icon: Icon(Icons.cancel_outlined, size: 12,)
                // )
              ],
            )

          ],
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: str.length,
        itemBuilder: (c, i) => Card(
          elevation: 0,
          margin: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          child: ListTile(
            minVerticalPadding: 0,
            tileColor : (switch_list[i] == true) ? Color(0xFFC39BFB) : Color(0xFFCACACA),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
            ),
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            title: SizedBox(
              child: Column(
                children: [
                  Container(
                    height: 75,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            str[i].substring(0, 5),
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: (switch_list[i] == true) ? Color.fromRGBO(24, 15, 32, 1) : Color.fromRGBO(139, 135, 143, 1))
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: Text(
                              " AM",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: (switch_list[i] == true) ? Color.fromRGBO(24, 15, 32, 1) : Color.fromRGBO(139, 135, 143, 1)),
                            ),
                          ),
                          Container(
                            width: 120,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CupertinoSwitch(
                              value: switch_list[i],
                              activeColor: (str[i].substring(5, 6) == "1") ? Color(0xFFd5b6ff) : CupertinoColors.inactiveGray,
                              onChanged: (bool? value){
                                setState(() {
                                  // var check = str[i].substring(5, 6);
                                  switch_list[i] = (switch_list[i] == true) ? false : true;
                                  // state_update();
                                });
                              },
                            ),
                          ),
                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: IconButton(
                          //       onPressed: (){
                          //         showDialog(
                          //             context: context,
                          //             builder: (BuildContext context) {
                          //               return AlertDialog(
                          //                 title: Text(
                          //                   "현재 알람을 삭제하겠습니까?",
                          //                   style: TextStyle(color: Colors.black, fontSize: 18),
                          //                 ),
                          //                 content: Text(
                          //                   "삭제된 알람은 되돌릴 수 없습니다.",
                          //                   style: TextStyle(color: Colors.black, fontSize: 14),
                          //                 ),
                          //                 actions: [
                          //                   TextButton(
                          //                       onPressed: () async {
                          //
                          //                         String URL = "glow-alarm-xt5lqnxq3q-uc.a.run.app";
                          //                         String id = alarms_result[i]["id"];
                          //                         print("삭제한다" + id);
                          //                         var user_check = await http.delete(Uri.http(URL, '/alarm/' + id!));
                          //
                          //                         setState(() {
                          //                           str.removeAt(i);
                          //                           // state_update();
                          //                         });
                          //                         Navigator.of(context).pop();
                          //                       },
                          //                       child: Center(child: Text("삭제", style: TextStyle(color: Colors.redAccent, fontSize: 18),))
                          //                   ),
                          //                 ],
                          //               );
                          //             }
                          //         );
                          //       },
                          //       icon: Icon(Icons.close, size: 15,)
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    color: Color(0xFFEEDFFF),
                    height: 1,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            topLeft: Radius.zero,
                            topRight: Radius.zero
                        ),
                      color: (switch_list[i] == true) ? Color(0xFFd5b6ff) : Color(0xFFDCDADE)
                    ),
                    height: 40,
                    // 아래색
                    // color: ,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              flex: 7,
                              child: Text("   " + str[i].substring(13), style: TextStyle(color: (switch_list[i] == true) ? Color.fromRGBO(24, 15, 32, 1) : Color.fromRGBO(139, 135, 143, 1)),)
                          ),
              
                          Container(
                            width: 90,
                          ),
              
                          Flexible(
                            flex: 9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("M", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: (switch_list[i] == false) ? Color(0xFFE7E6E8) : (str[i].substring(6, 7) == "1") ? Color(0xFF6D4B8D) : Color(0xFFE5E1EC)),),
                                Text("T", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: (switch_list[i] == false) ? Color(0xFFE7E6E8) : (str[i].substring(7, 8) == "1") ? Color(0xFF6D4B8D) : Color(0xFFE5E1EC)),),
                                Text("W", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: (switch_list[i] == false) ? Color(0xFFE7E6E8) : (str[i].substring(8, 9) == "1") ? Color(0xFF6D4B8D) : Color(0xFFE5E1EC)),),
                                Text("T", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: (switch_list[i] == false) ? Color(0xFFE7E6E8) : (str[i].substring(9, 10) == "1") ? Color(0xFF6D4B8D) : Color(0xFFE5E1EC)),),
                                Text("F", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: (switch_list[i] == false) ? Color(0xFFE7E6E8) : (str[i].substring(10, 11) == "1") ? Color(0xFF6D4B8D) : Color(0xFFE5E1EC)),),
                                Text("S", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: (switch_list[i] == false) ? Color(0xFFE7E6E8) : (str[i].substring(11, 12) == "1") ? Color(0xFF6D4B8D) : Color(0xFFE5E1EC)),),
                                Text("S", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: (switch_list[i] == false) ? Color(0xFFE7E6E8) : (str[i].substring(12, 13) == "1") ? Color(0xFF6D4B8D) : Color(0xFFE5E1EC)),),
                              ],
                            ),
                          ),
                          Container(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,

        shape: CircleBorder(),
        child: Column(
          children: [
            Container(
              height: 9.5,
            ),
            Image.asset('assets/img/floating_btn.png', width: 42, height: 42,),
          ],
        ),
        backgroundColor: Color(0xFFC39BFB),
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


