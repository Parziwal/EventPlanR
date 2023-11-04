using AutoMapper;
using EventPlanr.Application.Models.User;
using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Models.Chat;
public class ChatMessageDto
{
    public Guid ChatId { get; set; }
    public UserDto Sender { get; set; } = null!;
    public string Content { get; set; } = null!;
    public DateTimeOffset CreatedAt { get; set; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<ChatMessageEntity, ChatMessageDto>()
                .ForMember(dest => dest.Sender, opt => opt.MapFrom(src => new UserDto() { Id = src.SenderId }));
        }
    }
}
