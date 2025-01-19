import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/modules/chat/shared/chat_header.dart';

import '../../core/constants/asset_paths.dart';
import 'services/chat_message.dart';
import 'shared/chat_bubble.dart';
import 'shared/chat_field.dart';

class ChatScreen extends StatefulWidget {
  static const id = 'ChatScreen';

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final ValueNotifier<List<ChatMessage>> _messages = ValueNotifier([]);

  @override
  void dispose() {
    _messages.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.background,
      appBar: ChatHeader(),
      body: Stack(
        children: [
          Image.asset(
            AppAssets.bg,
            width: 1.sw,
            height: 1.sh,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: _messages,
                    builder: (context, messages, _) {
                      messages.sort((a, b) {
                        return b.time.compareTo(a.time);
                      });

                      return ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, i) => ChatBubble(
                          message: messages[i],
                          status: MessageStatus.delivered,
                        ),
                      );
                    },
                  ),
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    ChatField(
                      controller: _controller,
                    ),
                    10.width,
                    TapWidget(
                      radius: 100,
                      onTap: _send,
                      color: ThemeColor.primary,
                      padding: EdgeInsets.all(7.r),
                      child: Icon(
                        Icons.send,
                        size: 18.r,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                25.height,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      final message = ChatMessage(
        text: text,
        senderName: 'User',
        senderUid: 'user123',
        createdAt: DateTime.now(),
      );
      // Only add message if it's not empty
      _messages.value = [..._messages.value, message]; // Add the message to the list
      _controller.clear(); // Optionally clear the text field after sending
    }
  }
}
