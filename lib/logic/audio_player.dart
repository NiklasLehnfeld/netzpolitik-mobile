// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:netzpolitik_mobile/models/article.dart';
// import 'package:netzpolitik_mobile/extensions/article_ext.dart';
//
// class AudioPlayer extends ChangeNotifier {
//
//   late AssetsAudioPlayer _assetsAudioPlayer;
//   Article? currentPlayingArticle;
//
//   AudioPlayer() {
//     _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
//     _assetsAudioPlayer.realtimePlayingInfos.listen((event) => notifyListeners());
//   }
//
//   bool get isPlaying => _assetsAudioPlayer.isPlaying.value;
//   bool get isBuffering => _assetsAudioPlayer.isBuffering.value;
//   bool get isOpened => currentPlayingArticle != null;
//
//   Duration? get totalDuration {
//     if (_assetsAudioPlayer.realtimePlayingInfos.hasValue) {
//       return _assetsAudioPlayer.realtimePlayingInfos.value.duration;
//     }
//     return null;
//   }
//
//   Duration? get currentDuration {
//     if (_assetsAudioPlayer.currentPosition.hasValue) {
//       return _assetsAudioPlayer.currentPosition.value;
//     }
//     return null;
//   }
//
//   set currentDuration(Duration? value) => _assetsAudioPlayer.seek(value ?? Duration());
//
//   String? get title => currentPlayingArticle?.title;
//
//   bool isPlayingArticle(Article article) => isPlaying && currentPlayingArticle?.mp3Url == article.mp3Url;
//   bool isBufferingArticle(Article article) => isBuffering && currentPlayingArticle?.mp3Url == article.mp3Url;
//
//   void close() {
//     currentPlayingArticle = null;
//     _assetsAudioPlayer.stop();
//     notifyListeners();
//   }
//
//   void openOrToggle(Article article) {
//     if (currentPlayingArticle != null && currentPlayingArticle?.mp3Url == article.mp3Url) {
//       toggle();
//     } else if (article.mp3Url != null){
//       open(article.mp3Url!);
//       currentPlayingArticle = article;
//     }
//   }
//
//   void open(String url) => _assetsAudioPlayer.open(Audio.network(url));
//
//   void toggle() => _assetsAudioPlayer.playOrPause();
//
//
//
// }