import 'package:flutter/material.dart';

class SideBar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SideBarState();
  }
}

class _SideBarState extends State<SideBar>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My Drawer App"),
        backgroundColor: Colors.redAccent,

      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage("https://i.imgur.com/LfV8TBp.jpg"),
                ),
                onTap: () => print("This is the current user"),
              ),
              accountName: new Text("u/ThaparDong"),
              accountEmail: new Text("vividhinnovationslimited@gmail.com"),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.fill,
                 image: new NetworkImage("https://i.imgur.com/h60KTcC.jpg"),
                ),
              ),
            ),
            new ListTile(
              title: Text("Item 1"),
              leading: Icon(Icons.info),

            ),
            new ListTile(
              title: Text("Item 2"),
              leading: Icon(Icons.arrow_back),

            ),
            new Container(
              height: 410,
            ),
            new ListTile(
              title: Text(
                "Close",
                textAlign: TextAlign.left,
                ),
              trailing: Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),

            ),                        
          ],
        ),
      ),
      body: new Center(
        child: new Text(
          "HomePage",
          style: TextStyle(
            fontSize: 35.0,
          ),
          ),
      ),
    );
  }
}