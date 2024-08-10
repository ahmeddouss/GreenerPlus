// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class CustomChoice extends StatefulWidget {
  const CustomChoice({
    super.key,
    this.width,
    this.height,
    required this.childNumebr,
    this.iconButton,
    this.onAction,
    this.textButton,
    required this.border,
    required this.color,
  });

  final double? width;
  final double? height;
  final int childNumebr;
  final List<Widget>? iconButton;
  final Future Function(int? index)? onAction;
  final String? textButton;
  final double border;
  final Color color;

  @override
  State<CustomChoice> createState() => _CustomChoiceState();
}

class _CustomChoiceState extends State<CustomChoice> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: List.generate(widget.childNumebr, (index) {
        return ElevatedButton(
          onPressed: () async {
            if (widget.onAction != null) {
              await widget.onAction!(index);
            }
          },
          child: Text('Sign In'),
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.border ?? 8.0),
            ),
            minimumSize: Size(widget.width ?? 50.0, widget.height ?? 50.0),
          ),
        );
      }),
    ));
  }
}
