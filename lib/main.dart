import 'package:flutter/material.dart';
import 'package:gdsc_konkuk_teamsix/alarm1.dart';
import 'package:gdsc_konkuk_teamsix/index.dart';
import 'package:gdsc_konkuk_teamsix/init.dart';
import 'package:gdsc_konkuk_teamsix/add.dart';
import 'package:gdsc_konkuk_teamsix/style/standard_style.dart';
import 'package:gdsc_konkuk_teamsix/test.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/loading',
      routes: {
        '/': (context) => index(),
        '/loading': (context) => init(),
        '/add': (context) => add(),
        '/alarm1': (context) => alarm1(),
        '/test': (context) => test(),
      },
      debugShowCheckedModeBanner: false,
      theme: theme
      ),
  );
}
