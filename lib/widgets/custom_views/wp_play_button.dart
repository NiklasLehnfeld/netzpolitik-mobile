import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';
import 'package:wordpress_blog_app_template/models/AudioPlayer.dart';

class WPPlayButton extends StatelessWidget {
  final double size;
  final String url;

  const WPPlayButton({this.size = 60, this.url});

  @override
  Widget build(BuildContext context) {
    var audioPlayer = context.watch<AudioPlayer>();
    var isBuffering = audioPlayer.isBufferingUrl(url);

    return _buildBackground(
      context,
      child: isBuffering ? CircularProgressIndicator() : _buildPlayButton(context)
    );
  }

  Widget _buildPlayButton(BuildContext context) {
    var audioPlayer = context.watch<AudioPlayer>();
    var isPlaying = audioPlayer.isPlayingUrl(url);

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

  Widget _buildBackground(BuildContext context, {Widget child}) {
    var audioPlayer = context.watch<AudioPlayer>();
    var isPlaying = audioPlayer.isPlayingUrl(url);

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: isPlaying ? 0 : 7),
      child: child,
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
    );
  }

  void _onPress(AudioPlayer audioPlayer) => audioPlayer.openOrToggle(url);
}
