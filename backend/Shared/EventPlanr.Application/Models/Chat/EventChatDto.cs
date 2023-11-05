using AutoMapper;
using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Models.Chat;

public class EventChatDto
{
    public Guid Id { get; set; }
    public DateTimeOffset LastMessageDate { get; set; }
    public bool HaveUnreadMessages { get; set; }
    public string EventName { get; set; } = null!;
    public string? ProfileImageUrl { get; set; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<ChatEntity, EventChatDto>()
                .ForMember(dest => dest.EventName, opt => opt.MapFrom(src => src.Event!.Name))
                .ForMember(dest => dest.ProfileImageUrl, opt => opt.MapFrom(src => src.Event!.CoverImageUrl));
        }
    }
}
