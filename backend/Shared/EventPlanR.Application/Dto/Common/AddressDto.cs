namespace EventPlanr.Application.Dto.Common;

public class AddressDto
{
    public string Country { get; set; } = null!;
    public string ZipCode { get; set; } = null!;
    public string City { get; set; } = null!;
    public string AddressLine { get; set; } = null!;
}
