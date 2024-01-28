import 'package:flutter/material.dart';

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
            Color.fromRGBO(142, 63, 213, 100),
            Color.fromRGBO(98, 34, 155, 100),
            Color.fromRGBO(98, 34, 155, 100),
            Color.fromRGBO(142, 63, 213, 100),
            Color.fromRGBO(170, 111, 224, 100),
            Color.fromRGBO(153, 82, 218, 100),
            Color.fromRGBO(188, 141, 231, 100)
          ]
        )
      ),
      child: Center(
        child: Column(
          children: [
            Flexible(child: Container(), flex:4),

            Flexible(
              child: Column(
                children: [
                  Text("Glow Alarm", style: Theme.of(context).textTheme.headline2),
                  Container(height: 10,),
                  Icon(Icons.lightbulb, color: Colors.white, size: 100, ),
                  Container(height: 10,),
                  Text(
                      "Experience special awakening with light",
                      style: Theme.of(context).textTheme.headline6
                  ),
                  Text(
                      "regardless of hearing",
                      style: Theme.of(context).textTheme.headline6
                  ),
                ],
              ),
              flex:3
            ),

            Flexible(child: Container(), flex:1),
            Flexible(child:
                Container(
                  width: 300,
                  child: TextButton.icon(
                      onPressed: (){
                        Navigator.pushNamed(context, '/');
                      },
                      label: Text("Continue with Google"),
                      icon: Icon(Icons.gpp_good_outlined),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13
                          ),
                          padding: EdgeInsets.fromLTRB(45, 20, 45, 20)
                      )
                  ),
                ),
            flex:3),
          ],
        ),
      )
    );
  }
}
