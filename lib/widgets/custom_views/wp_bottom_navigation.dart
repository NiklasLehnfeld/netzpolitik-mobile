import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_audio_player.dart';


class WPBottomNavigation extends StatefulWidget {

  final int index;
  final List<BottomNavigationBarItem> items;
  final Function(int) onTap;

  const WPBottomNavigation({this.index, this.items, this.onTap});

  @override
  _WPBottomNavigationState createState() => _WPBottomNavigationState();
}

class _WPBottomNavigationState extends State<WPBottomNavigation> {

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(
          children: [
            _buildNavigation(),
            WPAudioPlayer()
          ],
        ),
      ],
    );
  }


  Widget _buildNavigation() => BottomNavigationBar(
      elevation: 4.0,
      showUnselectedLabels: false,
      currentIndex: widget.index,
      items: widget.items,
      onTap: widget.onTap
  );

}