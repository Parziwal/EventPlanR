namespace EventPlanr.Domain.Common;

public class BaseSoftDeleteAuditableEntity : BaseAuditableEntity
{
    public bool IsDeleted { get; set; }
    public DateTimeOffset? DeletedAt { get; set; }
}
