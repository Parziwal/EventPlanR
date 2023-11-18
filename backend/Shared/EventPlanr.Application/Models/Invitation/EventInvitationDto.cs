using AutoMapper;
using EventPlanr.Application.Models.Ticket;
using EventPlanr.Domain.Entities;
using EventPlanr.Domain.Enums;

namespace EventPlanr.Application.Models.Invitation;

public class EventInvitationDto
{
    public Guid Id { get; set; }
    public string UserFirstName { get; set; } = null!;
    public string UserLastName { get; set; } = null!;
    public InvitationStatus Status { get; set; }
    public bool IsCheckedIn { get; set; }
    public DateTimeOffset Created { get; set; }
    public string CreatedBy { get; set; } = null!;

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<InvitationEntity, EventInvitationDto>();
        }
    }
}
