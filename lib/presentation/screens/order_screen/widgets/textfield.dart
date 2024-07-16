import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  const TextFieldWidget(
      {super.key, required this.label, required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 166, 201, 231).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            //  offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(15), // Border radius
      ),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 234, 243, 249),
          labelText: label,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 173, 215, 245), width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 214, 233, 247)),
            borderRadius: BorderRadius.circular(15),
          ),
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black),
        ),
        validator: (value) => _validate(value!),
      ),
    );
  }

  String? _validate(String value) {
    if (value.isEmpty) {
      return 'Please enter your ${label.toLowerCase()}';
    }

    // Perform validation based on the label
    if (label == 'Email') {
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
        return 'Please enter a valid email';
      }
    } else if (label == 'Contact') {
      if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
        return 'Please enter a valid phone number';
      }
    }

    return null;
  }
}
