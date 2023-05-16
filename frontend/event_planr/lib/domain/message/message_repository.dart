import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:event_planr/data/network/message_api.dart';
import 'package:event_planr/domain/auth/auth_repository.dart';
import 'package:event_planr/domain/message/models/message.dart';
import 'package:event_planr/domain/message/models/user.dart';
import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';

@singleton
class MessageRepository {
  MessageRepository(this.messageApi, this.authRepository, this.graphQLClient);

  final MessageApi messageApi;
  final AuthRepository authRepository;
  final GraphQLClient graphQLClient;

  Future<List<User>> getUsers() async {
    final users = await messageApi.getUsers();
    final currentUser = await authRepository.user;
    return users
        .where((u) => u.email != currentUser.email)
        .map((u) => User(email: u.email, name: u.name))
        .toList();
  }

  Future<List<Message>> getMessages(String conversationId) async {
    const allMessages = r'''
      query allMessages($conversationId: ID!) {
        allMessages(conversationId: $conversationId) {
          content
          conversationId
          createdAt
          sender
        }
      }
    ''';

    final options = QueryOptions(
      document: gql(allMessages),
      variables: <String, dynamic>{
        'conversationId': conversationId,
      },
      fetchPolicy: FetchPolicy.noCache,
    );

    final result = await graphQLClient.query(options);

    return (result.data!['allMessages'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .reversed
        .map(
          (m) => Message(
            conversationId: m['conversationId'] as String,
            content: m['content'] as String,
            createdAt: DateTime.parse(m['createdAt'] as String),
            sender: m['sender'] as String,
          ),
        )
        .toList();
  }

  Future<void> addMessage(Message message) async {
    const createMessage = r'''
      mutation createMessage($conversationId: ID!, $content: String!, $createdAt: String!, $sender: String!) {
        createMessage(content: $content, conversationId: $conversationId, createdAt: $createdAt, sender: $sender) {
          content
          conversationId
          createdAt
          sender
        }
      }
    ''';

    final options = MutationOptions(
      document: gql(createMessage),
      variables: <String, dynamic>{
        'conversationId': message.conversationId,
        'content': message.content,
        'createdAt': message.createdAt.toUtc().toString(),
        'sender': message.sender,
      },
    );

    await graphQLClient.mutate(options);
  }

  Stream<Message> subscribeToNewMessage(String conversationId) {
    const messageSubscription = r'''
      subscription subscribeToNewMessage($conversationId: ID!) {
        subscribeToNewMessage(conversationId: $conversationId) {
          content
          conversationId
          createdAt
          sender
        }
      }
    ''';
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
