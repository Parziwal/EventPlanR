using EventPlanr.Domain.Common;

namespace EventPlanr.Domain.Entities;

public class UserEntity : BaseEntity
{
    public string FirstName { get; set; } = null!;
    public string LastName { get; set; } = null!;
    public string Email { get; set; } = null!;
    public string? Picture { get; set; }
}
