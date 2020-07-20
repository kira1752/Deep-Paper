import 'package:flutter/widgets.dart';

class TextControllerProvider {
  TextEditingController _controller = TextEditingController();

  TextEditingController get controller => _controller;
}