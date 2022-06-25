import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  String weather = "";
  String search = "";
  List<dynamic> playlists = [];
  late WebViewXController webviewController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map;
    weather = data['weather'];
    playlists = data['playlistsFrames'];
    
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Text(weather),
          playlists.length > 0 ? WebViewX(
            initialContent: '<html><body>${playlists[0].toString()}</body></html>',
            initialSourceType: SourceType.html, height: 200, width: 500,
            onWebViewCreated: (controller) => webviewController = controller,
          ) : const Text("Pas de playlist")
        ],)
           ),
        );
  }
}
