namespace EventPlanr.Domain.Entities;

public class UserClaimEntity
{
    public Guid UserId { get; set; }
    public Guid? CurrentOrganizationId { get; set; }
    public List<OrganizationPolicyEntity> Organizations { get; set; } = new List<OrganizationPolicyEntity>();
}
