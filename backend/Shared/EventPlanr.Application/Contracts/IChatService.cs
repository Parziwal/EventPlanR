using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Contracts;

public interface IChatService
{
    Task<List<ChatMessageEntity>> GetChatMessagesAsync(Guid chatId);
    Task AddMessageToChat(ChatMessageEntity message);
}
