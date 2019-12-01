import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class PlaceHolderWidget extends StatelessWidget{
  final Color color;
  PlaceHolderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(color: color,);
  }
}

class SimpleMaterialApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TestAPp",
      home: Scaffold(
        appBar: AppBar(
          title: Text("HomePage"),
          backgroundColor: Colors.red,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.link),
              onPressed: _launchURL,
            )
          ],

        ),
        body: Center(
          child: Text("Welcome to the homepage of this flutter app"),
        ),
      ),

    );
  }
}

_launchURL() async {
  const url = 'https://magnum.wtf';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

// embedded browser

class WebViewExample extends StatefulWidget {
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  TextEditingController controller = TextEditingController();
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  var urlString = "https://magnum.wtf";

  launchUrl() {
    setState(() {
      urlString = controller.text;
      flutterWebviewPlugin.reloadUrl(urlString);
    });
  }

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged wvs) {
      print(wvs.type);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: urlString,
      withZoom: false,
    );
  }
}