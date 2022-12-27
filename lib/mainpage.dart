import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:laba8/dummy_data.dart';
import 'package:laba8/main.dart';
import 'package:laba8/screens/login/auth_page.dart';
import 'package:laba8/screens/tracks/albums_screen.dart';

final player = AudioPlayer(playerId: '1');
PlayerState state = PlayerState.playing;
Duration duration = Duration.zero;
Duration position = Duration.zero;
bool isPlaying = false;
int currSong = 0;
int currAlbum = 0;
int currPict = 0;
String songName = '';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {



  @override
  void initState() {
    player.onPlayerStateChanged.listen((event) {
      setState(() {
        state = event;
      });
    });

    super.initState();

    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  void startPlayer() async {
    if (state != PlayerState.playing) {
      await player.resume();
    }
    else {
      await player.pause();
    }
  }

  void changeMusic(String action) async {
    if (action == 'next'){
      try{


        currSong++;
        print(currSong);
        await player.play(UrlSource(albumsList[currAlbum].songsList[currSong].url));
        songName = albumsList[currAlbum].songsList[currSong].songName;
      }
      catch (e){
        player.stop();
        songName = '';
        duration = Duration.zero;
        position = Duration.zero;
      }
    }
    else if (action == 'back'){
      try{

        currSong--;
        print(currSong);
        await player.play(UrlSource(albumsList[currAlbum].songsList[currSong].url));
        songName = albumsList[currAlbum].songsList[currSong].songName;
      }
      catch (e){
        player.stop();
        songName = '';
        duration = Duration.zero;
        position = Duration.zero;
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Проигрыватель"),

        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen()));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blue,
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    ' Выйти ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(currAlbum == 0)
              Image.asset("assets/pictures/Queen.jpg"),
            if(currAlbum == 1)
              Image.asset("assets/pictures/Pantera.jpg"),
            Text(songName),

            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(position.inSeconds)),
                  Text(formatTime((duration - position).inSeconds)),
                ],
              ),
            ),
            Slider(min: 0, max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (value) {
                  final position = Duration(seconds: value.toInt());
                  player.seek(position);
                  player.resume();
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      changeMusic('back');
                    },
                    child: const Icon((Icons.arrow_left))),
                ElevatedButton(
                  onPressed: startPlayer,
                  child: state != PlayerState.playing
                      ? Icon(Icons.play_arrow)
                      : Icon(Icons.pause),
                ),
                ElevatedButton(
                    onPressed: () {
                      player.stop();
                    },
                    child: const Icon((Icons.stop))
                ),
                ElevatedButton(
                    onPressed: () {
                      changeMusic('next');
                    },
                    child: const Icon((Icons.arrow_right)))
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => AlbumsScreen()));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue,
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      ' выбрать трек ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}