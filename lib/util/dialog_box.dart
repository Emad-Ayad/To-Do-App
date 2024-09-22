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
  final _formKey = GlobalKey<FormState>();


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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                focusNode: focusNode,
                controller: widget.controller,
                textAlign: TextAlign.center,
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return "This field is empty !!";
                  }else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                  hintText: hintText,
                ),
              ),
              Row(
                children: [
                  MyButtons(text: "Save", onPressed:(){
                    if (_formKey.currentState!.validate()) {
                      widget.onSave();
                    }
                  }),
                  const SizedBox(width: 55),
                  MyButtons(text: "Cancel", onPressed: widget.onCancel),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
