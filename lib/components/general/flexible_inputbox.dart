import 'package:flutter/material.dart';

class FlexibleInputBoxWidget extends StatefulWidget {
  final Function getInput;

  const FlexibleInputBoxWidget({Key? key, required this.getInput,}) : super(key: key);

  @override
  State<FlexibleInputBoxWidget> createState() => _FlexibleInputBoxWidgetState();
}

class _FlexibleInputBoxWidgetState extends State<FlexibleInputBoxWidget> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(230, 230, 230, 100),
          borderRadius: BorderRadius.circular(5)
      ),
      child: TextField(
        decoration: const InputDecoration(border: InputBorder.none),
        controller: _textEditingController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        maxLength: 500,
        onChanged: (text) {
          setState(() {
            widget.getInput(text);
          });
        },
      ),
    );
  }
}
