import 'package:flutter/material.dart';
import '../services/chat_service.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, String>> messages = [];
  final TextEditingController messageController = TextEditingController();

  late ChatService chatService;

  @override
  void initState() {
    super.initState();
    chatService = ChatService();
    chatService.connect((String senderId, String content, String timestamp) {
      setState(() {
        messages.add({
          'sender': senderId,
          'content': content,
          'timestamp': timestamp,
        });
      });
    });
  }

  void _sendMessage() {
    final message = messageController.text;
    if (message.isNotEmpty) {
      chatService.sendMessage(message);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Public Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Text(
                    message['content'] ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      'From: ${message['sender']} at ${message['timestamp']}'),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    hintText: 'Type your message...',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    chatService.disconnect();
    super.dispose();
  }
}

