import 'package:flutter/material.dart';

InputDecoration getAuthenticationInputDecoration(String label) {
  return InputDecoration(
    label: Text(label),
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0xFFE2E8F0),
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0xFF002AFF),
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
  );
}
