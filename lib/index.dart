import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class index extends StatefulWidget {
  index ({super.key});

  @override
  State<index> createState() => _indexState();
}

class _indexState extends State<index> {
  @override

  List<String> str = [];
  List<bool> switch_list = [];

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      update();
    });
  }

  state_update() async {
    var storage = await SharedPreferences.getInstance();
    storage.setStringList('list', str);
  }


  update() async {
      var storage = await SharedPreferences.getInstance();
      setState(() {
        str = (storage.getStringList("list") ?? null)!;
        if(str == null) {
          storage.setStringList('list', []);
          str = (storage.getStringList("list") ?? null)!;
        }

      for(String item in str) {
        print(item);
        if (item[11] == "1") {
          switch_list.add(true);
        } else {
          switch_list.add(false);
        }
      }

    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Column(
          children: [
            Container(
              height: 10,
            ),
            AppBar(
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.all(20),
                child: Text("Alarms", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              actions: [
                OutlinedButton(
                    onPressed: () async {
                      var storage = await SharedPreferences.getInstance();
                      storage.remove('list');
                      setState(() async {
                        initState();
                        str = [];
                      });
                    },
                    child: Text("초기화")
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: IconButton(
                    icon: Icon(Icons.bug_report),
                    onPressed: (){
                      // 임시로 두기
                      setState(() {
                        Navigator.pushNamed(context, '/alarm1');
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


              ]
            ),
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
                  Text(str[i][0].toString() + str[i][1].toString() + ":" + str[i][2].toString() + str[i][3].toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                  Container(
                    width: 15,
                  ),
                  Text("M", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: (str[i][4] == "1") ? CupertinoColors.systemIndigo : Colors.grey),),
                  Text("T", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: (str[i][5] == "1") ? CupertinoColors.systemIndigo : Colors.grey),),
                  Text("W", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: (str[i][6] == "1") ? CupertinoColors.systemIndigo : Colors.grey),),
                  Text("T", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: (str[i][7] == "1") ? CupertinoColors.systemIndigo : Colors.grey),),
                  Text("F", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: (str[i][8] == "1") ? CupertinoColors.systemIndigo : Colors.grey),),
                  Text("S", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: (str[i][9] == "1") ? CupertinoColors.systemIndigo : Colors.grey),),
                  Text("S", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: (str[i][10] == "1") ? CupertinoColors.systemIndigo : Colors.grey),),
                  Container(
                    width: 20,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CupertinoSwitch(
                      value: switch_list[i],
                      activeColor: (str[i][11] == "1") ? CupertinoColors.systemIndigo : CupertinoColors.inactiveGray,
                      onChanged: (bool? value){
                        setState(() {
                          var check = str[i][11];
                          str[i] = str[i].substring(0, str[i].length - 1);
                          str[i] += (check == "1") ? "0" : "1";
                          switch_list[i] = (check == "1") ? false : true;
                          state_update();
                          // print(str);
                        });
                      },
                    ),
                  ),
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
                                        onPressed: (){
                                          print(str[i]);
                                          setState(() {
                                            str.removeAt(i);
                                            state_update();
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

