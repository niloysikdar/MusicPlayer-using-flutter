import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicApp(),
    );
  }
}

class MusicApp extends StatefulWidget {
  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  bool playing = false;
  IconData playBtn = Icons.play_arrow;

  AudioPlayer _player;
  AudioCache cache;

  Duration position = new Duration();
  Duration musiclength = new Duration();

  Widget slider() {
    return Container(
      width: 230.0,
      child: Slider.adaptive(
        activeColor: Colors.black,
        inactiveColor: Colors.grey,
        value: position.inSeconds.toDouble(),
        max: musiclength.inSeconds.toDouble(),
        onChanged: (value) {
          seekToSec(value.toInt());
        },
      ),
    );
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    _player.durationHandler = (d) {
      setState(() {
        musiclength = d;
      });
    };

    _player.positionHandler = (p) {
      setState(() {
        position = p;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green[800],
              Colors.green[400],
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Text(
                  "Music Player",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Play your favourite songs ad-free",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 30.0),
                Center(
                  child: Container(
                    height: 250.0,
                    width: 250.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: AssetImage("assets/musicbg.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  "Jadi Buti",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Major Lazer & Nucleya",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: Container(
                    margin:
                        EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "${position.inMinutes}:${position.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            slider(),
                            Text(
                              "${musiclength.inMinutes}:${musiclength.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {},
                              iconSize: 50.0,
                              icon: Icon(
                                Icons.skip_previous,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (!playing) {
                                  cache.play("JadiButi.mp3");
                                  setState(() {
                                    playBtn = Icons.pause;
                                    playing = true;
                                  });
                                } else {
                                  _player.pause();
                                  setState(() {
                                    playBtn = Icons.play_arrow;
                                    playing = false;
                                  });
                                }
                              },
                              iconSize: 65.0,
                              icon: Icon(
                                playBtn,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              iconSize: 50.0,
                              icon: Icon(
                                Icons.skip_next,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
