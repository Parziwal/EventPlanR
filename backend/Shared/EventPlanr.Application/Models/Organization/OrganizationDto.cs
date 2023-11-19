using AutoMapper;
using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Models.Organization;

public class OrganizationDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = null!;
    public string? ProfileImageUrl { get; set; }
    public int EventCount { get; set; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<OrganizationEntity, OrganizationDto>()
                .ForMember(dest => dest.EventCount, opt => opt.MapFrom(src => src.Events.Where(e => e.IsPublished && !e.IsPrivate).Count()));
        }
    }
}
