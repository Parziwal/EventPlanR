using AutoMapper;
using EventPlanr.Domain.Entities;
using EventPlanr.Domain.Enums;

namespace EventPlanr.Application.Models.Invitation;

public class UserInvitationDto
{
    public Guid Id { get; set; }
    public string EventName { get; set; } = null!;
    public string OrganizationName { get; set; } = null!;
    public InvitationStatus Status { get; set; }
    public bool IsCheckedIn { get; set; }
    public DateTimeOffset Created { get; set; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<InvitationEntity, UserInvitationDto>()
                .ForMember(dest => dest.EventName, opt => opt.MapFrom(src => src.Event.Name))
                .ForMember(dest => dest.OrganizationName, opt => opt.MapFrom(src => src.Event.Organization.Name));
        }
    }
}
