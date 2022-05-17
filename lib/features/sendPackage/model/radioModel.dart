import 'package:flutter/material.dart';

class RadioModel {
  bool? isSelected;
  final Color? button;
  final String? text;
  final String? textToServer;

  RadioModel({this.isSelected, this.button, this.text, this.textToServer});

  static List<RadioModel> sampleData = [
    RadioModel(
        isSelected: true,
        button: Colors.black,
        text: "Immediately",
        textToServer: "immediate"),
    RadioModel(
        isSelected: false,
        button: const Color(0xffFEB816),
        text: "Scheduled for later",
        textToServer: "scheduled")
  ];
}
