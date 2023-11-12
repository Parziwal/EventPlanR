import 'dart:async';

import 'package:event_planr_app/data/disk/persistent_store.dart';
import 'package:event_planr_app/data/network/chat_message_graphql/chat_message_client.dart';
import 'package:event_planr_app/data/network/event_planr_api/chat_manager/chat_manager_client.dart';
import 'package:event_planr_app/data/network/event_planr_api/models/create_direct_chat_command.dart';
import 'package:event_planr_app/data/network/image_upload/image_upload_client.dart';
import 'package:event_planr_app/domain/models/chat/chat.dart';
import 'package:event_planr_app/domain/models/chat/chat_filter.dart';
import 'package:event_planr_app/domain/models/chat/chat_message.dart';
import 'package:event_planr_app/domain/models/chat/create_chat_message.dart';
import 'package:event_planr_app/domain/models/chat/sender.dart';
import 'package:event_planr_app/domain/models/common/paginated_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@singleton
class ChatRepository {
  ChatRepository({
    required ChatManagerClient chatManagerClient,
    required ChatMessageClient chatMessageClient,
    required PersistentStore persistentStore,
    required ImageUploadClient imageUploadClient,
  })  : _chatManagerClient = chatManagerClient,
        _chatMessageClient = chatMessageClient,
        _persistentStore = persistentStore,
        _imageUploadClient = imageUploadClient;

  final ChatManagerClient _chatManagerClient;
  final ChatMessageClient _chatMessageClient;
  final PersistentStore _persistentStore;
  final ImageUploadClient _imageUploadClient;
  Chat? _selectedChat;

  Future<void> setSelectedChat(Chat chat) async {
    _selectedChat = chat;
    await _persistentStore.save('selectedChat', chat);
  }

  Chat? getSelectedChat() {
    return _selectedChat ??=
        _persistentStore.getObject('selectedChat', Chat.fromJson);
  }

  Future<PaginatedList<Chat>> getDirectChats(ChatFilter filter) async {
    if (_selectedChat != null) {
      await _chatManagerClient.postChatmanagerSetreadChatId(
        chatId: _selectedChat!.id,
      );
      _selectedChat = null;
      await _persistentStore.remove('selectedChat');
    }

    final chats = await _chatManagerClient.getChatmanagerDirect(
      pageNumber: filter.pageNumber ?? 1,
      pageSize: filter.pageSize ?? 20,
    );

    return PaginatedList(
      items: chats.items
          .map(
            (c) => Chat(
              id: c.id,
              lastMessageDate: c.lastMessageDate,
              haveUnreadMessage: c.haveUnreadMessages,
              contactFirstName: c.contactFirstName,
              contactLastName: c.contactLastName,
              profileImageUrl: c.profileImageUrl,
            ),
          )
          .toList(),
      pageNumber: chats.pageNumber,
      totalPages: chats.totalPages,
      totalCount: chats.totalCount,
      hasPreviousPage: chats.hasPreviousPage,
      hasNextPage: chats.hasNextPage,
    );
  }

  Future<PaginatedList<Chat>> getEventsChats(ChatFilter filter) async {
    if (_selectedChat != null) {
      await _chatManagerClient.postChatmanagerSetreadChatId(
        chatId: _selectedChat!.id,
      );
      _selectedChat = null;
      await _persistentStore.remove('selectedChat');
    }

    final chats = await _chatManagerClient.getChatmanagerEvent(
      pageNumber: filter.pageNumber ?? 1,
      pageSize: filter.pageSize ?? 20,
    );

    return PaginatedList(
      items: chats.items
          .map(
            (c) => Chat(
              id: c.id,
              lastMessageDate: c.lastMessageDate,
              haveUnreadMessage: c.haveUnreadMessages,
              eventName: c.eventName,
              profileImageUrl: c.profileImageUrl,
            ),
          )
          .toList(),
      pageNumber: chats.pageNumber,
      totalPages: chats.totalPages,
      totalCount: chats.totalCount,
      hasPreviousPage: chats.hasPreviousPage,
      hasNextPage: chats.hasNextPage,
    );
  }

  Future<String> createDirectChat(String contactEmail) async {
    return _chatManagerClient.postChatmanagerDirect(
      body: CreateDirectChatCommand(userEmail: contactEmail),
    );
  }

  Future<List<ChatMessage>> getChatMessages(String chatId) async {
    final messages = await _chatMessageClient.getChatMessages(chatId);

    return messages
        .map(
          (m) => ChatMessage(
            chatId: m.chatId,
            content: m.content,
            createdAt: m.createdAt,
            sender: Sender(
              id: m.sender.id,
              firstName: m.sender.firstName,
              lastName: m.sender.lastName,
              profileImageUrl: m.sender.profileImageUrl != null &&
                  m.sender.profileImageUrl!.length > 1
                  ? m.sender.profileImageUrl : null,
            ),
          ),
        )
        .toList();
  }

  Future<void> createMessage(CreateChatMessage message) async {
    await _chatMessageClient.createMessage(
      chatId: message.chatId,
      content: message.content,
    );
  }

  Stream<ChatMessage> subscribeToNewMessage(String chatId) {
    return _chatMessageClient.subscribeToNewMessage(chatId).map(
          (m) => ChatMessage(
            chatId: m.chatId,
            content: m.content,
            createdAt: m.createdAt,
            sender: Sender(
              id: m.sender.id,
              firstName: m.sender.firstName,
              lastName: m.sender.lastName,
              profileImageUrl: m.sender.profileImageUrl != null &&
                  m.sender.profileImageUrl!.length > 1
                  ? m.sender.profileImageUrl : null,
            ),
          ),
        );
  }

  Future<String> uploadUserProfileImage(XFile image) async {
    return _imageUploadClient.uploadUserProfileImage(image);
  }
}
