import 'package:flutter/material.dart';

emailValidator(String email) {
  if (email.contains('@')) {
    if (email.split('@')[1].contains('.')) {
      return true;
    }
  }
  return false;
}
createTextForm(TextEditingController controller, String label, IconData icon,
        {bool isObscure}) =>
    TextFormField(
        controller: controller,
        obscureText: isObscure ?? false,
        decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon),
            border: UnderlineInputBorder(),
            hintText: ' $label'));
