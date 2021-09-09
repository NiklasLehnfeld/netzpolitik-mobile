import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:netzpolitik_mobile/models/audio_model.dart';

class AudioPlayer extends ChangeNotifier {

  late AssetsAudioPlayer _assetsAudioPlayer;
  AudioModel? _audio;

  AudioPlayer() {
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    _assetsAudioPlayer.realtimePlayingInfos.listen((event) => notifyListeners());
  }

  bool get isPlaying => _assetsAudioPlayer.isPlaying.value;
  bool get isBuffering => _assetsAudioPlayer.isBuffering.value;
  bool get isOpened => _audio != null;

  Duration? get totalDuration {
    if (_assetsAudioPlayer.realtimePlayingInfos.hasValue) {
      return _assetsAudioPlayer.realtimePlayingInfos.value.duration;
    }
    return null;
  }

  Duration? get currentDuration {
    if (_assetsAudioPlayer.currentPosition.hasValue) {
      return _assetsAudioPlayer.currentPosition.value;
    }
    return null;
  }

  set currentDuration(Duration? value) => _assetsAudioPlayer.seek(value ?? Duration());
  
  String? get title => _audio?.title;

  bool isPlayingAudio(AudioModel audio) => isPlaying && _audio?.url == audio.url;
  bool isBufferingAudio(AudioModel audio) => isBuffering && _audio?.url == audio.url;

  void close() {
    _audio = null;
    _assetsAudioPlayer.stop();
    notifyListeners();
  }
  
  void openOrToggle(AudioModel audio) {
    if (_audio != null && _audio?.url == audio.url) {
      toggle();
    } else if (audio.url != null){
      open(audio.url!);
      _audio = audio;
    }
  }

  void open(String url) => _assetsAudioPlayer.open(Audio.network(url));

  void toggle() => _assetsAudioPlayer.playOrPause();

}