import 'dart:convert';

import 'package:stomp_dart_client/stomp_dart_client.dart';

class ChatService {
  late StompClient stompClient;

  void connect(Function(String, String, String) onMessageReceived) {
    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://10.0.2.2:8080/chat/websocket',
        onConnect: (StompFrame frame) {
          print('Connected to WebSocket');
          stompClient.subscribe(
            destination: '/topic/public',
            callback: (StompFrame frame) {
              // Parse the JSON message
              final messageData = jsonDecode(frame.body!);
              final senderId = messageData['senderId'];
              final content = messageData['content'];
              final timestamp = messageData['timestamp'];

              onMessageReceived(senderId.toString(), content, timestamp ?? 'Unknown time');
            },
          );
        },
        onWebSocketError: (dynamic error) => print('WebSocket Error: $error'),
      ),
    );
    stompClient.activate();
  }


  void sendMessage(String message) {
    stompClient.send(
      destination: '/app/sendMessage', // Matches @MessageMapping in backend
      body: message,
    );
  }

  void disconnect() {
    stompClient.deactivate();
  }
}
