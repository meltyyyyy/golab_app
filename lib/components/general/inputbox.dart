import 'package:flutter/material.dart';

class InputBoxWidget extends StatefulWidget {
  final String boxTitle;
  final Function getInput;

  const InputBoxWidget({Key? key, required this.boxTitle, required this.getInput}) : super(key: key);

  @override
  State<InputBoxWidget> createState() => _InputBoxWidgetState();
}

class _InputBoxWidgetState extends State<InputBoxWidget> {
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
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 50,
      decoration: BoxDecoration(color: const Color.fromRGBO(230, 230, 230, 100),borderRadius: BorderRadius.circular(5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: TextField(
                  decoration: InputDecoration(
                      hintText: widget.boxTitle,
                      border: InputBorder.none
                  ),
                  controller: _textEditingController,
                  onChanged: (text) {
                    setState(() {
                      widget.getInput(text);
                    });
                    },
              )
          ),
          const Icon(Icons.edit,color: Color.fromRGBO(150, 150, 150, 100))
        ],
      ),
    );
  }
}