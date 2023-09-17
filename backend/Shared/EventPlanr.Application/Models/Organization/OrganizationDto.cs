using AutoMapper;
using EventPlanr.Domain.Entities;

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
            CreateMap<OrganizationEntity, OrganizationDto>();
        }
    }
}
