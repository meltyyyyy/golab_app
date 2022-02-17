import 'package:flutter/material.dart';

class WrapToggleTextButtons extends StatefulWidget {
  final List<String> textList;
  final List<dynamic> isSelected;
  final Function onTap;

  const WrapToggleTextButtons({
    Key? key,
    required this.textList,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  _WrapToggleTextButtonsState createState() => _WrapToggleTextButtonsState();
}

class _WrapToggleTextButtonsState extends State<WrapToggleTextButtons> {
  late int index;

  @override
  Widget build(BuildContext context) {
    index = -1;
    return Wrap(
      direction: Axis.horizontal,
      spacing: 20,
      runSpacing: 15,
      children: widget.textList.map((String text) {
        index++;
        return TextToggleButton(
          active: widget.isSelected[index],
          onTap: widget.onTap,
          text: text,
          index: index
        );
      }).toList(),
    );
  }
}

class TextToggleButton extends StatelessWidget {
  final bool active;
  final String text;
  final Function onTap;
  final int index;

  const TextToggleButton({
    Key? key,
    required this.active,
    required this.text,
    required this.onTap,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 20),
      decoration: BoxDecoration(
        gradient: active ? const LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.topRight
        ) : const LinearGradient( colors: [Colors.grey, Colors.grey] ),
        borderRadius: BorderRadius.circular(25)
      ),
      child: InkWell(
        child: Text(text, style: const TextStyle(color: Colors.white)),
        onTap: () => onTap(index),
      ),
    );
  }
}