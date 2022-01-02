library custom_switch;

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';

const FONT_SIZE = 16.0;
const ICON_SIZE = 24.0;
const ANIMATION_DURATION_IN_MS = 250;

class CustomSwitchState<T> {
  IconData icon;
  Color iconColor;
  Color backgroundColor;
  T value;
  String? text;

  CustomSwitchState({
    required this.backgroundColor,
    required this.value,
    required this.icon,
    required this.iconColor,
    this.text,
  });
}

class CustomSwitch<T> extends StatefulWidget {
  final T value;
  final ValueChanged<T> onChanged;
  final List<CustomSwitchState<T>> states;

  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.states,
  }) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState<T>();
}

class _CustomSwitchState<T> extends State<CustomSwitch<T>>
    with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    var currentState = widget.states.firstWhere((element) => element.value == widget.value);
    var currentStateIndex = widget.states.indexOf(currentState);
    var nextStateIndex = currentStateIndex + 1 > widget.states.length - 1 ? 0 : currentStateIndex + 1;

    var lerp = 1 / (widget.states.length-1) * currentStateIndex;
    var alignment = Alignment.lerp(Alignment.centerLeft, Alignment.centerRight, lerp)!;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            widget.onChanged(widget.states[nextStateIndex].value);
          },
          child: Container(
            width: 25.0 * widget.states.length,
            height: 35.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: currentState.backgroundColor,
            ),
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Align(
              alignment: alignment,
              child: Container(
                width: 25.0,
                height: 25.0,
                alignment: Alignment.center,
                child: FaIcon(
                  currentState.icon,
                  color: currentState.iconColor,
                  size: 23,
                ),
              ),
            ),
          ),
        ),
        currentState.text == null ? Container() :
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(currentState.text!, style: context.caption,),
        ),
      ],
    );
  }
}
