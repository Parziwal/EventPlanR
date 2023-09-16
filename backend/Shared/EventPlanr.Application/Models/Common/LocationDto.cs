namespace EventPlanr.Application.Models.Common;

public class LocationDto : CoordinatesDto
{
    public double Latitude { get; set; }
    public double Longitude { get; set; }
    public double Radius { get; set; }
}
