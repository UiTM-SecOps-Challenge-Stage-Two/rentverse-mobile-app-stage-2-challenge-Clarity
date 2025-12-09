import 'package:flutter/widgets.dart';

class ChatRoomViewState {
  const ChatRoomViewState({
    required this.controller,
    required this.scrollController,
  });

  final TextEditingController controller;
  final ScrollController scrollController;
}
