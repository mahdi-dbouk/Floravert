import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final bool isHidden;
  final int maxLines;

  const TextInput(
      {super.key,
      required this.controller,
      required this.label,
      required this.placeholder,
      required this.isHidden,
      required this.maxLines});

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            const SizedBox(height: 5),
            TextField(
              maxLines: widget.maxLines,
              controller: widget.controller,
              obscureText: widget.isHidden ? _obscureText : !_obscureText,
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: widget.placeholder,
                  labelText: widget.label,
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.normal,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade400, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  suffixIcon: widget.isHidden
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: _obscureText
                                ? Colors.grey.shade400
                                : Colors.green,
                          ),
                        )
                      : null),
            )
          ],
        ));
  }
}
