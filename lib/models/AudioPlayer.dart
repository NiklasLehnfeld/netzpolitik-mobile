import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';

class AudioPlayer extends ChangeNotifier {

  AssetsAudioPlayer _assetsAudioPlayer;
  String currentlyStreaming;

  AudioPlayer() {
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    _assetsAudioPlayer.isPlaying.listen((event) => notifyListeners());
    _assetsAudioPlayer.isBuffering.listen((event) => notifyListeners());
  }

  bool get isPlaying => _assetsAudioPlayer.isPlaying.value;
  bool get isBuffering => _assetsAudioPlayer.isBuffering.value;

  bool isPlayingUrl(String url) => isPlaying && currentlyStreaming == url;
  bool isBufferingUrl(String url) => isBuffering && currentlyStreaming == url;

  void openOrToggle(String url) {
    if (currentlyStreaming == url) {
      toggle();
    } else {
      open(url);
    }
  }

  void open(String url) {
    _assetsAudioPlayer.open(Audio.network(url));
    currentlyStreaming = url;
  }

  void toggle() => _assetsAudioPlayer.playOrPause();




}