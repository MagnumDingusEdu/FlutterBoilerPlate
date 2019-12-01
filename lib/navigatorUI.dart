import 'package:flutter/material.dart';
import 'package:magnumdingus/homepage.dart';
import 'package:magnumdingus/placeholder_widget.dart';
import 'package:magnumdingus/ListView.dart';
import 'package:magnumdingus/reddit_scraper.dart';
import 'package:magnumdingus/sidebar.dart';
import 'package:magnumdingus/form.dart';

class HomeApp extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      return _HomeState();
    }
}


class _HomeState extends State<HomeApp>{
  int _currentIndex = 0;
  final List<Widget> _children = [
        SideBar(),

    RedditScraperHome(),

    RandomWords(),
    HomePage(),
    QueryForm(),
  ];

  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _children[_currentIndex],
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        
        
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("HomePage")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text("List Generator")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.brush),
            title: Text("Paint")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Testing")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Testing2")
          ),          
          
        ],
      ),
    );
  }
}