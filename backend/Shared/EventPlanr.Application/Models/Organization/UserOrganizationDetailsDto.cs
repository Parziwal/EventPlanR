using AutoMapper;
using EventPlanr.Application.Models.User;
using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Models.Organization;

public class UserOrganizationDetailsDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = null!;
    public string? Description { get; set; }
    public string? ProfileImageUrl { get; set; }
    public List<UserDto> Members { get; set; } = new List<UserDto>();

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<OrganizationEntity, UserOrganizationDetailsDto>()
                .ForMember(dest => dest.Members, opt => opt.Ignore());
        }
    }
}
