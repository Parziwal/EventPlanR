import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:event_planr/data/network/event_planr_api.dart';
import 'package:event_planr/domain/auth/auth_repository.dart';
import 'package:event_planr/domain/message/models/message.dart';
import 'package:event_planr/domain/message/models/user.dart';
import 'package:injectable/injectable.dart';

@singleton
class MessageRepository {
  MessageRepository(
    this.eventPlanrApi,
    this.authRepository,
  );

  final EventPlanrApi eventPlanrApi;
  final AuthRepository authRepository;

  static const allMessagesQuery = r'''
      query allMessages($conversationId: ID!) {
        allMessages(conversationId: $conversationId) {
          content
          conversationId
          createdAt
          sender
        }
      }
    ''';
  static const createMessageMutation = r'''
      mutation createMessage($conversationId: ID!, $content: String!, $createdAt: String!, $sender: String!) {
        createMessage(content: $content, conversationId: $conversationId, createdAt: $createdAt, sender: $sender) {
          content
          conversationId
          createdAt
          sender
        }
      }
    ''';
  static const messageSubscription = r'''
      subscription subscribeToNewMessage($conversationId: ID!) {
        subscribeToNewMessage(conversationId: $conversationId) {
          content
          conversationId
          createdAt
          sender
        }
      }
    ''';

  Future<List<User>> getUsers() async {
    final users = await eventPlanrApi.getUsers();
    final currentUser = await authRepository.user;
    return users
        .where((u) => u.email != currentUser.email)
        .map((u) => User(email: u.email, name: u.name))
        .toList();
  }

  Future<List<Message>> getMessages(String conversationId) async {
    final result = await Amplify.API
        .query(
          request: GraphQLRequest<String>(
            document: allMessagesQuery,
            variables: <String, dynamic>{
              'conversationId': conversationId,
            },
          ),
        )
        .response;

    final data = jsonDecode(result.data!) as Map<String, dynamic>;
    final messages = data['allMessages'] as List<dynamic>;

    return messages.map((m) {
      m = m as Map<String, dynamic>;
      return Message(
        conversationId: m['conversationId'] as String,
        content: m['content'] as String,
        createdAt: DateTime.parse(
          m['createdAt'] as String,
        ),
        sender: m['sender'] as String,
      );
    }).toList();
  }

  Future<void> addMessage(Message message) async {
    await Amplify.API
        .mutate(
          request: GraphQLRequest<String>(
            document: createMessageMutation,
            variables: <String, dynamic>{
              'conversationId': message.conversationId,
              'content': message.content,
              'createdAt': message.createdAt.toUtc().toString(),
              'sender': message.sender,
            },
          ),
        )
        .response;
  }

  Stream<Message> subscribeToNewMessage(String conversationId) {
    return Amplify.API
        .subscribe(
      GraphQLRequest<String>(
        document: messageSubscription,
        variables: <String, dynamic>{
          'conversationId': conversationId,
        },
      ),
      onEstablished: () => safePrint('Subscription established'),
    )
        .map((m) {
      final data = jsonDecode(m.data!) as Map<String, dynamic>;
      final message = data['subscribeToNewMessage'] as Map<String, dynamic>;

      return Message(
        conversationId: message['conversationId'] as String,
        content: message['content'] as String,
        createdAt: DateTime.parse(
          message['createdAt'] as String,
        ),
        sender: message['sender'] as String,
      );
    });
  }
}
