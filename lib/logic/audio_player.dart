import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:wordpress_blog_app_template/models/audio_model.dart';

class AudioPlayer extends ChangeNotifier {

  AssetsAudioPlayer _assetsAudioPlayer;
  AudioModel _audio;

  AudioPlayer() {
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    _assetsAudioPlayer.realtimePlayingInfos.listen((event) => notifyListeners());
  }

  bool get isPlaying => _assetsAudioPlayer.isPlaying.value;
  bool get isBuffering => _assetsAudioPlayer.isBuffering.value;
  bool get isOpened => _audio != null;

  Duration get totalDuration => _assetsAudioPlayer.realtimePlayingInfos.value?.duration;
  Duration get currentDuration => _assetsAudioPlayer.currentPosition?.value;
  set currentDuration(Duration value) => _assetsAudioPlayer.seek(value);
  
  String get title => _audio?.title;

  bool isPlayingAudio(AudioModel audio) => isPlaying && _audio.url == audio.url;
  bool isBufferingAudio(AudioModel audio) => isBuffering && _audio.url == audio.url;

  void close() {
    _audio = null;
    _assetsAudioPlayer.stop();
    notifyListeners();
  }
  
  void openOrToggle(AudioModel audio) {
    if (_audio != null && _audio.url == audio.url) {
      toggle();
    } else {
      open(audio);
      _audio = audio;
    }
  }

  void open(AudioModel audioModel) => _assetsAudioPlayer.open(Audio.network(audioModel.url));

  void toggle() => _assetsAudioPlayer.playOrPause();

}