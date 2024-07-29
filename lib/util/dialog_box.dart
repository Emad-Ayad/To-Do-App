import 'package:flutter/material.dart';
import 'package:todo_app/util/my-buttons.dart';

class DialogBox extends StatefulWidget {
  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  FocusNode focusNode = FocusNode();
  String hintText = 'Add New Task';

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        hintText = '';
      } else {
        hintText = 'Add New Task';
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              focusNode: focusNode,
              controller: widget.controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                hintText: hintText,
              ),
            ),
            Row(
              children: [
                MyButtons(text: "Save", onPressed: widget.onSave),
                SizedBox(width: 55),
                MyButtons(text: "Cancel", onPressed: widget.onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
