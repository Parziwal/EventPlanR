using NetTopologySuite.Geometries;

namespace Event.Domain.Entities;

public class EventAddress
{
    public string Venue { get; set; } = null!;
    public string Country { get; set; } = null!;
    public string ZipCode { get; set; } = null!;
    public string City { get; set; } = null!;
    public string AddressLine { get; set; } = null!;
    public Point Location { get; set; } = null!;
}
