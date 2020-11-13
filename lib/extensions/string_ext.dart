const MP3_REGEX = '>(https:\/\/.*.mp3)<';

extension MP3Checker on String {

  bool get containsMP3 => RegExp(MP3_REGEX).hasMatch(this);

  String get mp3Url => RegExp(MP3_REGEX).firstMatch(this)?.group(1);

}