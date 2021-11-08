import 'package:duo_online/duo_audio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DuoApp());
}

class DuoApp extends StatelessWidget {
  const DuoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DUO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(title: 'Flutter Demo Home Page'),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _seekbarValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('English Text'),
            Text('Japanese Text'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.skip_previous),
            label: 'back',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: 'play',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.skip_next),
            label: 'skip',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            DuoAudio().skipPrevious();
          } else if (index == 1) {
            DuoAudio().onClick();
          } else if (index == 2) {
            DuoAudio().skipNext();
          }
        },
      ),
      persistentFooterButtons: [
        Slider(
          value: _seekbarValue,
          onChanged: (newValue) {
            setState(() {
              _seekbarValue = newValue;
            });
          },
          min: 0,
          max: 100,
        ),
      ],
    );
  }
}
