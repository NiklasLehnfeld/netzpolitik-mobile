import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/logic/audio_player.dart';
import 'package:netzpolitik_mobile/models/article.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/height.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_expanded_section.dart';
import 'package:provider/provider.dart';

class WPAudioPlayer extends StatefulWidget {
  final Article? article;
  final bool alwaysVisible;
  final bool showTitleSection;
  final int backgroundAlpha;
  final bool showCross;

  const WPAudioPlayer(
      {this.article,
      this.alwaysVisible = false,
      this.showTitleSection = true,
      this.backgroundAlpha = 0,
      this.showCross = true});

  double? get playerHeight => showTitleSection ? 79.0 : 48.0;

  @override
  _WPAudioPlayerState createState() => _WPAudioPlayerState();
}

class _WPAudioPlayerState extends State<WPAudioPlayer> {

  Article? getArticle(BuildContext context) {
    var audioPlayer = context.read<AudioPlayer>();
    var article = widget.article;
    article ??= audioPlayer.currentPlayingArticle;
    return article;
  }

  @override
  Widget build(BuildContext context) {
    var audioPlayer = context.watch<AudioPlayer>();

    return WPExpandedSection(
      expand: widget.alwaysVisible || audioPlayer.isOpened,
      child: Container(
        padding: EdgeInsets.only(
            left: 16, right: 8,
            top: widget.showTitleSection ? 10 : 0),
        height: widget.playerHeight,
        width: context.width,
        color: context.audioPlayerBackground.withAlpha(widget.backgroundAlpha),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: widget.showTitleSection,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTitle(context, audioPlayer),
                  _buildTime(context, audioPlayer)
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPlayButton(context, audioPlayer),
                Expanded(child: _buildSlider(context, audioPlayer)),
                Visibility(
                    visible: widget.showCross,
                    child: _buildCloseButton(context, audioPlayer)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTime(BuildContext context, AudioPlayer audioPlayer) =>
      Text(audioPlayer.currentDuration?.toReadableString() ?? '',
          maxLines: 1,
          style: context.body2.copyWith(fontWeight: FontWeight.bold));

  Widget _buildTitle(BuildContext context, AudioPlayer audioPlayer) => Text(
        audioPlayer.title ?? '',
        style: context.body2.copyWith(fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      );

  Widget _buildSlider(BuildContext context, AudioPlayer audioPlayer) {

    var currentDuration = Duration();
    int? rawTotalDuration  = Duration().inSeconds;

    var article = getArticle(context);

    if (article != null && audioPlayer.currentPlayingArticle == article) {
      currentDuration = audioPlayer.currentDuration ?? Duration();
      rawTotalDuration = audioPlayer.totalDuration?.inSeconds;
    }

    var totalDuration =
        rawTotalDuration != null && rawTotalDuration > 0 ? rawTotalDuration : 1;

    return Slider(
      value: currentDuration.inSeconds.toDouble(),
      max: totalDuration.toDouble(),
      divisions: totalDuration,
      onChanged: (value) =>
          audioPlayer.currentDuration = Duration(seconds: value.toInt()),
      label: currentDuration.toReadableString(),
    );
  }

  Widget _buildCloseButton(BuildContext context, AudioPlayer audioPlayer) {
    return IconButton(
      onPressed: () => audioPlayer.close(),
      icon: FaIcon(
        FontAwesomeIcons.times,
        color: context.primaryColor,
      ),
    );
  }

  Widget _buildPlayButton(BuildContext context, AudioPlayer audioPlayer) {

    var article = getArticle(context);

    if (article == null) {
      return Container();
    }

    return IconButton(
      onPressed: () => audioPlayer.openOrToggle(article),
      icon: FaIcon(
        audioPlayer.isPlayingArticle(article) ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
        color: context.primaryColor,
      ),
    );
  }
}

extension on Duration {
  String toReadableString() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    var twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    var twoDigitSeconds = twoDigits(inSeconds.remainder(60));
    return '${twoDigits(inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }
}
