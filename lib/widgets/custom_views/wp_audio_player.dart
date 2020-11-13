import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';
import 'package:wordpress_blog_app_template/logic/audio_player.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/height.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_expanded_section.dart';

const PLAYER_HEIGHT = 80.0;

class WPAudioPlayer extends StatefulWidget {
  const WPAudioPlayer();

  @override
  _WPAudioPlayerState createState() => _WPAudioPlayerState();
}

class _WPAudioPlayerState extends State<WPAudioPlayer> {

  @override
  Widget build(BuildContext context) {
    var audioPlayer = context.watch<AudioPlayer>();

    return WPExpandedSection(
      expand: audioPlayer.isOpened,
      child: Container(
        height: PLAYER_HEIGHT,
        width: context.width,
        color: context.audioPlayerBackground,
        child: Column(
          children: [
            Height(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTitle(context, audioPlayer),
                _buildTime(context, audioPlayer)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPlayButton(context, audioPlayer),
                Expanded(child: _buildSlider(context, audioPlayer)),
                _buildCloseButton(context, audioPlayer),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTime(BuildContext context, AudioPlayer audioPlayer) => Padding(
    padding: const EdgeInsets.only(right: 16.0),
    child: Text(audioPlayer.currentDuration.toReadableString(),  maxLines: 1, style: context.body2.copyWith( fontWeight:  FontWeight.bold)),
  );

  Widget _buildTitle(BuildContext context, AudioPlayer audioPlayer) => Container(
      margin: EdgeInsets.only(left: 16),
      width: context.width / 1.3,
      child: Text(audioPlayer.title ?? '',  style: context.body2.copyWith( fontWeight:  FontWeight.bold), overflow: TextOverflow.ellipsis,)
  );

  Widget _buildSlider(BuildContext context, AudioPlayer audioPlayer) {

    var currentDuration = audioPlayer.currentDuration;
    var rawTotalDuration = audioPlayer.totalDuration?.inSeconds;

    var totalDuration = rawTotalDuration != null && rawTotalDuration > 0 ? rawTotalDuration : 1;

    return Slider(
      value: currentDuration.inSeconds.toDouble(),
      max: totalDuration.toDouble(),
      divisions: totalDuration,
      onChanged: (value) => audioPlayer.currentDuration = Duration(seconds: value.toInt()),
      label: audioPlayer.currentDuration.toReadableString(),
    );
  }

  Widget _buildCloseButton(BuildContext context, AudioPlayer audioPlayer) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 16),
      child: IconButton(
        onPressed: () => audioPlayer.close(),
        icon: FaIcon(
          FontAwesomeIcons.times,
          color: context.primaryColor,
        ),
      ),
    );
  }

  Widget _buildPlayButton(BuildContext context, AudioPlayer audioPlayer) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 8),
      child: IconButton(
        onPressed: () => audioPlayer.toggle(),
        icon: FaIcon(
          audioPlayer.isPlaying
              ? FontAwesomeIcons.pause
              : FontAwesomeIcons.play,
          color: context.primaryColor,
        ),
      ),
    );
  }
}

extension on Duration {

  String toReadableString()  {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    var twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    var twoDigitSeconds = twoDigits(inSeconds.remainder(60));
    return '${twoDigits(inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

}

