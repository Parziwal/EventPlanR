using AutoMapper;
using Entities = EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Models.Organization;

public class OrganizationDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = null!;
    public string? ProfileImageUrl { get; set; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<Entities.Organization, OrganizationDto>();
        }
    }
}
