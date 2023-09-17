using AutoMapper;
using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Models.Organization;

public class OrganizationDetailsDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = null!;
    public string? Description { get; set; }
    public string? ProfileImageUrl { get; set; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<OrganizationEntity, OrganizationDetailsDto>();
        }
    }
}
