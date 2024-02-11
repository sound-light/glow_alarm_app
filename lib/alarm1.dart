import 'package:flutter/material.dart';


class alarm1 extends StatelessWidget {
  const alarm1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              height: 250,
            ),
            Text(
                "Need to wake up\nand put on hearing aid",
                style: TextStyle(fontFamily: 'ProtestRiot', fontSize: 40, color: Colors.black)
            ),
            Container(
              height: 100,
            ),
            Container(
              width: double.infinity,
              height: 55,
              child: TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(207, 192, 221, 100))
                  ),
                  child: Text("Yes, I am wake up now", style: TextStyle(fontFamily: 'ProtestRiot', fontSize: 18))
              ),
            )
          ],
        ),
      ),
    );
  }
}
