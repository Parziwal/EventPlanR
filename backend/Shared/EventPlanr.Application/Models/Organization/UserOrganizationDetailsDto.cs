using AutoMapper;
using EventPlanr.Application.Models.Common;
using EventPlanr.Application.Models.User;
using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Models.Organization;

public class UserOrganizationDetailsDto : BaseAuditableDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = null!;
    public string? Description { get; set; }
    public string? ProfileImageUrl { get; set; }
    public List<OrganizationMemberDto> Members { get; set; } = new List<OrganizationMemberDto>();

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<OrganizationEntity, UserOrganizationDetailsDto>()
                .ForMember(dest => dest.Members, opt => opt.Ignore());
        }
    }
}
