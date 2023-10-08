namespace EventPlanr.Application.Security;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = true, Inherited = true)]
public class AuthorizeAttribute : Attribute
{
    public AuthorizeAttribute() { }

    public string OrganizationPolicy { get; set; } = null!;
}