import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Message extends Equatable {
  const Message({
    required this.conversationId,
    required this.content,
    required this.createdAt,
    required this.sender,
  });

  final String conversationId;
  final String content;
  final DateTime createdAt;
  final String sender;

  @override
  List<Object?> get props => [conversationId, content, createdAt, sender];
}
