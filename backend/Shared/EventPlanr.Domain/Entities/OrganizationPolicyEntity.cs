namespace EventPlanr.Domain.Entities;

public class OrganizationPolicyEntity
{
    public Guid OrganizationId { get; set; }
    public List<string> Policies { get; set; } = new List<string>();
}
