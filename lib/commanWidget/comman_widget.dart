import 'package:flutter/material.dart';

Widget button({
  required context,
  onPressd,
  required name,
  EdgeInsetsGeometry? padding,
}) {
  return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.red,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery.of(context).size.width,
      padding: padding,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          ),
          onPressed: onPressd,
          child: Text(
            name,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          )));
}
