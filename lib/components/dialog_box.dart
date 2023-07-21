import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController todoController;
  final Function()? save;
  final Function()? cancel;
  const DialogBox({
    super.key,
    required this.save,
    required this.cancel,
    required this.todoController,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade900,
      title: const Text(
        "Add ToDO",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      content: TextField(
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        controller: todoController,
        decoration: InputDecoration(
          focusColor: Colors.white,
          hintText: "To Do",
          hintStyle: TextStyle(
            color: Colors.grey.shade200,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400, width: 2.0),
          ),
          border: const OutlineInputBorder(),
        ),
      ),
      actions: [
        MaterialButton(
          // color: Colors.black45,
          onPressed: save,
          child: const Text(
            "Save",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        MaterialButton(
          onPressed: cancel,
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
