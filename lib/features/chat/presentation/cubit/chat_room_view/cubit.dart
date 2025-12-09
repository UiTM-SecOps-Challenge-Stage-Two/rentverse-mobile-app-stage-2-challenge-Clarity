import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'state.dart';

class ChatRoomViewCubit extends Cubit<ChatRoomViewState> {
  ChatRoomViewCubit()
      : super(ChatRoomViewState(
          controller: TextEditingController(),
          scrollController: ScrollController(),
        ));

  void scrollToBottom() {
    final sc = state.scrollController;
    if (!sc.hasClients) return;
    sc.animateTo(
      sc.position.maxScrollExtent + 60,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
    );
  }

  void clearInput() => state.controller.clear();

  @override
  Future<void> close() {
    state.controller.dispose();
    state.scrollController.dispose();
    return super.close();
  }
}
