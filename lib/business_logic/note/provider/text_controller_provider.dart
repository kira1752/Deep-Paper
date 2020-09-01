import 'package:flutter/widgets.dart';

class TextControllerProvider {
  final TextEditingController _controller = TextEditingController();

  TextEditingController get controller => _controller;
}