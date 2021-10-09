import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/logic/audio_player.dart';
import 'package:netzpolitik_mobile/models/audio_model.dart';
import 'package:provider/provider.dart';

class WPPlayButton extends StatelessWidget {
  final double size;
  final AudioModel audio;

  const WPPlayButton({this.size = 60, required this.audio});

  @override
  Widget build(BuildContext context) {
    var audioPlayer = context.watch<AudioPlayer>();
    var isBuffering = audioPlayer.isBufferingAudio(audio);

    return _buildBackground(
      context,
      child: isBuffering ? CircularProgressIndicator() : _buildPlayButton(context)
    );
  }

  Widget _buildPlayButton(BuildContext context) {
    var audioPlayer = context.watch<AudioPlayer>();
    var isPlaying = audioPlayer.isPlayingAudio(audio);

    return IconButton(
      iconSize: size - 30,
      icon: FaIcon(
        isPlaying
            ? FontAwesomeIcons.pause
            : FontAwesomeIcons.play,
        color: context.iconButtonColor,
      ),
      onPressed: () => _onPress(audioPlayer),
    );
  }

  Widget _buildBackground(BuildContext context, {required Widget child}) {
    var audioPlayer = context.watch<AudioPlayer>();
    var isPlaying = audioPlayer.isPlayingAudio(audio);

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: isPlaying ? 0 : 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            spreadRadius: 0.0,
            offset: Offset(5.0, 5.0),
          )
        ],
      ),
      child: child,
    );
  }

  void _onPress(AudioPlayer audioPlayer) => audioPlayer.openOrToggle(audio);
}
