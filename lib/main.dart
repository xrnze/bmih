import 'dart:developer';

import 'package:bmih/screen/components/app_bar.dart';
import 'package:bmih/screen/history_page.dart';
import 'package:bmih/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'BMIH'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: currentPageIndex == 0
          ? AppBar(
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).colorScheme.primary,
              centerTitle: true,
              title: Text(widget.title),
            )
          : const HistoryAppBar(),
      body: Container(
        child: <Widget>[
          const Padding(
            padding: EdgeInsets.all(20),
            child: HomePage(),
          ),
          const HistoryPage()
        ][currentPageIndex],
      ),
      bottomNavigationBar: NavigationBar(
          selectedIndex: currentPageIndex,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          onDestinationSelected: (value) {
            setState(() {
              currentPageIndex = value;
            });
          },
          destinations: const <Widget>[
            NavigationDestination(
                icon: Icon(Icons.home), label: "Halaman Utama"),
            NavigationDestination(icon: Icon(Icons.history), label: "Histori"),
          ]),
    );
  }
}
