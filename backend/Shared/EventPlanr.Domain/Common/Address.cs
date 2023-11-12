namespace EventPlanr.Domain.Common;

public class Address
{
    public string Country { get; set; } = null!;
    public string ZipCode { get; set; } = null!;
    public string City { get; set; } = null!;
    public string AddressLine { get; set; } = null!;
}
