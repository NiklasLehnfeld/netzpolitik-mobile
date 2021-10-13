import 'package:netzpolitik_mobile/models/article.dart';
import 'package:netzpolitik_mobile/extensions/string_ext.dart';

extension ArticleExteinsions on Article {

  bool get hasMp3 => content?.containsMP3 ?? false;

  String? get mp3Url => content?.mp3Url;

}
