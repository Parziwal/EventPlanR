namespace Event.Application.Dto;

public class EventAddressDto
{
    public string Venue { get; set; } = null!;
    public string Country { get; set; } = null!;
    public string ZipCode { get; set; } = null!;
    public string City { get; set; } = null!;
    public string AddressLine { get; set; } = null!;
    public double Longitude { get; set; }
    public double Latitude { get; set; }
}
