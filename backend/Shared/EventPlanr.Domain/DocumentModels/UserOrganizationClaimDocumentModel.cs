namespace EventPlanr.Domain.DocumentModels;

public class UserOrganizationClaimDocumentModel
{
    public string UserId { get; set; } = null!;
    public List<Guid> OrganizationIds { get; set; } = new List<Guid>();
}
