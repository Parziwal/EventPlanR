using AutoMapper;
using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Models.Chat;
public class ChatMessageDto
{
    public Guid ChatId { get; set; }
    public Guid SenderId { get; set; }
    public string Content { get; set; } = null!;
    public DateTimeOffset CreatedAt { get; set; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<ChatMessageEntity, ChatMessageDto>();
        }
    }
}
