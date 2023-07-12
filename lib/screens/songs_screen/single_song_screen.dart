import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SingleSongScreen extends StatefulWidget {
  const SingleSongScreen({Key? key}) : super(key: key);

  @override
  State<SingleSongScreen> createState() => _SingleSongScreenState();
}

class _SingleSongScreenState extends State<SingleSongScreen> {

  final _audioPlayer = AudioPlayer();
  late final SongModel recoverSong;
  bool _isSongPlaying = false;
  bool _shouldAskArgumentRoute = true;

  Duration duration = const Duration();
  Duration position = const Duration();


  _getArgumentRoute(){
    recoverSong = ModalRoute.of(context)!.settings.arguments as SongModel;
    _shouldAskArgumentRoute = false;
    setState(() {});
  }
  _backToSongList() {
    _stopSong();
    Navigator.of(context).pop();
  }
  _handlePlayerSlider(double value) {
    var duration = Duration(seconds: value.toInt());
    _audioPlayer.seek(duration);
    setState(() {});
  }
  _moveToPreviousSong() {}
  _togglePlaying() {
    if(_isSongPlaying) {
      _audioPlayer.pause();
    }else {
      _audioPlayer.play();
    }
    _isSongPlaying = !_isSongPlaying;
    setState(() {});
  }
  _moveToNextSong() {}
  _playSong({required String? songUri}) {
    try {
      _audioPlayer.setAudioSource(
          AudioSource.uri(Uri.parse(songUri!))
      );
      _audioPlayer.play();
      _isSongPlaying = true;
      _audioPlayer.durationStream.listen((duration) {
        this.duration = duration!;
        setState(() {});
      });
      _audioPlayer.positionStream.listen((position) {
        this.position = position;
        setState(() {});
      });
      setState(() {});
    } on Exception {
      log("Error when trying to play song!");
    }
  }

  _stopSong() {
    if(_isSongPlaying) {
      _audioPlayer.stop();
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    if(_shouldAskArgumentRoute) {
      _getArgumentRoute();
      _playSong(songUri: recoverSong.uri);
    }
    return Scaffold(
      body:  SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: _bodyWidget(recoverSong),
      ),
    );
  }

  _bodyWidget(SongModel song) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              _backButtonWidget(),
              const SizedBox(height: 120),
              _playingSongIconWidget(),
              _songNameWidget(song.displayNameWOExt),
              _artistNameWidget(song.artist),
              SizedBox(
                height: 90,
                child: _songPlayerSliderWidget(),
              ),
              SizedBox(
                height: 30,
                child: _songPlayerControlButtonsWidget(),
              )
            ],
          ),
        )
    );
  }

  _songNameWidget(String songName) {
    return SizedBox(
      height: 90,
      child:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
        child: Center(
          child: Text(
            songName,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
        ),
      ),
    );
  }

  _artistNameWidget(String? artistName) {
    return SizedBox(
      height: 50,
      child:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Text(
            (artistName == '<unknown>') || (artistName == null) ? "Borel Njeunkwe" : artistName ,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    );
  }

  _backButtonWidget() {
    return IconButton(
        onPressed: () => _backToSongList(),
        icon: const Icon(Icons.arrow_back_ios),
    );
  }

  _playingSongIconWidget() {
    return const Center(
      child: CircleAvatar(
        radius: 150,
        child: Icon(
          Icons.music_note,
          size: 90,
        ),
      ),
    );
  }

  _songPlayerSliderWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text(
             position.toString().split(".")[0]
        ),
        Expanded(
          child: Slider(
            value: position.inSeconds.toDouble(),
            min: 0.0,
            max: duration.inSeconds.toDouble(),
            onChanged: (value) => _handlePlayerSlider(value),
          ),
        ),
         Text(
          duration.toString().split(".")[0]
        ),
      ],
    );
  }

  _songPlayerControlButtonsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: () => _moveToPreviousSong(),
            icon: const Icon(
              Icons.skip_previous,
              size: 40,
            ),
        ),
        IconButton(
            onPressed: () => _togglePlaying(),
            icon: Icon(
              _isSongPlaying
                  ? Icons.pause_outlined
                  : Icons.play_arrow,
              size: 40,
              color: Colors.lightBlueAccent.withOpacity(0.9),
            ),
        ),
        IconButton(
            onPressed: () => _moveToNextSong(),
            icon: const Icon(
              Icons.skip_next,
              size: 40,
            ),
        ),
      ],
    );
  }

}
