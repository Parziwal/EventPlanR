using AutoMapper;
using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Models.User;

public class UserClaimDto
{
    public Guid UserId { get; set; }
    public Guid? OrganizationId { get; set; }
    public List<string> OrganizationPolicies { get; set; } = new List<string>();

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<UserClaimEntity, UserClaimDto>()
                .ForMember(dest => dest.OrganizationId, opt => opt.MapFrom(src => src.CurrentOrganizationId))
                .ForMember(dest => dest.OrganizationPolicies,
                    opt => opt.MapFrom(
                        src => src.Organizations
                        .SingleOrDefault(o => o.OrganizationId == src.CurrentOrganizationId,
                            new OrganizationPolicyEntity() { Policies = new List<string>() })
                        .Policies
                    ));
        }
    }
}
