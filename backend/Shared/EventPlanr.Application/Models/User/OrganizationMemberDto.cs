using AutoMapper;
using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Models.User;

public class OrganizationMemberDto
{
    public Guid Id { get; set; }
    public string FirstName { get; set; } = null!;
    public string LastName { get; set; } = null!;
    public string Email { get; set; } = null!;
    public List<string> OrganizationPolicies { get; set; } = new List<string>();

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<UserEntity, OrganizationMemberDto>()
                .ForMember(dest => dest.OrganizationPolicies, opt => opt.Ignore());
        }
    }
}
