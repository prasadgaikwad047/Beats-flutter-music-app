import 'package:audioplayers/audioplayers.dart';
import 'package:radio_player/radio_player.dart';
import 'package:beats/models/music.dart';
import 'package:beats/models/radio.dart';
import 'package:beats/screens/home_screen.dart';
import 'package:beats/screens/radio_screen.dart';

import 'package:beats/screens/yourlibrary_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AudioPlayer _audioPlayer = new AudioPlayer();

  var tabs = const [];
  int currentTabIndex = 0;

  Music? music;
  bool isplaying = false;
  // player row which appears above bottom navigation bar

  @override
  void initState() {
    super.initState();
    tabs = [
      Home(),
      Search(),
      YourLibrary(),
      RadioScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blueGrey.shade900.withOpacity(0.8),
              Colors.blueGrey.shade600.withOpacity(0.5),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomNavigationBar(
                currentIndex: currentTabIndex,
                onTap: (currentIndex) {
                  currentTabIndex = currentIndex;
                  setState(() {}); // re render
                },
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.grey.shade900.withOpacity(0.8),
                unselectedItemColor: Colors.blueGrey.shade200,
                selectedItemColor: Colors.blueGrey.shade200,
                showUnselectedLabels: false,
                showSelectedLabels: false,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.library_books),
                    label: 'Your Library',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.radio),
                    label: 'Radio',
                  ),
                ],
              ),
            ],
          ),
          body: tabs[currentTabIndex],
        ));
  }
}
