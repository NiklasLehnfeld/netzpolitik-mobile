import 'package:flutter/material.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_audio_player.dart';


class WPBottomNavigation extends StatefulWidget {

  final int index;
  final List<BottomNavigationBarItem> items;
  final Function(int) onTap;

  const WPBottomNavigation({required this.index, required this.items, required this.onTap});

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
      onTap: widget.onTap,
      selectedItemColor: context.primaryColor,
      unselectedItemColor: context.caption.color,
  );

}