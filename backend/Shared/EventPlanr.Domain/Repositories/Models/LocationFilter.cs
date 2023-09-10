using EventPlanr.Domain.Common;

namespace EventPlanr.Domain.Repositories.Models;

public class LocationFilter : Coordinates
{
    public double Radius { get; set; }
}
