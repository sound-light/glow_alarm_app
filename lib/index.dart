import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class index extends StatefulWidget {
  index ({super.key});

  @override
  State<index> createState() => _indexState();
}

class _indexState extends State<index> {
  @override

  void initState() {
    super.initState();
    update();
    print("test");
    print(str);
  }
  var str;

  update() async {
    var storage = await SharedPreferences.getInstance();
    str = storage.getStringList("list") ?? null;
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: (){
                    },
                  ),
                ),
              ]
            ),
          ],
        ),
      ),
      // body: ListView.builder(
      //   itemCount: str.length,
      //   itemBuilder: (c, i) {
      //     return ListTile(
      //       title: Text(i.toString()),
      //     );
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_box_outlined, color: Colors.white),
        backgroundColor: Color.fromRGBO(142, 63, 213, 100),
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

