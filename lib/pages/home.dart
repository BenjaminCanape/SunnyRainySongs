import 'package:carousel_slider/carousel_slider.dart';
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
  String iconWeather = "";
  String search = "";
  bool isDay = true;
  List<dynamic> playlists = [];
  late WebViewXController webviewController;
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map;
    weather = data['weather'];
    isDay = data['isDay'];
    iconWeather = 'http:' + data['iconWeather'].toString();
    playlists = data['playlistsFrames'];

    Color bgColor = isDay ? Colors.blue.shade200 : Colors.blueGrey.shade900;
    Color textColor = isDay ? Colors.black : Colors.white;

    print(iconWeather);

    return  Scaffold(
        backgroundColor: bgColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(iconWeather),
          Text(weather, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: textColor),),
          SizedBox(height: 80,),
          Center(
            child: CarouselSlider(
              options: CarouselOptions(
                  height: 200.0,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
              items: playlists.map((playlist) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(color: Colors.amber),
                        child: WebViewX(
                          initialContent:
                              '<html><body>${playlist.toString()}</body></html>',
                          initialSourceType: SourceType.html,
                          height: 200,
                          width: 500,
                          onWebViewCreated: (controller) =>
                              webviewController = controller,
                        ));
                  },
                );
              }).toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: playlists.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (textColor).withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          )
        ],
      )
    );
  }
}
