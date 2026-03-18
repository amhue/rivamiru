import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TextInput extends StatefulWidget {
  final String text;

  const TextInput({required this.text, super.key});

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late String inputText;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    inputText = widget.text;
    textEditingController.text = inputText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search anime",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.search),
      ),

      controller: textEditingController,

      onSubmitted: (String text) {
        setState(() {
          inputText = text;
        });
        context.push("/query/$text");
      },

      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
