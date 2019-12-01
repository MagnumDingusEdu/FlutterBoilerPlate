import 'package:flutter/material.dart';
import 'package:magnumdingus/homepage.dart';
import 'package:magnumdingus/material_basic.dart';
import 'package:magnumdingus/placeholder_widget.dart';
import 'package:magnumdingus/ListView.dart';
import 'package:magnumdingus/reddit_scraper.dart';
import 'package:magnumdingus/sidebar.dart';
import 'package:magnumdingus/form.dart';
import 'package:url_launcher/url_launcher.dart';

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


class HomeApp extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      return _HomeState();
    }
}


class _HomeState extends State<HomeApp>{
  int _currentIndex = 0;
  final List<Widget> _children = [

    RedditScraperHome(),

    RandomWords(),
    HomePage(),
  ];

  void onTabTapped(int index) {
    if(index == 3){
      index = 0;
      _launchURL("http://bitly.com/98K8eH");
    };
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
            title: Text("RedditBrowser")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text("Favorites")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.brush),
            title: Text("Paint")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            title: Text("Cloud")
          ),          

         
          
        ],
      ),
    );
  }
}