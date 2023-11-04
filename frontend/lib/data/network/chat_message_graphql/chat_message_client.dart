import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:event_planr_app/data/network/chat_message_graphql/models/chat_message_dto.dart';
import 'package:injectable/injectable.dart';

@singleton
class ChatMessageClient {
  static const _getChatMessagesQuery = r'''
      query getChatMessages($chatId: ID!) {
        getChatMessages(ChatId: $chatId) {
          ChatId
          Content
          CreatedAt
          Sender {
            Id
            FirstName
            LastName
            ProfileImageUrl
          }
        }
      }
    ''';
  static const _createMessageMutation = r'''
      mutation createMessage($chatId: ID!, $content: String!) {
        createMessage(ChatId: $chatId, Content: $content) {
          ChatId
          Content
          CreatedAt
          Sender {
            Id
            FirstName
            LastName
            ProfileImageUrl
          }
        }
      }
    ''';
  static const _subscribeToNewMessageSubscription = r'''
      subscription subscribeToNewMessage($chatId: ID!) {
        subscribeToNewMessage(ChatId: $chatId) {
          ChatId
          Content
          CreatedAt
          Sender {
            Id
            FirstName
            LastName
            ProfileImageUrl
          }
        }
      }
    ''';

  Future<List<ChatMessageDto>> getChatMessages(String chatId) async {
    final result = await Amplify.API
        .query(
          request: GraphQLRequest<String>(
            document: _getChatMessagesQuery,
            variables: <String, dynamic>{
              'chatId': chatId,
            },
          ),
        )
        .response;

    final data = jsonDecode(result.data!) as Map<String, dynamic>;
    final messages = data['getChatMessages'] as List<dynamic>;

    return messages.map((m) {
      return ChatMessageDto.fromJson(m as Map<String, dynamic>);
    }).toList();
  }

  Future<void> createMessage({
    required String chatId,
    required String content,
  }) async {
    await Amplify.API
        .mutate(
          request: GraphQLRequest<String>(
            document: _createMessageMutation,
            variables: <String, dynamic>{
              'chatId': chatId,
              'content': content,
            },
          ),
        )
        .response;
  }

  Stream<ChatMessageDto> subscribeToNewMessage(String chatId) {
    return Amplify.API
        .subscribe(
      GraphQLRequest<String>(
        document: _subscribeToNewMessageSubscription,
        variables: <String, dynamic>{
          'chatId': chatId,
        },
      ),
      onEstablished: () => safePrint('Subscription established'),
    )
        .map((m) {
      final data = jsonDecode(m.data!) as Map<String, dynamic>;
      final message = data['subscribeToNewMessage'] as Map<String, dynamic>;

      return ChatMessageDto.fromJson(message);
    });
  }
}
